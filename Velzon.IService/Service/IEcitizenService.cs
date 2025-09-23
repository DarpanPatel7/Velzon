using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IEcitizenService : IDisposable
    {
        EcitizenModel Get(long id, long lgLangId = 1);

        List<EcitizenModel> GetList(long lgLangId = 1);

        List<EcitizenModel> GetListFront(long lgLangId = 1, string? type = null);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(EcitizenModel model, string username);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);

        List<EcitizenType> GetEcitizenType();
    }
}