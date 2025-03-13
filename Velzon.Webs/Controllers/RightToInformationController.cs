using Velzon.Model.Service;
using Velzon.Common;
using Velzon.IService.Service;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Controllers
{
    public class RightToInformationController : Controller
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

        public RightToInformationController(IEcitizenService _objEcitizenService)
        {
            objEcitizenService = _objEcitizenService;
        }

        #endregion

        #region Controller Methos
        [HttpPost]
        [Route("/BindRightToInformationGrid")]
        public JsonResult BindRightToInformationGrid(int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.RightToInformationPerPage, out var result) ? result : 10;
                RightToInformationListMasterModel lstRTIList = new RightToInformationListMasterModel();
                IEnumerable<EcitizenModel> query = objEcitizenService.GetListFront(LanguageId, "Right to Information");
                if (query.Count() == 0)
                {
                    query = objEcitizenService.GetListFront(1, "Right to Information");
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstRTIList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstRTIList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstRTIList.CurrentPageList = currentPage;
                lstRTIList.PerPage = PerPage;

                return Json(lstRTIList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [Route("/RightToInformation")]
        public IActionResult RightToInformation()
        {
            return View();
        }
        #endregion
    }
}
