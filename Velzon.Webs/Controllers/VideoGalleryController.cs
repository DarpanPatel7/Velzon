using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace Velzon.Webs.Controllers
{
    public class VideoGalleryController : Controller
    {
        #region Controller Variable

        protected readonly IVideoService objVideoService;

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

        public VideoGalleryController(IVideoService _objVideoService)
        {
            objVideoService = _objVideoService;
        }

        #endregion

        #region Controller Methos

        #region Ajax
        [HttpPost]
        [Route("/BindVideoGalleryFirstData")]
        public JsonResult BindVideoGalleryFirstData(int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.VideoGalleryPerPage, out var result) ? result : 9;
                VideoGalleryListMasterModel lstVideoGalleryList = new VideoGalleryListMasterModel();
                IEnumerable<VideoModel> query = objVideoService.GetFrontcategory(LanguageId);
                if (query.Count() == 0)
                {
                    query = objVideoService.GetFrontcategory(LanguageId);
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstVideoGalleryList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstVideoGalleryList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstVideoGalleryList.CurrentPageList = currentPage;
                lstVideoGalleryList.PerPage = PerPage;

                return Json(lstVideoGalleryList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [HttpPost]
        [Route("BindVideoGalleryDetailData")]
        public JsonResult BindVideoGalleryDetailData(long id, int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.VideoGalleryPerPage, out var result) ? result : 10;
                VideoGalleryDetailListMasterModel lstVideoGalleryList = new VideoGalleryDetailListMasterModel();
                IEnumerable<VideoModel> query = objVideoService.GetFrontcategoryDetails(id, LanguageId);
                if (query.Count() == 0)
                {
                    query = objVideoService.GetFrontcategoryDetails(id, LanguageId);
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstVideoGalleryList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstVideoGalleryList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstVideoGalleryList.CurrentPageList = currentPage;
                lstVideoGalleryList.PerPage = PerPage;

                return Json(lstVideoGalleryList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json("");

        }
        #endregion

        #region View Page
        [Route("/VideoGallery")]
        public IActionResult VideoGallery()
        {
            return View();
        }

        [Route("/VideoGalleryDetail")]
        public IActionResult VideoGalleryDetail()
        {
            VideoTypeModel modelVideoGallery = new VideoTypeModel();
            try
            {
                string strQuery = HttpContext.Request.QueryString.ToString();
                strQuery = Velzon.Common.Functions.FrontDecrypt(WebUtility.UrlDecode(strQuery.Replace("?", "")));
                string[] data = strQuery.Split("||");

                data = data.Where(x => !string.IsNullOrWhiteSpace(x)).ToArray();

                string eventid = strQuery.ToString();
                modelVideoGallery.Id = Convert.ToInt32(eventid.ToString());

                return View(modelVideoGallery);
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Account");
            }
        }
        #endregion

        #endregion
    }
}
