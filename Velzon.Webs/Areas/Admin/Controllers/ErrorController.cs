using Velzon.Common;
using Velzon.IService.Service;
using Velzon.IService.System;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Velzon.Webs.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Diagnostics;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class ErrorController : BaseController<ErrorController>
    {
        #region Controller Methods

        [Route("Admin/Error/404")]
        public IActionResult Error404()
        {
            return View("404");
        }

        [Route("Admin/Error/AccessDenied")]
        public IActionResult AccessDenied()
        {
            return View("AccessDenied"); // Views/Error/AccessDenied.cshtml
        }

        [Route("Admin/Error/Maintenance")]
        public IActionResult Maintenance()
        {
            return View("Maintenance"); // Views/Error/Maintenance.cshtml
        }

        #endregion
    }
}
