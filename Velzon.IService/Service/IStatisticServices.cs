using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IStatisticServices : IDisposable
    {
        StatisticModel Get(long id, long lgLangId = 1);

        List<StatisticModel> GetList(long lgLangId = 1);

        List<StatisticModel> GetListFront(long lgLangId = 1, string? type = null);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(StatisticModel model, string username);

        List<StatisticType> GetStatisticType();
    }
}
