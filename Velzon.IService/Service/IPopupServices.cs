using Velzon.Model.Service;
using Velzon.Model.System;

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
