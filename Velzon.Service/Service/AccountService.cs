
using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using System.Data;

namespace Velzon.Services.Service
{
    public class AccountService : IAccountService
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public AccountService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public bool LogInValidation(string strUserName, string strPassword, string userLogDetails, out SessionUserModel sessionUserModel, out string strErrorMessage, int? changeProfile = 0)
        {
            bool isError = true;
            strErrorMessage = "";
            sessionUserModel = null;
            try
            {
                if (string.IsNullOrWhiteSpace(strUserName))
                {
                    strErrorMessage = "Please Enter UserName.";
                    isError = false;
                    return isError;

                }
                if (string.IsNullOrWhiteSpace(strPassword))
                {
                    strErrorMessage = "Please Enter Password.";
                    isError = false;
                    return isError;
                }

                // Handle profile change scenario
                if (changeProfile != 1)
                {
                    strUserName = Functions.FrontDecrypt(strUserName);
                }

                // Decrypt and then re-encrypt the password
                strPassword = Functions.Encrypt(Functions.Decrypt(strPassword));

                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("P_userusername", strUserName);
                dictionary.Add("P_userpassword", strPassword);

                var userData = dapperConnection.GetListResult<SessionUserModel>("cmsGetLoginUsersMaster", CommandType.StoredProcedure, dictionary).ToList();
                // Check if userData is null or empty
                if (userData == null || userData.Count == 0)
                {
                    strErrorMessage = "No such username or password.";
                    isError = false;
                    return isError;
                }

                var user = userData.FirstOrDefault();

                // Check if user account is active
                if (!user.IsActive)
                {
                    strErrorMessage = "Your account has been temporarily disabled. Please contact the administrator to restore access.";
                    isError = false;
                    return isError;
                }

                // Check if user role is active
                if (user.IsRoleActive == false)
                {
                    strErrorMessage = "Your account doesn't have the required role or it might be inactive. Please contact the administrator.";
                    isError = false;
                    return isError;
                }

                // User is valid
                sessionUserModel = user;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetLoginUsersMaster", ex.ToString(), "AccountService", "LogInValidation");
                strErrorMessage = ex.Message;
                isError = false;
            }
            return isError;
        }

        class mdl
        {
            public bool AllowLogin { get; set; }
        }

        public async Task<JsonResponseModel> CheckUserAlreadyLogin(long Userid, string strIPAddress)
        {
            //bool isError = true;
            JsonResponseModel model = new JsonResponseModel();
            model.isError = true;
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pUserId", Userid);
                dictionary.Add("pIPAddress", strIPAddress);
                var userData = dapperConnection.GetListResult<mdl>("cmsCheckUserDetails", CommandType.StoredProcedure, dictionary).FirstOrDefault();
                if (userData != null)
                {
                    model.isError = userData.AllowLogin;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsCheckUserDetails", ex.ToString(), "AccountService", "CheckUserAlreadyLogin");
                model.isError = false;
            }
            return model;
        }

        class mdlogin
        {
            public bool DeviceAllowLogin { get; set; }
        }

        public async Task<JsonResponseModel> CheckUserAlreadyLoginOtherDevice(long Userid)
        {
            JsonResponseModel model = new JsonResponseModel();
            model.isError = true;
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pUserId", Userid);

                var userData = dapperConnection.GetListResult<mdlogin>("cmsCheckUserDetailsByDevice", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (userData != null)
                {
                    model.isError = userData.DeviceAllowLogin;
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsCheckUserDetailsByDevice", ex.ToString(), "AccountService", "CheckUserAlreadyLoginOtherDevice");
                model.isError = false;
            }
            return model;
        }

        public bool InertLogUserDetails(long Userid, string pLogType, string IpAddress, string userLogDetails, bool worngattempt)
        {
            bool isError = true;
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pUserId", Userid);
                dictionary.Add("pLogType", pLogType);
                dictionary.Add("pIPAddress", IpAddress);
                dictionary.Add("pDetails", userLogDetails);
                dictionary.Add("pWorngattempt", worngattempt);
                dapperConnection.ExecuteWithoutResult("cmsInsertLogUserDetails", CommandType.StoredProcedure, dictionary);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsInsertLogUserDetails", ex.ToString(), "AccountService", "InertLogUserDetails");
                isError = false;
            }
            return isError;
        }

        class mdlMail
        {
            public bool AllowLogin { get; set; }
        }

