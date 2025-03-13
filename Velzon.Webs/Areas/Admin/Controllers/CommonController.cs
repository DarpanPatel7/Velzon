using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.System;
using Microsoft.AspNetCore.Mvc;
using System.Data;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    public class CommonController : Controller
    {
        #region Controller Variable

        protected readonly ICommonService objCommonService;

        #endregion

        #region Controller Constructor

        public CommonController(ICommonService _objCommonService)
        {
            objCommonService = _objCommonService;
        }

        #endregion

        #region Controller Methos

        [HttpPost]
        [Route("/Admin/BindLanguage")]
        public JsonResult BindLanguage()
        {
            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.AddRange(objCommonService.GetListLanguage().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(lsdata);
        }

        #endregion
    }
}
