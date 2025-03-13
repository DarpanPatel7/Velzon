using AngleSharp.Css.Dom;
using Microsoft.AspNetCore.Mvc;
using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using System.Web;
using Velzon.Webs.Filters;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    public class LanguageMasterController : BaseController<LanguageMasterController>
    {
        #region Controller Variable

        private ILanguageService LanguageService { get; set; }

        #endregion

        #region Controller Constructor

        public LanguageMasterController(ILanguageService _LanguageService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            this.LanguageService = _LanguageService;
        }

        #endregion

        [ServiceFilter(typeof(PageRightsFilter))]
        [Area("Admin")]
        [Route("/Admin/LanguageMaster")]
        public IActionResult LanguageMaster()
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

        [Route("/Admin/DeleteLanguageData")]
        [HttpPost]
        public JsonResult DeleteLanguageData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = LanguageService.Delete(lgid, UserModel.Id);
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

        [HttpPost]
        [Route("/Admin/SaveLanguageData")]
        public async Task<JsonResult> SaveLanguageData(LanguageMasterFormModel formmodel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidLanguageData(formmodel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        LanguageMasterModel languagemodel = new LanguageMasterModel();

                        languagemodel.Id = formmodel.Id;
                        languagemodel.Name = formmodel.Name;
                        languagemodel.IsVisible = formmodel.IsVisible;

                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && formmodel.Id == 0)
                        {
                            objreturn = LanguageService.AddorUpdate(languagemodel, UserModel.Id);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && formmodel.Id != 0)
                        {
                            objreturn = LanguageService.AddorUpdate(languagemodel, UserModel.Id);
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

        public bool ValidLanguageData(LanguageMasterFormModel formmodel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(formmodel.Name, ControlInputType.none))
                {
                    if (ValidLength(formmodel.Name))
                    {
                        objreturn.strMessage = "Enter valid language name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter language name!";
                    }
                }
                else
                {
                    allow = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not saved, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return allow;
        }

        [Route("/Admin/GetLanguageById")]
        [HttpPost]
        public JsonResult GetLanguageById(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = LanguageService.GetListById(lgid);
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


        [HttpPost]
        [Route("/Admin/GetLanguageData")]
        public JsonResult GetLanguageData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = LanguageService.GetList();
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
