using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Velzon.Services.Service
{
    public class UtilityService : IUtilityService
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public UtilityService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public UtilityModel Get(long id)
        {
            try
            {
                return GetList().Where(x => x.Id == id).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllUtilityLockedUsers", ex.ToString(), "UtilityService", "Get");
                return null;
            }
        }

        public List<UtilityModel> GetList()
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                var data = dapperConnection.GetListResult<UtilityModel>("cmsGetAllUtilityLockedUsers", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x =>
                {
                    x.Id = (long)x.UserId;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllUtilityLockedUsers", ex.ToString(), "UtilityService", "GetList");
                return null;
            }
        }

        public JsonResponseModel AddOrUpdate(UtilityModel model, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();

                dictionary.Add("pLock", model.plock);
                dictionary.Add("pUserId", model.FormUserId);
                dictionary.Add("pUsername", username);

                var data = dapperConnection.GetListResult<long>("cmsLockUnlockUserUtility", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (model.plock == 0)
                {
                    jsonResponseModel.strMessage = "User unlock successfully.";
                    jsonResponseModel.isError = false;
                    jsonResponseModel.type = PopupMessageType.success.ToString();
                }

                if (model.plock == 1)
                {
                    jsonResponseModel.strMessage = "User lock successfully.";
                    jsonResponseModel.isError = false;
                    jsonResponseModel.type = PopupMessageType.success.ToString();

                }
                model.Id = (long)data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsLockUnlockUserUtility", ex.ToString(), "UtilityService", "AddOrUpdate");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        #endregion

        #region Disposing Method(s)

        private bool disposed;

        /// <summary>
        /// Destructor
        /// </summary>
        ~UtilityService()
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
