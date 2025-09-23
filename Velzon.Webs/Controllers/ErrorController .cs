using Microsoft.AspNetCore.Mvc;

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
