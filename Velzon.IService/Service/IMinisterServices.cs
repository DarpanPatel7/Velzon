using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
  public interface IMinisterServices : IDisposable
    {
        MinisterModel Get(long id, long lgLangId = 1);

        List<MinisterModel> GetList(long lgLangId = 1);

        List<MinisterModel> GetListFront(long lgLangId = 1);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(MinisterModel model, string username);

        JsonResponseModel SwapSequance(long rank, string dir, string username);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}
