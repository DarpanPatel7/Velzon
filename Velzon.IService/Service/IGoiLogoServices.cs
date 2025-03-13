﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.IService.Service
{
    public interface IGoiLogoServices : IDisposable
    {
        GoiLogoModel Get(long id, long lgLangId = 1);

        List<GoiLogoModel> GetList(long lgLangId = 1);

        JsonResponseModel Delete(long id, string username);

        JsonResponseModel AddOrUpdate(GoiLogoModel model, string username);
    }
}
