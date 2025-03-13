using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;
using System.Net;

namespace Velzon.Webs.Controllers
{
    public class PhotoGalleryController : Controller
    {
        #region Controller Variable

        protected readonly IGalleryService objGalleryService;

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

        public PhotoGalleryController(IGalleryService _objGalleryService)
        {
            objGalleryService = _objGalleryService;
        }

        #endregion

        #region Controller Methos

        #region Ajax
        [HttpPost]
        [Route("/BindPhotoGalleryFirstData")]
        public JsonResult BindPhotoGalleryFirstData(int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.PhotoGalleryPerPage, out var result) ? result : 9;
                PhotoGalleryListMasterModel lstPhotoGalleryList = new PhotoGalleryListMasterModel();
                IEnumerable<AlbumModel> query = objGalleryService.GetAlbum(LanguageId);
                if (query.Count() == 0)
                {
                    query = objGalleryService.GetAlbum(1);
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstPhotoGalleryList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstPhotoGalleryList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstPhotoGalleryList.CurrentPageList = currentPage;
                lstPhotoGalleryList.PerPage = PerPage;

                return Json(lstPhotoGalleryList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [HttpPost]
        [Route("BindPhotoGalleryDetailData")]
        public JsonResult BindPhotoGalleryDetailData(long id, int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.PhotoGalleryPerPage, out var result) ? result : 10;
                PhotoGalleryDetailListMasterModel lstPhotoGalleryList = new PhotoGalleryDetailListMasterModel();
                IEnumerable<GalleryImagesModel> query = objGalleryService.GetAlbumImages(id, LanguageId);
                if (query.Count() == 0)
                {
                    query = objGalleryService.GetAlbumImages(id, 1);
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstPhotoGalleryList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstPhotoGalleryList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstPhotoGalleryList.CurrentPageList = currentPage;
                lstPhotoGalleryList.PerPage = PerPage;

                return Json(lstPhotoGalleryList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json("");

        }
        #endregion

        #region View Page
        [Route("/PhotoGallery")]
        public IActionResult PhotoGallery()
        {
            return View();
        }

        [Route("/PhotoGalleryDetail")]
        public IActionResult PhotoGalleryDetail()
        {
            EventTypeModel modelPhotoGallery = new EventTypeModel();
            try
            {
                string strQuery = HttpContext.Request.QueryString.ToString();
                strQuery = Velzon.Common.Functions.FrontDecrypt(WebUtility.UrlDecode(strQuery.Replace("?", "")));
                string[] data = strQuery.Split("||");

                data = data.Where(x => !string.IsNullOrWhiteSpace(x)).ToArray();

                string eventid = strQuery.ToString();
                modelPhotoGallery.Id = Convert.ToInt32(eventid.ToString());

                return View(modelPhotoGallery);
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
