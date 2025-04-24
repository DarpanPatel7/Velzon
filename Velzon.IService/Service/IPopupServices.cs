using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.IService.Service
{
    public interface IPopupServices :IDisposable
    {
        PopupModel Get(long id, long lgLangId = 1);

        List<PopupModel> GetList(long lgLangId = 1);

        List<PopupModel> GetListFront(long lgLangId = 1);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(PopupModel model, string username);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}
