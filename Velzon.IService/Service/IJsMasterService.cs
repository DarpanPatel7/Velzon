using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IJsMasterService : IDisposable
    {
        JSMasterModel Get(long id, long lgLangId = 1);

        List<JSMasterModel> GetList(long lgLangId = 1);

        JsonResponseModel AddOrUpdate(JSMasterModel model, string username);

        JsonResponseModel Delete(long id, string username);

        List<JSMasterModel> JSMasterSiteData();

        JSMasterModel GetJSFileByName(string strFileName);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}
