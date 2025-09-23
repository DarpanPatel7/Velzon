using Velzon.Model.Service;

namespace Velzon.IService.Service
{
    public interface IGlobleSerchService:IDisposable
    {
        List<GlobleSerchModel> GetList(string SearchText, long lgLangId);
    }
}