        public bool CheckForgotPasswordDetailsAlreadySend(string EmailId, string strIPAddress)
        {
            bool isError = true;
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pEmailId", EmailId);
                dictionary.Add("pIPAddress", strIPAddress);

                var userData = dapperConnection.GetListResult<mdlMail>("cmsCheckForgotPasswordDetails", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (userData != null)
                {
                    isError = userData.AllowLogin;
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsCheckForgotPasswordDetails", ex.ToString(), "AccountService", "CheckForgotPasswordDetailsAlreadySend");
                isError = false;
            }
            return isError;
        }

        public bool InertLogForgotPasswordLogDetails(string EmailId, string pLogType, string IpAddress, string userLogDetails)
        {
            bool isError = true;

            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pEmailId", EmailId);
                dictionary.Add("pLogType", pLogType);
                dictionary.Add("pIPAddress", IpAddress);
                dictionary.Add("pDetails", userLogDetails);
                dapperConnection.ExecuteWithoutResult("cmsInsertForgotPasswordLogDetails", CommandType.StoredProcedure, dictionary);

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsInsertForgotPasswordLogDetails", ex.ToString(), "AccountService", "InertLogForgotPasswordLogDetails");
                isError = false;
            }
            return isError;
        }

        public JsonResponseModel ExecuteQueryData(string QueryData)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                var rslt = dapperConnection.GetDataTable(QueryData, CommandType.Text, out string strError);
                jsonResponseModel.result = Functions.ConvertDataTableToHTML(rslt);
                jsonResponseModel.strMessage = "Record executed success";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into ExecuteQueryData", ex.ToString(), "AccountService", "ExecuteQueryData");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }

            return jsonResponseModel;
        }

        public int GetIdbyUserName(string strUserName, out int idMessage)
        {
            bool isError = true;
            idMessage = 0;

            try
            {
                strUserName = Functions.FrontDecrypt(strUserName);

                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("Puserusername", strUserName);

                var userData = dapperConnection.GetListResult<SessionUserModel>("cmsGetUserIdByUserName", CommandType.StoredProcedure, dictionary).ToList();
                if (userData != null)
                {
                    if (userData.Count() > 0)
                    {
                        idMessage = (int)userData[0].Id;
                        //db.InsertUserLogInLogDetails(userData.FirstOrDefault().Id, userLogDetails);
                    }
                    else
                    {
                        idMessage = 0;
                        isError = false;
                    }
                }
                else
                {
                    idMessage = 0;
                    isError = false;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetUserIdByUserName", ex.ToString(), "AccountService", "GetIdbyUserName");

                isError = false;
            }


            return idMessage;
        }

        public bool GetAttemptsCountOrIsLocked(string username, string ipAddress, out string strErrorMessage)
        {
            strErrorMessage = "";

            try
            {
                // Decrypt the username
                username = Functions.FrontDecrypt(username);

                // Prepare the stored procedure parameters
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pUserName", username);
                dictionary.Add("pipAddress", ipAddress);

                // Execute stored procedure to get wrong attempt count
                var userData = dapperConnection.GetListResult<AttmptOrLockModel>("cmsGetWrongAttemptCount", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                // Get the number of attempts and check lock status
                var attempts = userData.AttemptsLogin;
                var isLock = userData.IsLocked; // Assuming this property exists in AttmptOrLockModel

                // Validate against attempt limits
                int attemptLimit = int.TryParse(ConfigDetailsValue.WrongLoginAttemtLimit, out var resultAttemptLimit) ? resultAttemptLimit : 3;
                int attemptInterval = int.TryParse(ConfigDetailsValue.IntervalWrongAttemptInMinutes, out var resultAttemptInterval) ? resultAttemptInterval : 15;
                string formattedInterval = (attemptInterval >= 60) ? $"{attemptInterval / 60} Hour(s)" : $"{attemptInterval} Minute(s)";

                if (isLock > 0)
                {
                    strErrorMessage = "Your account has been locked by an administrator, Please contact administrator to unlock";
                    return false;
                }

                if (attempts >= attemptLimit)
                {
                    strErrorMessage = "Your account has been locked, Please try again after " + formattedInterval + " or contact support for an administrator";
                    return false;
                }
            }
            catch (Exception ex)
            {
                // Log the error
                ErrorLogger.Error("Error in cmsGetWrongAttemptCount", ex.ToString(), "AccountService", "GetAttemptsCount");
                strErrorMessage = ex.Message;
                return false;
            }

            return true;
        }

        #endregion

        #region Disposing Method(s)

        private bool disposed;

        /// <summary>
        /// Destructor
        /// </summary>
        ~AccountService()
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

