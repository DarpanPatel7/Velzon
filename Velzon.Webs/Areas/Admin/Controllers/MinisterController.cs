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
    public class MinisterController : BaseController<MinisterController>
    {
        #region Controller Variable

        private IMinisterServices MinisterServices { get; set; }

        #endregion
        #region Controller Constructor

        public MinisterController(IMinisterServices _MinisterMasterService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            MinisterServices = _MinisterMasterService;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/MinisterMaster")]
        [HttpGet]
        public IActionResult MinisterMaster()
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

        [Route("/Admin/SaveMinisterData")]
        [HttpPost]
        [DisableRequestSizeLimit]
        public async Task<JsonResult> SaveMinisterData(MinisterFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidMinisterData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        MinisterModel MinisterModel = new MinisterModel();

                        if (objModel.MinisterImage != null)
                        {
                            var data = (await Functions.SaveFile(objModel.MinisterImage, httpClientFactory, "Minister", objModel.ImagePath, FileType.ImageType));

                            //var data = (await Functions.SaveFile(objModel.MinisterImage, httpClientFactory, "Minister", "~/Areas/Admin/Views/Minister/"/*objModel.ImagePath*/, FileType.ImageType));

                            if (data != null)
                            {
                                if (!data.isError)
                                {
                                    MinisterModel.ImageName = data.result.Filename;
                                    MinisterModel.ImagePath = data.result.FilePath;
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
                            MinisterModel.ImagePath = objModel.ImagePath;

                        }

                        MinisterModel.Id = objModel.Id;
                        MinisterModel.LanguageId = objModel.LanguageId;
                        MinisterModel.MinisterName = objModel.MinisterName;
                        MinisterModel.MinisterDescription = objModel.MinisterDescription;
                        //  MinisterModel.MinisterDescription = Common.Functions.CKEditerSanitizer(objModel.MinisterDescription);             
                        //  MinisterModel.MinisterSection = objModel.MinisterSection;
                        MinisterModel.IsActive = objModel.IsActive;

                        /*if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            objreturn = MinisterServices.AddOrUpdate(MinisterModel, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {
                            objreturn = MinisterServices.AddOrUpdate(MinisterModel, UserModel.Username);
                        }*/
                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            if (MinisterServices.GetList().Count() == 0)
                            {
                                MinisterModel.MinisterRank = 0;
                            }
                            else
                            {
                                MinisterModel.MinisterRank = MinisterServices.GetList().Max(x => x.MinisterRank) + 1;
                            }
                            objreturn = MinisterServices.AddOrUpdate(MinisterModel, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {
                            MinisterModel.MinisterRank = MinisterServices.Get(objModel.Id).MinisterRank;
                            objreturn = MinisterServices.AddOrUpdate(MinisterModel, UserModel.Username);
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

        public bool ValidMinisterData(MinisterFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.MinisterName, ControlInputType.none))
                {
                    if (ValidLength(objModel.MinisterName))
                    {
                        objreturn.strMessage = "Enter valid name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter name!";
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

        [IgnoreAntiforgeryToken]
        [Route("/Admin/DownloadMinisterFile")]
        public async Task<ActionResult> DownloadMinisterFile(string fileName)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            fileName = HttpUtility.UrlDecode(fileName.ToString().Replace("?", "").Replace(");", "")).Replace("'", "").Trim();
            if (!string.IsNullOrWhiteSpace(fileName))
            {
                if (Common.Functions.GetPageRightsCheck(HttpContext.Session).View)
                {
                    fileName = fileName.Replace("HASH_HASH", "+").Replace("HASH__HASH", "/");
                    fileName = Velzon.Common.Functions.FrontDecrypt(fileName).Replace("_", " ");
                    var docData = await Functions.DownloadFile(httpClientFactory, fileName);
                    if (docData != null)
                    {
                        if (docData.isError)
                        {
                            objreturn = docData;
                            ViewData.Add("DataIssue", objreturn);
                            return Redirect(Url.Content("~/Admin/MinisterMaster"));
                        }
                        else
                        {
                            objreturn.isError = false;
                            objreturn.strMessage = "";
                            string ContentType = "";
                            new FileExtensionContentTypeProvider().TryGetContentType(docData.result.Filename, out ContentType);

                            objreturn.result = new { dataBytes = docData.result.DataBytes, contentType = ContentType, fileName = docData.result.Filename };

                            return File(docData.result.DataBytes, ContentType, docData.result.Filename);
                        }
                    }
                    else
                    {
                        objreturn.isError = true;
                        objreturn.strMessage = "File Don't able to Download";
                        DataIssue = objreturn;
                        return Redirect(Url.Content("~/Admin/MinisterMaster"));
                    }
                }
                else
                {
                    objreturn.isError = true;
                    objreturn.strMessage = "You Don't have Rights perform this action.";
                    DataIssue = objreturn;
                    return Redirect(Url.Content("~/Admin/MinisterMaster"));
                }
            }
            else
            {
                objreturn.isError = true;
                objreturn.strMessage = "Please Enter File Path.";
                DataIssue = objreturn;
                return Redirect(Url.Content("~/Admin/MinisterMaster"));
            }
        }

        [HttpPost]
        [Route("/Admin/GetMinisterData")]
        public JsonResult GetMinisterData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = MinisterServices.GetList().OrderBy(x => x.MinisterRank);

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        [Route("/Admin/GetMinisterDataDetails")]
        [HttpPost]
        public JsonResult GetMinisterDataDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                //id = HttpUtility.UrlDecode(id).Replace('+', '-');
                //langId = HttpUtility.UrlDecode(langId).Replace('+', '-');
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = MinisterServices.Get(lgid, lgLangId);
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

        [Route("/Admin/DeleteMinisterData")]
        [HttpPost]
        public JsonResult DeleteMinisterData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = MinisterServices.Delete(lgid, UserModel.Username);
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
        [Route("/Admin/MinisterSwapDetails")]
        [HttpPost]
        public JsonResult MinisterSwapDetails(string rank, string dir)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {

                dir = Velzon.Common.Functions.FrontDecrypt(dir);
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(rank), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = MinisterServices.SwapSequance(lgid, dir, UserModel.Username);
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
        #endregion


    }
}

