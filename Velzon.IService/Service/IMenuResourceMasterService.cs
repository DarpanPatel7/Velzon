using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IMenuResourceMasterService :IDisposable
    {
        MenuResourceMasterModel Get(long id);

        List<MenuResourceMasterModel> GetList();

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(MenuResourceMasterModel model);

    }
}
