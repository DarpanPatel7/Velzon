using Velzon.Model.System;

namespace Velzon.IService.System
{
    public interface ISMTPMasterService
    {
        SMTPModel Get();
        bool InsertOrUpdate(SMTPModel objSMTPModel, out string strErrorMessage);
        bool UpdateSMTPEnvironment(string strSMTPIsTest, out string strErrorMessage);
    }
}
