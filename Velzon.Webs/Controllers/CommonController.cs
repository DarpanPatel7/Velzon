using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Data;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using RestSharp;

namespace Velzon.Webs.Controllers
{
    public class CommonController : Controller
    {
        #region Controller Variable

        protected readonly IHttpClientFactory httpClientFactory;
        protected readonly IGlobleSerchService objSerchServices;
        protected readonly ICMSMenuMasterService objCMSMenuMasterService;
        protected readonly ICMSMenuResourceMasterService objMenuResourceMasterService;
        protected readonly ICMSTemplateMasterService objCMSTemplateMasterService;
        protected readonly ICommonService objCommonService;

        public long LanguageId
        {
            get
            {
                long Lang = 1;
                if (SessionWrapper.Get<long>(this.HttpContext.Session, "LanguageId") == null || SessionWrapper.Get<long>(this.HttpContext.Session, "LanguageId") == 0)
                {
                    SessionWrapper.Set<long>(this.HttpContext.Session, "LanguageId", 1);
                    Lang = 1;
                }
                else
                {
                    Lang = SessionWrapper.Get<long>(this.HttpContext.Session, "LanguageId");
                }
                return Lang;
            }
            set { SessionWrapper.Set<long>(this.HttpContext.Session, "LanguageId", value); }
        }

        #endregion

        #region Controller Constructor

        public CommonController(IGlobleSerchService _objSerchServices, ICMSTemplateMasterService _objCMSTemplateMasterService, ICMSMenuMasterService _adminMenuMasterService, ICMSMenuResourceMasterService _menuResourceMasterService, IMinisterServices _objMinisterServices, IBannerService _objBannerService, IHttpClientFactory _httpClientFactory, IGoiLogoServices _objGoiLogoServices, INewsMasterService _objNewsMasterService, IGalleryService _objGallaryMasterService, IPopupServices _objPopupServices, IVideoService _objVideoServices, IStatisticServices _objstatisticService, IConfiguration configuration, ICommonService _objCommonService)
        {
            httpClientFactory = _httpClientFactory;
            objSerchServices = _objSerchServices;
            objCMSMenuMasterService = _adminMenuMasterService;
            objMenuResourceMasterService = _menuResourceMasterService;
            objCMSTemplateMasterService = _objCMSTemplateMasterService;
            objCommonService = _objCommonService;
        }

        #endregion

        #region Controller Methos

        [HttpPost]
        [Route("/BindLanguage")]
        public JsonResult BindLanguage()
        {
            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.AddRange(objCommonService.GetListLanguage().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(lsdata);
        }

        [HttpPost]
        [Route("/UpdateLanguage")]
        public JsonResult UpdateLanguage(long langId)
        {
            LanguageId = langId;
            return Json(LanguageId);
        }

        [IgnoreAntiforgeryToken]
        [Route("/ViewFile")]
        public async Task<ActionResult> ViewFile(string fileName)
        {
            string strReturnPath = "";

            JsonResponseModel objreturn = new JsonResponseModel();
            fileName = HttpUtility.UrlDecode(fileName.ToString().Replace("?", "").Replace(");", "")).Replace("'", "").Trim();
            if (!string.IsNullOrWhiteSpace(fileName))
            {
                try
                {
                    fileName = fileName.Replace("HASH_HASH", "+").Replace("HASH__HASH", "/");
                    fileName = Velzon.Common.Functions.FrontDecrypt(fileName).Replace("_", " ");
                }
                catch (Exception ex)
                {

                }
                var docData = await Functions.DownloadFile(httpClientFactory, fileName);
                if (docData != null)
                {
                    if (docData.isError)
                    {
                        objreturn = docData;
                        return Redirect(Url.Content("~" + strReturnPath));
                    }
                    else
                    {
                        objreturn.isError = false;
                        objreturn.strMessage = "";
                        string ContentType = "";
                        string extension = System.IO.Path.GetExtension(docData.result.Filename).Replace(".", "").ToUpper();

                        new FileExtensionContentTypeProvider().TryGetContentType(docData.result.Filename, out ContentType);

                        if (Functions.ValidateFileExtention(extension, FileType.ImageType) || Functions.ValidateFileExtention(extension, FileType.PDFType) || Functions.ValidateFileExtention(extension, FileType.VideoType))
                        {
                            return new FileContentResult(docData.result.DataBytes, ContentType);
                        }
                        else
                        {
                            if (extension == ("apk").ToUpper())
                            {
                                ContentType = "application/vnd.android.package-archive";
                            }
                            return File(docData.result.DataBytes, ContentType, docData.result.Filename);
                        }
                    }
                }
                else
                {
                    objreturn.isError = true;
                    objreturn.strMessage = "File Don't able to View";
                    return Redirect(strReturnPath);
                }
            }
            else
            {
                objreturn.isError = true;
                objreturn.strMessage = "Please Enter File Path.";
                return Redirect(strReturnPath);
            }
        }

        /*[HttpGet]
        [Route("/Search")]
        public IActionResult Search(string serch)
        {
            SearchFormModel searchFormModel = new SearchFormModel();
            searchFormModel.serch = serch;
            return View(searchFormModel);
        }*/

        [Route("/GlobalSearch")]
        [HttpPost]
        public JsonResult GlobalSearch(string search)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                List<GlobleSerchModel> lstGbList = objSerchServices.GetList(Functions.FrontDecrypt(HttpUtility.UrlDecode(search)), LanguageId);
                objreturn.result = lstGbList;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(objreturn);
        }

        public bool ValidGlobalSearchData(string search, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!Common.Functions.ValidControlValue(search, ControlInputType.text))
                {
                    if (Common.Functions.ValidLength(search))
                    {
                        objreturn.strMessage = "Enter valid Search Keyword!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Search Keyword!";
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

        [Route("/CSSCustom/{strFileName}.css")]
        public ContentResult GetTheme(string strFileName)
        {
            StringBuilder stringBuilder = new StringBuilder();
            string CSSCODE = "";
            using (ICssMasterService CSSMasterService = new CssMasterService())
            {
                var data = CSSMasterService.GetFileByName(strFileName);
                if (data != null)
                {
                    stringBuilder.Append(data.Cssfile);
                }
            }
            CSSCODE = stringBuilder.ToString();
            Response.ContentType = "text/css";
            return Content(CSSCODE, "text/css");
        }

        [Route("/JSCustom/{strFileName}.js")]
        public ContentResult GetJSTheme(string strFileName)
        {
            try
            {
                using (IJsMasterService JSMasterService = new JsMasterService())
                {
                    var data = JSMasterService.GetJSFileByName(strFileName);
                    if (data != null)
                    {
                        Response.ContentType = "text/javascript"; // Correct MIME type for JavaScript
                        return Content(data.Jsfile, "text/javascript");
                    }
                    else
                    {
                        // If no JS file found, return an empty content result or error message
                        return Content("// JS file not found", "text/javascript");
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception if needed and return a meaningful error message
                return Content($"// Error loading JS file: {ex.Message}", "text/javascript");
            }
        }

        [Route("/GetWebSiteVisitorsCount")]
        [HttpPost]
        public async Task<JsonResult> GetWebSiteVisitorsCount()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                var ipaddress = HttpContext.Connection.RemoteIpAddress.ToString();
                objreturn = objCMSMenuMasterService.AddgetVisitorsCount(ipaddress);

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
