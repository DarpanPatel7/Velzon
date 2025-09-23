using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IFeedbackServices : IDisposable
    {
        JsonResponseModel AddFeedback(Feedback model);

        List<Feedback> GetList();
    }
}
