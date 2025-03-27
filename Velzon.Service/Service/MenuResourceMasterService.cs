using Velzon.Model.Service;
using System.Data;
using Velzon.IService.Service;
using Velzon.Common;
using Velzon.Model.System;

namespace Velzon.Services.Service
{
    public class MenuResourceMasterService : IMenuResourceMasterService
    {

        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public MenuResourceMasterService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public MenuResourceMasterModel Get(long id)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList().Where(x => x.Id == id).FirstOrDefault();
            }catch (Exception ex)
            {

                ErrorLogger.Error("Error Into cmsGetAllMenuResourceMaster", ex.ToString(), "MenuResourceMasterService", "Get");
                return null;
            }
        }

        public List<MenuResourceMasterModel> GetList()
        {
            try
            {
                return dapperConnection.GetListResult<MenuResourceMasterModel>("cmsGetAllMenuResourceMaster", CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex)
            {

                ErrorLogger.Error("Error Into cmsGetAllMenuResourceMaster", ex.ToString(), "MenuResourceMasterService", "GetList");
                return null;
            }
        }

        public JsonResponseModel Delete(long id, string username)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("Id", id);
                dictionary.Add("ChangedBy", username);
                dapperConnection.GetListResult<MenuResourceMasterModel>("cmsRemoveMenuResourceMaster", CommandType.StoredProcedure, dictionary).ToList();

                objreturn.strMessage = "Record removed successfully!";
                objreturn.isError = false;
                objreturn.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveMenuResourceMaster", ex.ToString(), "MenuResourceMasterService", "Delete");
                objreturn.strMessage = ex.Message;
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return objreturn;
        }

        public JsonResponseModel AddOrUpdate(MenuResourceMasterModel model)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {

                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("Id", model.Id);
                dictionary.Add("MenuName", model.MenuName);
                dictionary.Add("MenuURL", model.MenuURL);
                dictionary.Add("IsActive", model.IsActive);
                dictionary.Add("ChangedBy", model.CreatedBy);

                var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateMenuResourceMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (model.Id == 0)
                {
                    objreturn.strMessage = "Record inserted successfully";
                    objreturn.isError = false;
                    objreturn.type = PopupMessageType.success.ToString();
                }
                else
                {
                    objreturn.strMessage = "Record updated successfully";
                    objreturn.isError = false;
                    objreturn.type = PopupMessageType.success.ToString();
                }
                model.Id = (long)data;

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsInsertOrUpdateMenuResourceMaster", ex.ToString(), "MenuResourceMasterService", "AddOrUpdate");
                objreturn.strMessage = ex.Message;
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return objreturn;
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
                dapperConnection.GetListResult<MenuResourceMasterModel>("cmsUpdateStatusMenuResourceMaster", CommandType.StoredProcedure, dictionary).ToList();

                jsonResponseModel.strMessage = "Record updated successfully!";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsUpdateStatusMenuResourceMaster", ex.ToString(), "MenuResourceMasterService", "UpdateStatus");
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
        ~MenuResourceMasterService()
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
