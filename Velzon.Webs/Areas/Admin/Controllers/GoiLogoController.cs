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
using Velzon.Services.Service;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class GoiLogoController : BaseController<GoiLogoController>
    {
        #region Controller Variable

        private IGoiLogoServices goiLogoServices { get; set; }

        #endregion

        #region Controller Constructor

        public GoiLogoController(IGoiLogoServices _goiLogoServices, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            goiLogoServices = _goiLogoServices;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/GoiLogoMaster")]
        [HttpGet]
        public IActionResult GoiLogoMaster()
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
        #endregion

        #region Save Method
        [Route("/Admin/SaveGoiLogoData")]
        [HttpPost]
        [DisableRequestSizeLimit]
        public async Task<JsonResult> SaveGoiLogoData(GoiFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidGoiLogoData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        GoiLogoModel goiLogoModel = new GoiLogoModel();

                        if (objModel.LogoImage != null)
                        {
                            var data = (await Functions.SaveFile(objModel.LogoImage, httpClientFactory, "GoiLogo", objModel.ImagePath, FileType.ImageType));

                            if (data != null)
                            {
                                if (!data.isError)
                                {
                                    goiLogoModel.ImageName = data.result.Filename;
                                    goiLogoModel.ImagePath = data.result.FilePath;
                                }
                                else
                                {
                                    return Json(data);
                                }
                            }
                            else
                            {
                                objreturn.strMessage = "File Save Error so Please try again.";
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                            }
                        }
                        else
                        {
                            goiLogoModel.ImagePath = objModel.ImagePath;

                        }
                        goiLogoModel.LanguageId = objModel.LanguageId;
                        goiLogoModel.Id = objModel.Id;
                        goiLogoModel.LogoName = objModel.LogoName;
                        goiLogoModel.Url = objModel.Url;
                        goiLogoModel.IsActive = objModel.IsActive;

                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            objreturn = goiLogoServices.AddOrUpdate(goiLogoModel, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {
                            objreturn = goiLogoServices.AddOrUpdate(goiLogoModel, UserModel.Username);
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

        public bool ValidGoiLogoData(GoiFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.LogoName, ControlInputType.none))
                {
                    if (ValidLength(objModel.LogoName))
                    {
                        objreturn.strMessage = "Enter valid Logo Name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Logo Name!";
                    }
                }
                else if (!ValidControlValue(objModel.Url, ControlInputType.none))
                {
                    if (ValidLength(objModel.Url))
                    {
                        objreturn.strMessage = "Enter valid Url!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Url!";
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

        #endregion

        #region Get Master Data
        [HttpPost]
        [Route("/Admin/GetGoiLogoData")]
        public JsonResult GetGoiLogoData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = goiLogoServices.GetList();

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }
        #endregion

        #region Get Master Details Data
        [Route("/Admin/GetGoiLogoDetails")]
        [HttpPost]
        public JsonResult GetGoiLogoDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = goiLogoServices.Get(lgid, lgLangId);
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

        #region Delete Data
        [Route("/Admin/DeleteGoiLogoData")]
        [HttpPost]
        public JsonResult DeleteGoiLogoData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = goiLogoServices.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/UpdateGoiLogoStatus")]
        [HttpPost]
        public JsonResult UpdateGoiLogoStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = goiLogoServices.UpdateStatus(lgid, UserModel.Username, isActive);
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
        public IActionResult Index()
        {
            return View();
        }
    }
}