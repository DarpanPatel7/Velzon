using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Controllers
{
    public class OthersController : Controller
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

        public OthersController(IEcitizenService _objEcitizenService)
        {
            objEcitizenService = _objEcitizenService;
        }

        #endregion

        #region Controller Methos
        [HttpPost]
        [Route("/BindOthersGrid")]
        public JsonResult BindOthersGrid(int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.OtherPerPage, out var result) ? result : 10;
                OtherListMasterModel lstOtherList = new OtherListMasterModel();
                IEnumerable<EcitizenModel> query = objEcitizenService.GetListFront(LanguageId, "Others");
                if (query.Count() == 0)
                {
                    query = objEcitizenService.GetListFront(1, "Others");
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstOtherList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstOtherList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstOtherList.CurrentPageList = currentPage;
                lstOtherList.PerPage = PerPage;

                return Json(lstOtherList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [Route("/Others")]
        public IActionResult Others()
        {
            return View();
        }
        #endregion
    }
}
