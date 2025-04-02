using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IRoleMasterService : IDisposable
    {
        RoleMasterModel Get(long id);

        List<RoleMasterModel> GetList();

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(RoleMasterModel model);

        List<UserMasterModel> CheckRoleAssignedUser(long roleId);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}
