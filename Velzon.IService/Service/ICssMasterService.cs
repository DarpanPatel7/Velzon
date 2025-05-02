using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.IService.Service
{
    public interface ICssMasterService : IDisposable
    {
        CssMasterModel Get(long id, long lgLangId = 1);

        List<CssMasterModel> GetList(long lgLangId = 1);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(CssMasterModel model, string username);
        
        List<CssMasterModel> CSSMasterSiteData();

        CssMasterModel GetFileByName(string strFileName);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}

