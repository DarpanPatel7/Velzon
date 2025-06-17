using Velzon.Common;
using Velzon.IService.System;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Services.System
{
    public class SiteService : ISiteService
    {

        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public SiteService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public SiteModel Get()
        {
            try
            {
                var data = dapperConnection.GetListResult<SiteModel>("GetSiteSettings", CommandType.StoredProcedure).FirstOrDefault();
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into GetSiteSettings", ex.ToString(), "SiteService", "Get");
                return null;
            }
        }

        public bool InsertOrUpdate(SiteModel objSMTPModel, out string strErrorMessage)
        {
            bool isError = true;
            strErrorMessage = "";

            try
            {

                #region Validation
                if (string.IsNullOrWhiteSpace(objSMTPModel.SiteName))
                {
                    strErrorMessage = "Please Enter SiteName.";
                    isError = false;
                    return isError;
                }

                /*if (string.IsNullOrWhiteSpace(objSMTPModel.CouchDBDbName))
                {
                    strErrorMessage = "Please Enter CouchDBDbName.";
                    isError = false;
                    return isError;
                }

                if (string.IsNullOrWhiteSpace(objSMTPModel.CouchDBUser))
                {
                    strErrorMessage = "Please Enter CouchDBUser.";
                    isError = false;
                    return isError;
                }*/
                #endregion

                Dictionary<string, object> dictionary = new Dictionary<string, object>();

                dictionary.Add("SiteName", objSMTPModel.SiteName);
                dictionary.Add("SiteFaviconWhite", objSMTPModel.SiteFaviconWhite);
                dictionary.Add("SiteFaviconDark", objSMTPModel.SiteFaviconDark);
                dictionary.Add("SiteLogoWhite", objSMTPModel.SiteLogoWhite);
                dictionary.Add("SiteLogoDark", objSMTPModel.SiteLogoDark);

                var userData = dapperConnection.ExecuteWithoutResult("InsertOrUpdateSiteSetting", CommandType.StoredProcedure, dictionary);
                if (userData != false)
                {
                    strErrorMessage = "CouchDB Setting Updated Successfully.";
                    isError = true;
                }
                else
                {
                    strErrorMessage = "CouchDB Setting not Updated.";
                    isError = false;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into InsertOrUpdateSiteSetting", ex.ToString(), "SiteService", "InsertOrUpdate");
                strErrorMessage = ex.Message;
                isError = false;
            }


            return isError;
        }

        #endregion

        #region Disposing Method(s)

        private bool disposed;

        /// <summary>
        /// Destructor
        /// </summary>
        ~SiteService()
        {
            this.Dispose(false);
        }

        /// <summary>
        /// The dispose method that implements IDisposable.
        /// </summary>
        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        /// The virtual dispose method that allows
        /// classes inherithed from this one to dispose their resources.
        /// </summary>
        /// <param name="disposing"></param>
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    // Dispose managed resources here.
                }

                // Dispose unmanaged resources here.
            }

            disposed = true;
        }

        #endregion

    }

}
