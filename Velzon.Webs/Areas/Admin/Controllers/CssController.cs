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
    public class CssController : BaseController<CssController>
    {
        private bool isDisplayError { get; set; }

        private ICssMasterService cssMasterService;
        public CssFormSessionModel CssSesstionModel
        {
            get { return SessionWrapper.Get<CssFormSessionModel>(this.HttpContext.Session, "CssSesstionModel"); }
            set { SessionWrapper.Set<CssFormSessionModel>(this.HttpContext.Session, "CssSesstionModel", value); }
        }
        public CssController(ICssMasterService _cssMasterService, IHttpClientFactory httpClientFactory) : base(httpClientFactory)
        {
            cssMasterService = _cssMasterService;
        }

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [HttpGet]
        [Route("/Admin/CssMaster")]
        public IActionResult CssMaster()
        {
            try
            {
                CssSesstionModel = new CssFormSessionModel();
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

        [Route("/Admin/SaveCssData")]
        [HttpPost]
        public JsonResult SaveCssData([FromForm] CssMasterFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (CssSesstionModel == null)
                {
                    objreturn.strMessage = "Form Input is not valid";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
                else
                {
                    CssMasterModel model = new CssMasterModel();
                    model.Id = objModel.Id;
                    model.Title = objModel.Title;
                    model.Cssfile = objModel.Cssfile;
                    model.IsActive = objModel.IsActive;

                    objreturn = cssMasterService.AddOrUpdate(model, UserModel.Username);
                }
            }
            catch (Exception ex)
            {

                throw;
            }
            return Json(objreturn);
        }

        [HttpPost]
        [Route("/Admin/GetCssData")]
        public JsonResult GetCssData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            try
            {
                var lsdata = cssMasterService.GetList();

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }
        }

        [HttpPost]
        [Route("/Admin/GetCssDetails")]
        public JsonResult GetCssDetails(string id)
        {
            JsonResponseModel responseModel = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid))
                {
                    responseModel.strMessage = "";
                    responseModel.isError = false;
                    responseModel.result = cssMasterService.Get(lgid);
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
        [Route("Admin/DeleteCssData")]
        public JsonResult DeleteCssData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = cssMasterService.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/UpdateCssStatus")]
        [HttpPost]
        public JsonResult UpdateCssStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = cssMasterService.UpdateStatus(lgid, UserModel.Username, isActive);
                    }
                    else
                    {
                        objreturn.strMessage = "You Don't have Rights to perform this action.";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                    }
                }
                else
                {
                    objreturn.strMessage = "Status not updated, Try again";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Status not updated, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        #endregion
    }
}

