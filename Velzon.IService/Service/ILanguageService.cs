using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface ILanguageService : IDisposable
    {
        LanguageMasterModel Get(long id);
        
        List<LanguageMasterModel> GetList();

        List<LanguageMasterModel> GetListById(long id);

        JsonResponseModel Delete(long id, long userId);

        JsonResponseModel AddorUpdate(LanguageMasterModel model, long userId);
    }
}
