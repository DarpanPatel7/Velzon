using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
