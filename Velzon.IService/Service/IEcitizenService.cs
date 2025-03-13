using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.IService.Service
{
    public interface IEcitizenService : IDisposable
    {
        EcitizenModel Get(long id, long lgLangId = 1);

        List<EcitizenModel> GetList(long lgLangId = 1);

        List<EcitizenModel> GetListFront(long lgLangId = 1, string? type = null);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(EcitizenModel model, string username);

        List<EcitizenType> GetEcitizenType();
    }
}