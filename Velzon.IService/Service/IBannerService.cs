﻿using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.IService.Service
{
    public interface IBannerService : IDisposable
    {
        BannerModel Get(long id, long lgLangId = 1);

        List<BannerModel> GetList(long lgLangId = 1);

        List<BannerModel> GetListFront(long lgLangId = 1);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(BannerModel model, string username);

        JsonResponseModel SwapSequance(long rank, string dir, string username);

        JsonResponseModel UpdateStatus(long id, string username, int isActive = 0);
    }
}
