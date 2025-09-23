using Velzon.Model.System;

namespace Velzon.IService.System
{
    public interface ISiteService : IDisposable
    {
        SiteModel Get();

        bool InsertOrUpdate(SiteModel objSiteModel, out string strErrorMessage);
    }
}
