using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Controllers
{
    public class NotificationCircularController : Controller
    {
        #region Controller Variable

        protected readonly IEcitizenService objEcitizenService;

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

        public NotificationCircularController(IEcitizenService _objEcitizenService)
        {
            objEcitizenService = _objEcitizenService;
        }

        #endregion

        #region Controller Methos
        [HttpPost]
        [Route("/BindNotificationCircularGrid")]
        public JsonResult BindNotificationCircularGrid(DateTime? FromDate, DateTime? ToDate, string? Number, string? Subject, int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.NotificationCircularPerPage, out var result) ? result : 10;
                NotificationCircularListMasterModel lstNCList = new NotificationCircularListMasterModel();
                IEnumerable<EcitizenModel> query = objEcitizenService.GetListFront(LanguageId, "Notification Circular");
                if (query.Count() == 0)
                {
                    query = objEcitizenService.GetListFront(1, "Notification Circular");
                }
                if (FromDate != null && ToDate != null)
                {
                    query = query.Where(x => x.Date >= FromDate && x.Date <= ToDate);
                }
                if (Number != null)
                {
                    query = query.Where(x => x.Number != null && x.Number.ToLower().Contains(Number.ToLower()));
                }
                if (Subject != null)
                {
                    query = query.Where(x => x.Subject.ToLower().Contains(Subject.ToLower()));
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstNCList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstNCList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstNCList.CurrentPageList = currentPage;
                lstNCList.PerPage = PerPage;

                return Json(lstNCList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [Route("/NotificationCircular")]
        public IActionResult NotificationCircular()
        {
            return View();
        }
        #endregion
    }
}
