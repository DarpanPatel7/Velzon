using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface ICommonService : IDisposable
    {
        List<LanguageMasterModel> GetListLanguage();

        JsonResponseModel AddOrGetVisitorsCount(string ipaddress);

        CommonModel UpdateSiteDate(long lgLangId = 1);
    }
}