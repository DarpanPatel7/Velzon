using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Controllers
{
    public class NewsController : Controller
    {
        #region Controller Variable

        protected readonly INewsMasterService objNewsMasterService;

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

        public NewsController(INewsMasterService _objNewsMasterService)
        {
            objNewsMasterService = _objNewsMasterService;
        }

        #endregion

        #region Controller Methos
        [HttpPost]
        [Route("/BindNewsGrid")]
        public JsonResult BindNewsGrid(int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.NewsPerPage, out var result) ? result : 10;
                NewsListMasterModel lstNList = new NewsListMasterModel();
                IEnumerable<NewsModel> query = objNewsMasterService.GetListFront(LanguageId, "Latest News");
                if (query.Count() == 0)
                {
                    query = objNewsMasterService.GetListFront(1, "Latest News");
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstNList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstNList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstNList.CurrentPageList = currentPage;
                lstNList.PerPage = PerPage;

                return Json(lstNList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [Route("/News")]
        public IActionResult News()
        {
            return View();
        }
        #endregion
    }
}
