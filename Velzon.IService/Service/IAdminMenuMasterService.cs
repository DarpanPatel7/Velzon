using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IAdminMenuMasterService : IDisposable
    {
        AdminMenuMasterModel Get(long id);

        List<AdminMenuMasterModel> GetList();

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(AdminMenuMasterModel model);

        JsonResponseModel SwapSequance(long rank, string dir, string username, string type, long parentid);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);

        SearchMenuModel GetSearch(long roleid, string search);
    }
}
