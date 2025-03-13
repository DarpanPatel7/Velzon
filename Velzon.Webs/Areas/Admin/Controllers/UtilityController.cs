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
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class UtilityController : BaseController<UtilityController>
    {
        #region Controller Variable

        private IUtilityService UtilityService { get; set; }

        #endregion

        #region Controller Constructor

        public UtilityController(IUtilityService _UtilityService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            UtilityService = _UtilityService;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [HttpGet]
        [Route("/Admin/UtilityMaster")]
        public IActionResult UtilityMaster()
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
        [DisableRequestSizeLimit]
        [Route("/Admin/SaveUtilityData")]
        public async Task<JsonResult> SaveUtilityData([FromForm] UtilityFormModel formmodel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ModelState.IsValid)
                {
                    UtilityModel utilModel = new UtilityModel();
                    utilModel.Id = formmodel.Id;
                    utilModel.UserId = formmodel.UserId;
                    utilModel.FormUserId=formmodel.FormUserId;
                    utilModel.UserName = formmodel.UserName;
                    utilModel.plock = formmodel.plock;
                    utilModel.Details = formmodel.Details;
                    utilModel.IpAddress = formmodel.IpAddress;

                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && formmodel.Id == 0)
                    {
                        objreturn = UtilityService.AddOrUpdate(utilModel, UserModel.Username);
                    }
                    else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && formmodel.Id != 0)
                    {
                        objreturn = UtilityService.AddOrUpdate(utilModel, UserModel.Username);
                    }
                    else
                    {
                        objreturn.strMessage = "You Don't have Rights perform this action.";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                    }
                }
                else
                {
                    objreturn.strMessage = "Form Input is not valid";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not saved, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        [HttpPost]
        [Route("/Admin/GetUtilityData")]
        public JsonResult GetUtilityData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            try
            {
                var lsdata = UtilityService.GetList().OrderBy(x => x.UserName);

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }
        }

        [Route("/Admin/GetUtilityDataDetails")]
        [HttpPost]
        public JsonResult GetUtilityDataDetails(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = UtilityService.Get(lgid);
                }
                else
                {
                    objreturn.strMessage = "Enter Valid Id.";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(objreturn);
        }

        #endregion
    }
}
