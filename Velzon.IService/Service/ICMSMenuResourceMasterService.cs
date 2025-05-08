using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.IService.Service
{
    public interface ICMSMenuResourceMasterService : IDisposable
    {
        CMSMenuResourceModel Get(long id, long lgLangId = 1);

        CMSMenuResourceModel GetMenuRes(long menuResid, long lgLangId = 1);

        List<CMSMenuResourceModel> GetList(long lgLangId = 1);

        List<CMSMenuResourceModel> GetListFront(long lgLangId = 1);

        List<CMSMenuResourceModel> GetListMaster();

        List<CMSMenuResourceModel> GetParentList(long? lgLangId = 1);

        JsonResponseModel SwapSequance(long rank, string dir, string username, string type, long parentid);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(CMSMenuResourceModel model, string username);

        JsonResponseModel UpdateSwap(CMSMenuResourceModel model, string username);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}