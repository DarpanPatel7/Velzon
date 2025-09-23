using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IUtilityService : IDisposable
    {
        UtilityModel Get(long id);

        List<UtilityModel> GetList();

        JsonResponseModel AddOrUpdate(UtilityModel model, string usernasmr);
    }
}
