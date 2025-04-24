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
    public class NewsMasterService : INewsMasterService
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public NewsMasterService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public NewsModel Get(long id, long lgLangId = 1)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList(lgLangId).Where(x => x.Id == id).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllNewsMaster", ex.ToString(), "NewsMasterService", "Get");
                return null;
            }
        }

        public NewsModel GetMenuRes(long NewsId, long lgLangId = 1)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList(lgLangId).Where(x => x.NewsId == NewsId).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllNewsMaster", ex.ToString(), "NewsMasterService", "Get");
                return null;
            }
        }

        public List<NewsModel> GetList(long lgLangId = 1)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("LangId", lgLangId);
                var data = dapperConnection.GetListResult<NewsModel>("cmsGetAllNewsMaster", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x =>
                {
                    x.Id = (long)x.NewsId;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllNewsMaster", ex.ToString(), "NewsMasterService", "GetList");
                return null;
            }
        }

        public List<NewsModel> GetListFront(long lgLangId = 1, string? type = null)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pLangId", lgLangId);
                dictionary.Add("pType", type);
                var data = dapperConnection.GetListResult<NewsModel>("frontGetAllNewsMaster", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x =>
                {
                    x.Id = (long)x.NewsId;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into frontGetAllNewsMaster", ex.ToString(), "NewsMasterService", "GetListFront");
                return null;
            }
        }

        public JsonResponseModel Delete(long id, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", id);
                dictionary.Add("pUsername", username);
                dapperConnection.GetListResult<NewsModel>("cmsRemoveNewsMaster", CommandType.StoredProcedure, dictionary).ToList();

                jsonResponseModel.strMessage = "Record removed successfully!";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveNewsMaster", ex.ToString(), "NewsMasterService", "Delete");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel AddOrUpdate(NewsModel model, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                if (string.IsNullOrWhiteSpace(model.ImageName))
                {
                    model.ImageName = "";
                }
                if (string.IsNullOrWhiteSpace(model.ImagePath))
                {
                    model.ImagePath = "";
                }
                if (model.Id != 0)
                {
                    var dataModel = Get(model.Id);
                    if (dataModel != null)
                    {
                        if (string.IsNullOrWhiteSpace(model.ImagePath))
                        {
                            model.ImageName = dataModel.ImageName;
                            model.ImagePath = dataModel.ImagePath;
                        }
                    }
                }
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", model.Id);
                dictionary.Add("pLanguageId", model.LanguageId);
                dictionary.Add("pNewsId", model.NewsId);
                dictionary.Add("pNewsTypeId", model.NewsTypeId);
                dictionary.Add("pNewsTitle", model.NewsTitle);
                dictionary.Add("pShortDescription", model.ShortDescription);
                dictionary.Add("pNewsDesc", model.NewsDesc);
                dictionary.Add("pNewsBy", model.NewsBy);
                dictionary.Add("pPublicDate", model.PublicDate);
                dictionary.Add("pArchiveDate", model.ArchiveDate);
                dictionary.Add("pImageName", model.ImageName);
                dictionary.Add("pImagePath", model.ImagePath);
                dictionary.Add("pLocation", model.Location);
                dictionary.Add("pIsActive", model.IsActive);
                dictionary.Add("pIsLink", model.IsLink);
                dictionary.Add("pMetaTitle", model.MetaTitle);
                dictionary.Add("pMetaDescription", model.MetaDescription);
                dictionary.Add("pUsername", username);

                var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateNewsMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (model.Id == 0)
                {
                    jsonResponseModel.strMessage = "Record inserted successfully";
                    jsonResponseModel.isError = false;
                    jsonResponseModel.type = PopupMessageType.success.ToString();
                }
                else
                {
                    jsonResponseModel.strMessage = "Record updated successfully";
                    jsonResponseModel.isError = false;
                    jsonResponseModel.type = PopupMessageType.success.ToString();
                }
                model.Id = (long)data;

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsInsertOrUpdateNewsMaster", ex.ToString(), "NewsMasterService", "AddOrUpdate");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel UpdateStatus(long id, string username, int isActive)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", id);
                dictionary.Add("pIsActive", isActive);
                dictionary.Add("pUsername", username);
                dapperConnection.GetListResult<UserMasterModel>("cmsUpdateStatusNewsMaster", CommandType.StoredProcedure, dictionary).ToList();

                jsonResponseModel.strMessage = "Record updated successfully!";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsUpdateStatusNewsMaster", ex.ToString(), "NewsMasterService", "UpdateStatus");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public List<NewsType> GetNewsType()
        {
            try
            {
                return dapperConnection.GetListResult<NewsType>("cmsGetAllNewsMasterType", CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllNewsMasterType", ex.ToString(), "NewsMasterService", "GetNewsType");
                return null;
            }
        }

        #endregion

        #region Disposing Method(s)

        private bool disposed;

        /// <summary>
        /// Destructor
        /// </summary>
        ~NewsMasterService()
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
