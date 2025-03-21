using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IUserMasterService : IDisposable
    {
        UserMasterModel Get(long id);

        List<UserMasterModel> GetList();

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(UserMasterModel model);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);

        JsonResponseModel ChangePassword(ChangePasswordModel model);
    }
}
