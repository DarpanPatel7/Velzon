using Velzon.Model.System;

namespace Velzon.IService.System
{
    public interface ICouchDBMasterService : IDisposable
    {
        CouchDBModel Get();

        bool InsertOrUpdate(CouchDBModel objSMTPModel, out string strErrorMessage);
    }
}
