using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IGoiLogoServices : IDisposable
    {
        GoiLogoModel Get(long id, long lgLangId = 1);

        List<GoiLogoModel> GetList(long lgLangId = 1);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(GoiLogoModel model, string username);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}
