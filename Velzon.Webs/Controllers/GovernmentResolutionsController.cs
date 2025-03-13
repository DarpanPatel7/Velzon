using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;
using Velzon.Model.System;

namespace Velzon.Webs.Controllers
{
    public class GovernmentResolutionsController : Controller
    {
        #region Controller Variable

        protected readonly IEcitizenService objEcitizenService;
        protected readonly IBranchService objBranchService;

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

        public GovernmentResolutionsController(IHttpClientFactory _httpClientFactory, IEcitizenService _objEcitizenService, IBranchService _objBranchService)
        {
            objEcitizenService = _objEcitizenService;
            objBranchService = _objBranchService;
        }

        #endregion

        #region Controller Methods
        [HttpPost]
        [Route("/BindGovernmentResolutionGrid")]
        public JsonResult BindGovernmentResolutionGrid(DateTime? FromDate, DateTime? ToDate, string? Number, string? Subject, string? SubjectId, string? BranchId, int currentPage)
        {
            try
            {
                int PerPage = int.TryParse(ConfigDetailsValue.GovernmentResolutionPerPage, out var result) ? result : 10;
                GovernmentResolutionListMasterModel lstGRList = new GovernmentResolutionListMasterModel();
                IEnumerable<EcitizenModel> query = objEcitizenService.GetListFront(LanguageId, "Government Resolution");
                if (query.Count() == 0)
                {
                    query = objEcitizenService.GetListFront(1, "Government Resolution");
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
                if (BranchId != null && BranchId != "0")
                {
                    query = query.Where(x => x.BranchId == BranchId);
                }

                // Convert the query to a list
                var filteredList = query.ToList();

                // Calculate the total number of pages
                double pageCount = (double)filteredList.Count / PerPage;
                lstGRList.PageCount = (int)Math.Ceiling(pageCount);

                // Paginate the filtered list
                lstGRList.ResultList = filteredList
                    .Skip((currentPage - 1) * PerPage)
                    .Take(PerPage)
                    .ToList();

                // Set the current page number
                lstGRList.CurrentPageList = currentPage;
                lstGRList.PerPage = PerPage;

                return Json(lstGRList);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [HttpPost]
        [Route("/BindBranch")]
        public JsonResult BindBranch()
        {
            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                // Set the default text based on the language
                string defaultText = LanguageId == 2 ? "-- શાખા પસંદ કરો --" : "-- Select Branch --";
                lsdata.Add(new ListItem { Text = defaultText, Value = "0" });

                // Fetch and order the branch list
                lsdata.AddRange(objBranchService.GetListFront(LanguageId)
                    .OrderBy(x => x.Id)
                    .Select(x => new ListItem { Text = x.BranchName, Value = x.BranchId.ToString() })
                    .ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }
        #endregion

        #region view
        [Route("/GovernmentResolution")]
        public IActionResult GovernmentResolution()
        {
            return View();
        }
        #endregion
    }
}
