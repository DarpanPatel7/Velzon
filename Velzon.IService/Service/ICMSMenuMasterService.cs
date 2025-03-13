using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface ICMSMenuMasterService : IDisposable
    {
        CMSMenuMasterModel Get(long id);

        List<CMSMenuMasterModel> GetList();

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(CMSMenuMasterModel model);

        JsonResponseModel SwapSequance(long rank, string dir, string username);

        JsonResponseModel SetHomePageInCMSMenu(long id);

        JsonResponseModel AddgetVisitorsCount(string ipaddress);
    }
}
