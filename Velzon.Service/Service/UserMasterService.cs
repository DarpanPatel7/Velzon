using Velzon.Model.Service;
using Velzon.Common;
using System.Data;
using Velzon.IService.Service;
using Velzon.Model.System;

namespace Velzon.Services.Service
{
    public class UserMasterService : IUserMasterService
    {

        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public UserMasterService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public UserMasterModel Get(long id)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList().Where(x => x.Id == id).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllUserMaster", ex.ToString(), "UserMasterService", "Get");
                return null;
            }
        }

        public List<UserMasterModel> GetList()
        {
            try
            {
                return dapperConnection.GetListResult<UserMasterModel>("cmsGetAllUserMaster", CommandType.StoredProcedure).ToList();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllUserMaster", ex.ToString(), "UserMasterService", "GetList");
                return null;
            }
        }

        public JsonResponseModel Delete(long id, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("Id", id);
                dictionary.Add("ChangedBy", username);
                dapperConnection.GetListResult<UserMasterModel>("cmsRemoveUserMaster", CommandType.StoredProcedure, dictionary).ToList();

                jsonResponseModel.strMessage = "Record removed successfully!";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveUserMaster", ex.ToString(), "UserMasterService", "Delete");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel AddOrUpdate(UserMasterModel model)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {

                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", model.Id);
                dictionary.Add("pRoleId", model.RoleId);
                dictionary.Add("pFirstName", model.FirstName);
                dictionary.Add("pLastName", model.LastName);
                dictionary.Add("pPhoneNo", model.PhoneNo);
                dictionary.Add("pEmail", model.Email);
                dictionary.Add("pUsername", model.Username);
                dictionary.Add("pUserPassword", model.UserPassword);
                dictionary.Add("pIsActive", model.IsActive);
                dictionary.Add("pChangedBy", model.CreatedBy);

                var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateUserMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

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
                ErrorLogger.Error("Error Into cmsInsertOrUpdateUserMaster", ex.ToString(), "UserMasterService", "AddOrUpdate");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel ChangePassword(ChangePasswordModel model)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {

                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", model.Id);
                dictionary.Add("pUserPassword", model.NewPassword);
                dictionary.Add("pChangedBy", model.CreateBy);

                var data = dapperConnection.GetListResult<long>("cmsChangePassword", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                objreturn.isError = false;
                model.Id = (int)data;

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsChangePassword", ex.ToString(), "UserMasterService", "AddOrUpdate");
                objreturn.isError = true;
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
                dapperConnection.GetListResult<UserMasterModel>("cmsUpdateStatusUserMaster", CommandType.StoredProcedure, dictionary).ToList();

                jsonResponseModel.strMessage = "Record updated successfully!";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsUpdateStatusUserMaster", ex.ToString(), "UserMasterService", "UpdateStatus");
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
        ~UserMasterService()
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
