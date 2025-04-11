using AngleSharp.Css.Dom;
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
    public class BannerController : BaseController<BannerController>
    {
        #region Controller Variable

        private IBannerService BannerMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public BannerController(IBannerService _BannerMasterService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            BannerMasterService = _BannerMasterService;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [HttpGet]
        [Route("/Admin/BannerMaster")]
        public IActionResult BannerMaster()
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

        [Route("/Admin/SaveBannerData")]
        [HttpPost]
        [DisableRequestSizeLimit]
        public async Task<JsonResult> SaveBannerData([FromForm] BannerFormModel formmodel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidBannerData(formmodel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        var strPageDescription = Common.Functions.CKEditerSanitizer((formmodel.Description));

                        BannerModel bannerModel = new BannerModel();

                        if (formmodel.ImageName != null)
                        {
                            var data = (await Functions.SaveFile(formmodel.ImageName, httpClientFactory, "Banner", formmodel.ImagePath, FileType.ImageType));

                            if (data != null)
                            {
                                if (!data.isError)
                                {
                                    bannerModel.ImageName = data.result.Filename;
                                    bannerModel.ImagePath = data.result.FilePath;
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
                            bannerModel.ImagePath = formmodel.ImagePath;
                        }

                        bannerModel.Id = formmodel.Id;
                        bannerModel.LanguageId = formmodel.LanguageId;
                        bannerModel.Title = formmodel.Title;
                        bannerModel.URL = formmodel.URL;
                        bannerModel.Description = strPageDescription;
                        bannerModel.IsActive = formmodel.IsActive;

                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && formmodel.Id == 0)
                        {
                            if (BannerMasterService.GetList().Count() == 0)
                            {
                                bannerModel.BannerRank = 0;
                            }
                            else
                            {
                                bannerModel.BannerRank = BannerMasterService.GetList().Max(x => x.BannerRank) + 1;
                            }
                            objreturn = BannerMasterService.AddOrUpdate(bannerModel, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && formmodel.Id != 0)
                        {
                            bannerModel.BannerRank = BannerMasterService.Get(formmodel.Id).BannerRank;
                            objreturn = BannerMasterService.AddOrUpdate(bannerModel, UserModel.Username);
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

        public bool ValidBannerData(BannerFormModel formmodel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(formmodel.Title, ControlInputType.none))
                {
                    if (ValidLength(formmodel.Title))
                    {
                        objreturn.strMessage = "Enter Valid Banner Title!";
                        objreturn.isError = true;
                        return false;
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Banner Title!";
                        objreturn.isError = true;
                        return false;
                    }
                }
                else if (formmodel.ImageName == null && Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && formmodel.Id == 0)
                {
                    objreturn.strMessage = "Upload Banner Image!";
                }
                else if (formmodel.ImagePath == null && formmodel.ImageName == null && Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && formmodel.Id != 0)
                {
                    objreturn.strMessage = "Upload Banner Image!";
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

        [HttpPost]
        [Route("/Admin/GetBannerData")]
        public JsonResult GetBannerData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = BannerMasterService.GetList().OrderBy(x => x.BannerRank);

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        [Route("/Admin/GetBannerDataDetails")]
        [HttpPost]
        public JsonResult GetBannerDataDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = BannerMasterService.Get(lgid, lgLangId);
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

        [Route("/Admin/DeleteBannerData")]
        [HttpPost]
        public JsonResult DeleteBannerData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = BannerMasterService.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/BannerSwapDetails")]
        [HttpPost]
        public JsonResult BannerSwapDetails(string rank, string dir)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                dir = Velzon.Common.Functions.FrontDecrypt(dir);
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(rank), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = BannerMasterService.SwapSequance(lgid, dir, UserModel.Username);
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
                    objreturn.strMessage = "Record not Swap, Try again";
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

        [Route("/Admin/UpdateBannerStatus")]
        [HttpPost]
        public JsonResult UpdateBannerStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = BannerMasterService.UpdateStatus(lgid, UserModel.Username, isActive);
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
