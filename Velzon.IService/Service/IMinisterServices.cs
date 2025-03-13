using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
