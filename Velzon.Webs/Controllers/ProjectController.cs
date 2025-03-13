using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Controllers;

public class ProjectController : Controller
{
    protected readonly IProjectService projectService;
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
    public IActionResult Index()
    {
        return View();
    }

    public ProjectController(IProjectService projectService)
    {
        this.projectService = projectService;


    }

    [Route("/ProjectList")]
    public IActionResult ProjectList()
    {
        return View();
    }

    [Route("GetProjectList")]
    public async Task<JsonResult> GetProjectList(string id)
    {
        JsonResponseModel objreturn = new JsonResponseModel();
        try
        {
            List<ProjectModel> SchemeProjectList = projectService.GetList(LanguageId).ToList();

            if (SchemeProjectList.Count() == 0)
            {
                SchemeProjectList = projectService.GetList(1).ToList();
            }
            if (SchemeProjectList.Count() > 0)
            {
                objreturn.result = SchemeProjectList.Where(x => x.IsActive == true);
                objreturn.isError = false;
            }

            else
            {
                objreturn.isError = false;
                //objreturn.strMessage = "Blog Not Found";
                //objreturn.isError = true;
                //objreturn.type = PopupMessageType.error.ToString();
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

    [Route("/GetAllProjectImagesById")]
    public JsonResult GetAllProjectImagesById(string projectMasterId)
    {
        JsonResponseModel objreturn = new JsonResponseModel();
        try
        {
            if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(projectMasterId), out long lgid))
            {

                List<ProjectModel> projectList = projectService.GetList(LanguageId).ToList();

                if (projectList.Count() == 0)
                {
                    projectList = projectService.GetList(1).ToList();
                }
                if (projectList.Count() > 0)
                {
                    objreturn.result = projectList.Where(x => x.IsActive == true && x.ProjectMasterId == lgid);
                    objreturn.isError = false;
                }
                else
                {
                    objreturn.isError = false;
                }
            }

        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

            objreturn.strMessage = "Record not Found.";
            objreturn.isError = true;
            objreturn.type = PopupMessageType.error.ToString();
        }
        return Json(objreturn);

    }

    [HttpPost]
    [Route("/BindProjectList")]
    public JsonResult BindProjectList(int currentPage)
    {
        try
        {
            int PerPage = int.TryParse(ConfigDetailsValue.ProjectsPerPage, out var result) ? result : 9;
            ProjectListMasterModel projectListMasterModel= new ProjectListMasterModel();
            IEnumerable<ProjectModel> query = projectService.GetList(LanguageId).Where(x => x.IsActive == true);
            if (query.Count() == 0)
            {
                query = projectService.GetList(1);
            }

            // Convert the query to a list
            var filteredList = query.ToList();

            // Calculate the total number of pages
            double pageCount = (double)filteredList.Count / PerPage;
            projectListMasterModel.PageCount = (int)Math.Ceiling(pageCount);

            // Paginate the filtered list
            projectListMasterModel.ResultList = filteredList
                .Skip((currentPage - 1) * PerPage)
                .Take(PerPage)
                .ToList();

            // Set the current page number
            projectListMasterModel.CurrentPageList = currentPage;
            projectListMasterModel.PerPage = PerPage;

            return Json(projectListMasterModel);
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            return Json("");
        }
    }

}