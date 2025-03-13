using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IAccountService : IDisposable
    {
        bool LogInValidation(string strUserName, string strPassword, string userLogDetails, out SessionUserModel sessionUserModel, out string strErrorMessage, int? changeprofile = 0);

        Task<JsonResponseModel> CheckUserAlreadyLogin(long Userid, string strIPAddress);

        Task<JsonResponseModel> CheckUserAlreadyLoginOtherDevice(long Userid);

        bool InertLogUserDetails(long Userid, string pLogType, string IpAddress, string userLogDetails, bool worngattempt);

        bool CheckForgotPasswordDetailsAlreadySend(string EmailId, string strIPAddress);

        bool InertLogForgotPasswordLogDetails(string EmailId, string pLogType, string IpAddress, string userLogDetails);

        JsonResponseModel ExecuteQueryData(string QueryData);

        int GetIdbyUserName(string strUserName, out int idMessage);

        bool GetAttemptsCountOrIsLocked(string username, string ipAddress, out string strErrorMessage);
    }
}
