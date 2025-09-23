using Microsoft.AspNetCore.Mvc;
using Velzon.Webs.Controllers;

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
