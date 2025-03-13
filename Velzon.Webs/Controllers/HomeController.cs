using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace Velzon.Webs.Controllers
{
    public class HomeController : Controller
    {
        #region Controller Variable
        protected readonly IBannerService objBannerService;
        protected readonly IGlobleSerchService objSerchServices;
        protected readonly IHttpClientFactory httpClientFactory;
        protected readonly IMinisterServices objMinisterServices;
        protected readonly IDocumentServices objDocumentService;
        protected readonly IGoiLogoServices objGoiLogoServices;
        protected readonly INewsMasterService objNewsMasterService;
        protected readonly ICMSMenuMasterService objCMSMenuMasterService;
        protected readonly ICMSMenuResourceMasterService objMenuResourceMasterService;
        protected readonly ICMSTemplateMasterService objCMSTemplateMasterService;
        protected readonly IPopupServices objPopupServices;
        protected readonly IStatisticServices objStatisticService;
        protected readonly ICommonService objCommonService;
        private readonly IConfiguration _configuration;
        private readonly IProjectService projectService;
        private readonly IServiceRateService serviceRateService;
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

        public HomeController(IDocumentServices _objDocumentService, IGlobleSerchService _objSerchServices, ICMSTemplateMasterService _objCMSTemplateMasterService, ICMSMenuMasterService _adminMenuMasterService, ICMSMenuResourceMasterService _menuResourceMasterService, IMinisterServices _objMinisterServices, IBannerService _objBannerService, IHttpClientFactory _httpClientFactory, IGoiLogoServices _objGoiLogoServices, INewsMasterService _objNewsMasterService, IPopupServices _objPopupServices, IStatisticServices _objstatisticService, IConfiguration configuration, ICommonService _objCommonService, IProjectService projectService, IServiceRateService serviceRateService)
        {
            objCMSMenuMasterService = _adminMenuMasterService;
            objMenuResourceMasterService = _menuResourceMasterService;
            objBannerService = _objBannerService;
            objMinisterServices = _objMinisterServices;
            httpClientFactory = _httpClientFactory;
            objGoiLogoServices = _objGoiLogoServices;
            objNewsMasterService = _objNewsMasterService;
            objCMSTemplateMasterService = _objCMSTemplateMasterService;
            objDocumentService = _objDocumentService;
            objPopupServices = _objPopupServices;
            objSerchServices = _objSerchServices;
            objStatisticService = _objstatisticService;
            objCommonService = _objCommonService;
            _configuration = configuration;
            this.projectService = projectService;
            this.serviceRateService = serviceRateService;
        }

        #endregion

        #region Controller Methods

        #region Page
        [Route("Index")]
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult HomePage()
        {
            // return Redirect(Webs.Common.Functions.GetHomePage(Url));
            return Redirect(Url.Content("~/Index"));
        }

        [HttpGet]
        [Route("/Search")]
        public IActionResult Search(string serch)
        {
            SearchFormModel searchFormModel = new SearchFormModel();
            searchFormModel.serch = serch;
            return View(searchFormModel);
        }
        #endregion

        #region Ajax
        private string GetContentForTemplate(long languageId, string templateName)
        {
            var data = objCMSTemplateMasterService.GetList(languageId).FirstOrDefault(x => x.TemplateName == templateName && x.IsActive);
            return data?.Content;
        }

        [Route("Home/{strCurrentPath}")]
        public IActionResult PageDetails(string strCurrentPath)
        {
            if (!string.IsNullOrEmpty(strCurrentPath))
            {
                ViewBag.pagename = strCurrentPath;
                Regex r = new Regex(@"^[a-zA-Z0-9-_/]+$");

                if (r.IsMatch(strCurrentPath))
                {
                    var data = objCMSMenuMasterService.GetList().Where(x => x.MenuURL == strCurrentPath).FirstOrDefault();

                    if (data != null)
                    {
                        if (strCurrentPath.ToUpper().StartsWith("HTTPS") || strCurrentPath.ToUpper().StartsWith("HTTP"))
                        {
                            strCurrentPath = "https";
                            strCurrentPath = strCurrentPath + "://" + data.PageDescription.Replace("<p>", "").Replace("</p>", "").Trim();
                            if (!strCurrentPath.ToUpper().EndsWith("ASPX"))
                            {
                                strCurrentPath = strCurrentPath + "/";
                            }

                            return Redirect(strCurrentPath);
                        }
                        else
                        {
                            var menuresourcedata = objMenuResourceMasterService.GetMenuRes(data.MenuResId, LanguageId);
                            if (menuresourcedata != null)
                            {
                                data.PageDescription = (HttpUtility.HtmlDecode(menuresourcedata.PageDescription));


                                if (menuresourcedata.TemplateId != "0" && menuresourcedata.TemplateId != null)
                                {
                                    var newstring = objCMSTemplateMasterService.GetByTemp(Convert.ToInt32(menuresourcedata.TemplateId), LanguageId);

                                    if (newstring != null)
                                    {
                                        if (menuresourcedata.PageDescription != null)
                                        {
                                            string strMain = menuresourcedata.PageDescription.Replace("{{" + newstring.TemplateName.Replace(" ", "") + "}}", newstring.Content);
                                            data.PageDescription = (HttpUtility.HtmlDecode(strMain));
                                        }

                                    }
                                    return View(data);
                                }
                                return View(data);

                            }
                            else
                            {
                                menuresourcedata = objMenuResourceMasterService.Get(data.MenuResId, 1);

                                data.PageDescription = (HttpUtility.HtmlDecode(menuresourcedata.PageDescription));



                                if (menuresourcedata.TemplateId != "0" && menuresourcedata.TemplateId != null)
                                {
                                    var newstring = objCMSTemplateMasterService.GetByTemp(Convert.ToInt32(menuresourcedata.TemplateId), 1);

                                    if (newstring != null)
                                    {
                                        string strMain = menuresourcedata.PageDescription.Replace("{{" + newstring.TemplateName.Replace(" ", "") + "}}", newstring.Content);
                                        data.PageDescription = (HttpUtility.HtmlDecode(strMain));

                                    }
                                    return View(data);
                                }

                            }


                            return View(data);
                        }
                    }
                }
            }
            return Redirect(Url.Content("~/Index"));
        }

        [HttpPost]
        [Route("/BindHeader")]
        public JsonResult BindHeader()
        {
            try
            {
                // Retrieve content based on the specified templateId and LanguageId, or default to LanguageId 1
                var content = GetContentForTemplate(LanguageId, "HeaderDesign") ?? GetContentForTemplate(1, "HeaderDesign");

                // Return the decoded content if found, otherwise return an empty string
                return Json(HttpUtility.HtmlDecode(content ?? string.Empty));
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json("");
        }

        [HttpPost]
        [Route("/BindMainLogo")]
        public JsonResult BindMainLogo()
        {
            try
            {
                // Retrieve content based on the specified templateId and LanguageId, or default to LanguageId 1
                var content = GetContentForTemplate(LanguageId, "MainLogo") ?? GetContentForTemplate(1, "MainLogo");

                // Return the decoded content if found, otherwise return an empty string
                return Json(HttpUtility.HtmlDecode(content ?? string.Empty));
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json("");
        }

        [HttpPost]
        [Route("/BindFooter")]
        public JsonResult BindFooter()
        {
            try
            {
                // Retrieve content based on the specified templateId and LanguageId, or default to LanguageId 1
                var content = GetContentForTemplate(LanguageId, "FooterDesign") ?? GetContentForTemplate(1, "FooterDesign");

                // Return the decoded content if found, otherwise return an empty string
                return Json(HttpUtility.HtmlDecode(content ?? string.Empty));
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json("");
        }

        [Route("/GetPopup")]
        public async Task<JsonResult> GetPopup()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                List<PopupModel> lstPopupList = objPopupServices.GetListFront(LanguageId).Where(x => x.IsActive == true).ToList();
                if (lstPopupList.Count() == 0)
                {
                    lstPopupList = objPopupServices.GetListFront(1).Where(x => x.IsActive == true).ToList();
                }
                if (lstPopupList.Count() > 0)
                {
                    objreturn.result = lstPopupList;
                    objreturn.isError = false;
                }
                else
                {
                    objreturn.isError = false;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Found, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        [Route("/GetBanner")]
        public JsonResult GetBanner()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                IEnumerable<BannerModel> query = objBannerService.GetListFront(LanguageId).Where(x => x.IsActive == true).OrderBy(x => x.BannerRank);
                if (query.Count() == 0)
                {
                    query = objBannerService.GetListFront(1).Where(x => x.IsActive == true).OrderBy(x => x.BannerRank);
                }
                var lstBannerList = query.ToList();
                objreturn.result = lstBannerList;
                objreturn.isError = false;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Found, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }

            return Json(objreturn);
        }

        [Route("/GetAnnouncement")]
        public JsonResult GetAnnouncement()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                List<NewsModel> lstAnnouncementList = objNewsMasterService.GetListFront(LanguageId, "Announcement").ToList();
                if (lstAnnouncementList.Count() == 0)
                {
                    lstAnnouncementList = objNewsMasterService.GetListFront(1, "Announcement").ToList();
                }
                if (lstAnnouncementList.Count() > 0)
                {
                    objreturn.result = lstAnnouncementList.Where(x => x.IsActive == true);
                    objreturn.isError = false;
                }
                else
                {
                    objreturn.isError = false;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Found, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        [Route("/GetMinister")]
        public JsonResult GetMinister()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                List<MinisterModel> lstMinisterList = objMinisterServices.GetListFront(LanguageId).ToList();
                if (lstMinisterList.Count() == 0)
                {
                    lstMinisterList = objMinisterServices.GetListFront(1).ToList();
                }
                if (lstMinisterList.Count() > 0)
                {
                    objreturn.result = lstMinisterList.Where(x => x.IsActive == true); ;
                    objreturn.isError = false;
                }
                else
                {
                    objreturn.result = lstMinisterList;
                    objreturn.isError = false;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Found, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        [HttpPost]
        [Route("/BindWelComeNote")]
        public JsonResult BindWelComeNote()
        {
            try
            {
                // Retrieve content based on the specified templateId and LanguageId, or default to LanguageId 1
                var content = GetContentForTemplate(LanguageId, "WelcomeNote") ?? GetContentForTemplate(1, "WelcomeNote");

                // Return the decoded content if found, otherwise return an empty string
                return Json(HttpUtility.HtmlDecode(content ?? string.Empty));
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json("");
        }

        [HttpPost]
        [Route("/GetServiceRate")]
        public JsonResult GetServiceRate()
        {

			JsonResponseModel objreturn = new JsonResponseModel();
			try
			{
				List<ServiceRateModel> serviceList = serviceRateService.GetList(LanguageId).ToList();

				if (serviceList.Count() == 0)
				{
					serviceList = serviceRateService.GetList(1).OrderBy(x => x.ServiceRank).ToList();
				}
				if (serviceList.Count() > 0)
				{
					objreturn.result = serviceList.Where(x => x.IsActive == true).OrderBy(x => x.ServiceRank);
					objreturn.isError = false;
				}

				else
				{
					objreturn.isError = false;

				}
			}
			catch (Exception ex)
			{
				ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
				objreturn.strMessage = "Record not Found, Try again";
				objreturn.isError = true;
				objreturn.type = PopupMessageType.error.ToString();
			}

			return Json(objreturn);


		}

        [Route("/GetNews")]
        public JsonResult GetNews()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                List<NewsModel> lstNewsList = objNewsMasterService.GetListFront(LanguageId, "Latest News").ToList();
                if (lstNewsList.Count() == 0)
                {
                    lstNewsList = objNewsMasterService.GetListFront(1, "Latest News").ToList();
                }
                if (lstNewsList.Count() > 0)
                {
                    objreturn.result = lstNewsList.Where(x => x.IsActive == true);
                    objreturn.isError = false;
                }
                else
                {
                    objreturn.isError = false;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Found, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

    
        [Route("GetProjects")]
        public JsonResult GetProjects()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                List<ProjectModel> projectList = projectService.GetList(LanguageId).ToList();

                if (projectList.Count() == 0)
                {
                    projectList = projectService.GetList(LanguageId).ToList();
                }
                if (projectList.Count() > 0)
                {
                    objreturn.result = projectList.Where(x => x.IsActive == true );
                    objreturn.isError = false;
                }

                else
                {
                    objreturn.isError = false;
                   
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Found, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }

            return Json(objreturn);
        }


        [Route("GetAllBrandLogo")]
        public JsonResult GetAllBrandLogo()
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {

                List<GoiLogoModel> LogoList = objGoiLogoServices.GetList(LanguageId).ToList();

                if (LogoList.Count() > 0)
                {
                    objreturn.result = LogoList.Where(x => x.IsActive == true);
                    objreturn.isError = false;
                }

                else
                {
                    // objreturn.strMessage = "LogoList Not Found";
                    objreturn.isError = true;
                    // objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Found, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }

            return Json(objreturn);
        }

        public IActionResult ProjectDetailspage(string id)
        {
            ProjectModel model = new ProjectModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    model = projectService.Get(lgid, LanguageId);

                    // If model is null, call the service with LanguageId = 1
                    if (model == null)
                    {
                        model = projectService.Get(lgid, 1);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return View(model);
        }

        public IActionResult ServiceRateDetails(string id)
        {
            ServiceRateModel model = new ServiceRateModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    model = serviceRateService.Get(lgid, LanguageId);

                    // If model is null, call the service with LanguageId = 1
                    if (model == null)
                    {
                        model = serviceRateService.Get(lgid, 1);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return View(model);
        }

        [HttpPost]
        [Route("/BindHiddenTemplate")]
        public JsonResult BindHiddenTemplate()
        {
            try
            {
                // Retrieve content based on the specified templateId and LanguageId, or default to LanguageId 1
                var content = GetContentForTemplate(LanguageId, "HiddenTemplate") ?? GetContentForTemplate(1, "HiddenTemplate");

                // Return the decoded content if found, otherwise return an empty string
                return Json(HttpUtility.HtmlDecode(content ?? string.Empty));
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json("");
        }

        #endregion

        #endregion
    }
}
