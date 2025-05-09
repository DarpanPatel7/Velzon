using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Text.RegularExpressions;
using System.Web;

namespace Velzon.Webs.Controllers
{
    public class ErrorController : Controller
    {
        #region Controller Methods

        #region Page

        [Route("Error/404")]
        public IActionResult Error404()
        {
            return View("404");
        }

        #endregion

        #endregion
    }
}
