using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Controllers
{
    public class TenderController : Controller
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

        public TenderController(IEcitizenService _objEcitizenService)
        {
            objEcitizenService = _objEcitizenService;
        }

        #endregion

        #region Controller Methos
        [HttpPost]
        [Route("/BindTenderGrid")]
        public JsonResult BindTenderGrid(int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.TenderPerPage, out var result) ? result : 10;
                TenderListMasterModel lstTList = new TenderListMasterModel();
                IEnumerable<EcitizenModel> query = objEcitizenService.GetListFront(LanguageId, "Tender");
                if (query.Count() == 0)
                {
                    query = objEcitizenService.GetListFront(1, "Tender");
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstTList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstTList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstTList.CurrentPageList = currentPage;
                lstTList.PerPage = PerPage;

                return Json(lstTList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [Route("/Tender")]
        public IActionResult Tender()
        {
            return View();
        }
        #endregion
    }
}
