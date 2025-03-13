using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Globalization;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class FeedbackController : BaseController<FeedbackController>
    {
        #region Controller Variable

        private IFeedbackServices FeedbackService { get; set; }

        #endregion

        #region Controller Constructor

        public FeedbackController(IFeedbackServices _FeedbackService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            this.FeedbackService = _FeedbackService;
        }

        #endregion

        public IActionResult Index()
        {
            return View();
        }

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/Feedback")]
        public IActionResult Feedback()
        {
            try
            {
                try
                {
                    var sDataIssue = DataIssue;
                    if (sDataIssue != null)
                    {
                        Functions.MessagePopup(this, sDataIssue.strMessage, (sDataIssue.isError ? PopupMessageType.error : PopupMessageType.success));
                    }
                }
                catch (Exception ex)
                {

                }
                return View();
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Account");
            }
        }

        [HttpPost]
        [Route("/Admin/GetFeedbackData")]
        public JsonResult GetFeedbackData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = FeedbackService.GetList();

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }
    }
}
