using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class JsMasterController : BaseController<JsMasterController>
    {
        private bool isDisplayError { get; set; }
        private IJsMasterService JsMasterService;
        public JsFormSessionModel JsSesstionModel
        {
            get { return SessionWrapper.Get<JsFormSessionModel>(this.HttpContext.Session, "JsSesstionModel"); }
            set { SessionWrapper.Set<JsFormSessionModel>(this.HttpContext.Session, "JsSesstionModel", value); }
        }

        public JsMasterController(IHttpClientFactory httpClientFactory ,IJsMasterService _jsMasterService) : base (httpClientFactory)
        {
            JsMasterService = _jsMasterService;
        }

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("Admin/JsMaster")]
        [HttpGet]
        public IActionResult JsMaster()
        {
            try
            {
                try
                {
                    var sDataIssue = DataIssue;
                    if (sDataIssue != null && isDisplayError)
                    {
                        Functions.MessagePopup(this, sDataIssue.strMessage, (sDataIssue.isError ? PopupMessageType.error : PopupMessageType.success));
                        isDisplayError = true;
                    }
                    else
                    {
                        isDisplayError = false;
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

        [Route("/Admin/SaveFinalJsData")]
        [HttpPost]
        public JsonResult SaveFinalJsData([FromForm] JsMasterFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ModelState.IsValid)
                { 
                    JSMasterModel model = new JSMasterModel();
                    model.Id = objModel.Id;
                    model.Title = objModel.Title;
                    model.Jsfile = objModel.Jsfile;
                    model.IsActive = objModel.IsActive;

                    objreturn =  JsMasterService.AddOrUpdate(model, UserModel.Username);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return Json(objreturn);
        }

        [HttpPost]
        [Route("/Admin/GetJsData")]
        public JsonResult GetJsData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            try
            {
                var lsdata = JsMasterService.GetList();

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }
        }

        [HttpPost]
        [Route("/Admin/GetJsDetails")]
        public JsonResult GetJsDetails(string id)
        {
            JsonResponseModel responseModel = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid))
                {
                    responseModel.strMessage = "";
                    responseModel.isError = false;
                    responseModel.result = JsMasterService.Get(lgid);
                }
                else
                {
                    responseModel.strMessage = "Enter Valid Id.";
                    responseModel.isError = true;
                    responseModel.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {

                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(responseModel);
        }

        [HttpPost]
        [Route("Admin/DeleteJsData")]
        public JsonResult DeleteJsData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = JsMasterService.Delete(lgid, UserModel.Username);
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
        #endregion
    }
}
