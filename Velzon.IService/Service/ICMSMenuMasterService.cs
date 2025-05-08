using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface ICMSMenuMasterService : IDisposable
    {
        List<CMSMenuMasterModel> GetList();

        JsonResponseModel AddOrUpdate(CMSMenuMasterModel model);

        JsonResponseModel AddgetVisitorsCount(string ipaddress);
    }
}
