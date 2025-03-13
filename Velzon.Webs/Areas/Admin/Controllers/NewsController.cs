using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Globalization;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class NewsController : BaseController<NewsController>
    {
        #region Controller Variable

        private INewsMasterService NewsMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public NewsController(INewsMasterService _NewsMasterService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            this.NewsMasterService = _NewsMasterService;
        }

        #endregion


        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/NewsMaster")]
        public IActionResult NewsMaster()
        {
            try
            {
                List<ListItem> lstdatanewstype = new List<ListItem>();
                lstdatanewstype.AddRange(NewsMasterService.GetNewsType().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
                ViewBag.lstdatanewstype = lstdatanewstype.ToList();

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

        [Route("/Admin/SaveNewsData")]
        [HttpPost]
        public async Task<JsonResult> SaveNewsData([FromForm] NewsFrontModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidNewsMasterData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        var strPageDescription = Common.Functions.CKEditerSanitizer((objModel.NewsDesc));
                        NewsModel newsModel = new NewsModel();

                        if (objModel.ImageName != null)
                        {
                            var data = (await Functions.SaveFile(objModel.ImageName, httpClientFactory, "News", objModel.ImagePath, FileType.PDFType));

                            if (data != null)
                            {
                                if (!data.isError)
                                {
                                    newsModel.ImageName = data.result.Filename;
                                    newsModel.ImagePath = data.result.FilePath;
                                }
                                else
                                {

                                    objreturn = data;
                                    objreturn.strMessage = "Please Select Pdf For Document";
                                    objreturn.isError = true;
                                    objreturn.type = PopupMessageType.error.ToString();
                                    return Json(objreturn);
                                }
                            }
                            else
                            {
                                objreturn.strMessage = "File Save Error so Please try again.";
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                            }
                        }

                        newsModel.Id = objModel.Id;
                        newsModel.LanguageId = objModel.LanguageId;
                        newsModel.NewsTypeId = objModel.NewsTypeId;
                        newsModel.NewsTitle = objModel.NewsTitle;
                        newsModel.ShortDescription = objModel.ShortDescription;
                        newsModel.NewsDesc = strPageDescription;
                        newsModel.NewsBy = objModel.NewsBy;
                        newsModel.PublicDate = string.IsNullOrWhiteSpace(objModel.PublicDate) ? (DateTime?)null : DateTime.ParseExact(objModel.PublicDate, "dd/MM/yyyy", null);
                        newsModel.ArchiveDate = string.IsNullOrWhiteSpace(objModel.ArchiveDate) ? (DateTime?)null : DateTime.ParseExact(objModel.ArchiveDate, "dd/MM/yyyy", null);
                        newsModel.Location = objModel.Location;
                        newsModel.IsActive = objModel.IsActive;
                        newsModel.IsLink = objModel.IsLink;
                        newsModel.MetaDescription = objModel.MetaDescription;
                        newsModel.MetaTitle = objModel.MetaTitle;
                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            objreturn = NewsMasterService.AddOrUpdate(newsModel, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {
                            objreturn = NewsMasterService.AddOrUpdate(newsModel, UserModel.Username);
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
                else
                {
                    objreturn.strMessage = objreturn.strMessage;
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

        public bool ValidNewsMasterData(NewsFrontModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.NewsTitle, ControlInputType.none))
                {
                    if (ValidLength(objModel.NewsTitle))
                    {
                        objreturn.strMessage = "Enter valid news title!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter news title!";
                    }
                }
                else if (!ValidControlValue(objModel.NewsBy, ControlInputType.none) && (!string.IsNullOrEmpty(objModel.NewsBy)))
                {
                    if (ValidLength(objModel.NewsBy))
                    {
                        objreturn.strMessage = "Enter valid news by!";
                    }
                }
                else if (!ValidControlValue(objModel.Location, ControlInputType.none) && (!string.IsNullOrEmpty(objModel.NewsBy)))
                {
                    if (ValidLength(objModel.Location))
                    {
                        objreturn.strMessage = "Enter valid location!";
                    }
                }
                else if (objModel.IsLink == false && !ValidControlValue(objModel.ImageName, ControlInputType.none))
                {
                    if (ValidLength(objModel.ImageName))
                    {
                        objreturn.strMessage = "Please upload document!";
                    }
                    else
                    {
                        if (!ValidControlValue(objModel.ImagePath, ControlInputType.none))
                        {
                            if (ValidLength(objModel.ImagePath))
                            {
                                objreturn.strMessage = "Please upload document!";
                            }
                            else
                            {
                                objreturn.strMessage = "Please upload document!";
                            }

                        }
                        else
                        { 
                            allow = true; 
                        }
                    }

                }
                return true;
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
        [Route("/Admin/GetNewsData")]
        public JsonResult GetNewsData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = NewsMasterService.GetList();

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        [HttpPost]
        [Route("/Admin/BindNewType")]
        public JsonResult BindNewType()
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select News Type --", Value = "0" });
                lsdata.AddRange(NewsMasterService.GetNewsType().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        [Route("/Admin/GetNewsDataDetails")]
        [HttpPost]
        public JsonResult GetNewsDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = NewsMasterService.Get(lgid, lgLangId);
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

        [Route("/Admin/GetNewsDataDetailsByNewsId")]
        [HttpPost]
        public JsonResult GetNewsDataDetailsByNewsId(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse((HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse((HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = NewsMasterService.GetMenuRes(lgid, lgLangId);
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

        [Route("/Admin/DeleteNewsData")]
        [HttpPost]
        public JsonResult DeleteNewsData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = NewsMasterService.Delete(lgid, UserModel.Username);
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