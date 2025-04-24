using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.IService.Service
{
    public interface INewsMasterService : IDisposable
    {
        NewsModel Get(long id, long lgLangId = 1);

        NewsModel GetMenuRes(long NewsId, long lgLangId = 1);

        List<NewsModel> GetList(long lgLangId = 1);

        List<NewsModel> GetListFront(long lgLangId = 1, string? type = null);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(NewsModel model, string username);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);

        List<NewsType> GetNewsType();
    }
}