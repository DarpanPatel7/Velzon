using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
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
    public class PopupController : BaseController<PopupController>
    {
        #region Controller Variable
        protected readonly IPopupServices PopupServices;
        #endregion
        #region Controller Constructor

        public PopupController(IPopupServices _IPopupServices, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            PopupServices = _IPopupServices;
        }
        #endregion

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/PopupMaster")]
        [HttpGet]
        public IActionResult PopupMaster()
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

        [Route("/Admin/SavePopupData")]
        [HttpPost]
        public JsonResult SavePopupData(PopupFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                //if (ModelState.IsValid)
                //{
                var strPageDescription = Common.Functions.CKEditerSanitizer((objModel.popupDescription));

                PopupModel PopupModel = new PopupModel();
                PopupModel.Id = objModel.Id;
                PopupModel.LanguageId = objModel.LanguageId;
                PopupModel.popupDescription = strPageDescription;
                // PopupModel.popupDescription = Common.Functions.CKEditerSanitizer(objModel.popupDescription);
                PopupModel.IsActive = objModel.IsActive;

                if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                {
                    objreturn = PopupServices.AddOrUpdate(PopupModel, UserModel.Username);
                }
                else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                {
                    objreturn = PopupServices.AddOrUpdate(PopupModel, UserModel.Username);
                }
                else
                {
                    objreturn.strMessage = "You Don't have Rights perform this action.";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }

                //}
                //else
                //{
                //    objreturn.strMessage = "Form Input is not valid";
                //    objreturn.isError = true;
                //    objreturn.type = PopupMessageType.error.ToString();
                //}
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
        [Route("/Admin/GetPopupData")]
        public JsonResult GetPopupData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = PopupServices.GetList();

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        [Route("/Admin/GetPopupDataDetails")]
        [HttpPost]
        public JsonResult GetPopupDataDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = PopupServices.Get(lgid);
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

        [Route("/Admin/DeletePopupData")]
        [HttpPost]
        public JsonResult DeletePopupData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = PopupServices.Delete(lgid, UserModel.Username);
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
                    objreturn.strMessage = "Record not deleted, Try again";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not deleted, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }
    }
}
