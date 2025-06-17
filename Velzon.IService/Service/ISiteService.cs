using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.IService.System
{
    public interface ISiteService : IDisposable
    {
        SiteModel Get();

        bool InsertOrUpdate(SiteModel objSiteModel, out string strErrorMessage);
    }
}
