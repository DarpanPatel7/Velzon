using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Microsoft.AspNetCore.Mvc;
using System.Web;
using Velzon.Services.Service;

namespace Velzon.Webs.Areas.Admin.Controllers;

[AutoValidateAntiforgeryToken]
[Area("Admin")]
public class ProjectMasterController : BaseController<ProjectMasterController>
{


    private readonly IProjectService projectService;
    public ProjectMasterController(IProjectService projectService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
    {
        this.projectService = projectService;
    }


    [HttpGet]
    [Route("/Admin/ProjectMaster")]
    public IActionResult ProjectMaster()
    {
        try
        {
            Common.Functions.GetPageRights(UserModel.RoleId, HttpContext);
            var model = Common.Functions.GetPageRightsCheck(HttpContext.Session);
            if (model == null)
            {
                return RedirectToAction("Dashboard", "Home");
            }
            try
            {
                var sDataIssue = DataIssue;
                if (sDataIssue != null)
                {
                    Functions.MessagePopup(this, sDataIssue.strMessage, (sDataIssue.isError ? PopupMessageType.error : PopupMessageType.success));
                }
            }
            catch (Exception ex)
            {

            }
            return View();
        }
        catch (Exception ex)
        {
            return RedirectToAction("Index", "Account");
        }
        return View();
    }


    [Route("Admin/SaveProjectData")]
    [DisableRequestSizeLimit]
    [HttpPost]

    public async Task<JsonResult> SaveProjectData([FromForm] ProjectMasterModel projectMasterModel)
    {
        var response = new JsonResponseModel();
        var projectModel = new ProjectModel();

        try
        {
            if (ValidProjectData(projectMasterModel, ref response))
            {
                if (ModelState.IsValid)
                {

                    if (projectMasterModel.File != null)
                    {
                        var data = (await Functions.SaveFile(projectMasterModel.File, httpClientFactory, "Project", projectMasterModel.FilePath, FileType.AllType));

                        if (data != null)
                        {
                            if (!data.isError)
                            {
                                projectModel.FileUpload = data.result.Filename;
                                projectModel.FilePath = data.result.FilePath;
                            }
                            else
                            {
                                return Json(data);
                            }
                        }
                        else
                        {
                            response.strMessage = "File Save Error, please try again.";
                            response.isError = true;
                            response.type = PopupMessageType.error.ToString();
                        }
                    }
                    else
                    {
                        projectModel.FilePath = projectMasterModel.FilePath;
                    }


                    projectModel.Id = projectMasterModel.Id;
                    projectModel.LanguageId = projectMasterModel.LanguageId;
                    projectModel.ProjectName = projectMasterModel.ProjectName;
                    //projectModel.Description = Common.Functions.CKEditerSanitizer((projectMasterModel.Description));
                    projectModel.Description = projectMasterModel.Description;
                    projectModel.ProjectBy = UserModel.Username;
                    projectModel.ProjectDate = string.IsNullOrWhiteSpace(projectMasterModel.ProjectDate) ? (DateTime?)null : DateTime.ParseExact(projectMasterModel.ProjectDate, "dd/MM/yyyy", null);
                    projectModel.IsActive = projectMasterModel.IsActive;
                    projectModel.CreatedBy = UserModel.Username;
                    projectModel.UpdatedBy = UserModel.Username;
                    projectModel.Location = projectMasterModel.Location;
                    projectModel.MetaTitle = projectMasterModel.MetaTitle;
                    projectModel.MetaDescription = projectMasterModel.MetaDescription;

                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && projectMasterModel.Id == 0)
                    {
                        response = projectService.AddOrUpdate(projectModel);
                    }
                    else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && projectMasterModel.Id != 0)
                    {
                        projectModel.ProjectMasterId = (int)projectMasterModel.ProjectMasterId;
                        response = projectService.AddOrUpdate(projectModel);
                    }
                    else
                    {
                        response.strMessage = "You don't have rights to perform this action.";
                        response.isError = true;
                        response.type = PopupMessageType.error.ToString();
                    }
                }
            }


            else
            {
                response.strMessage = response.strMessage;
                response.isError = true;
                response.type = PopupMessageType.error.ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            response.strMessage = "Record not saved, please try again.";
            response.isError = true;
            response.type = PopupMessageType.error.ToString();
        }

        return Json(response);
    }


    [HttpPost]
    [Route("/Admin/GetProjectData")]
    public JsonResult GetProjectData()
    {
        var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

        try
        {
            var lsdata = projectService.GetList();

            return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

            return Json("");
        }

    }

    [Route("/Admin/GetProjectDetails")]
    [HttpPost]
    public JsonResult GetProjectDetails(string id, string langId)
    {
        JsonResponseModel objreturn = new JsonResponseModel();
        try
        {

            if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
            {
                objreturn.strMessage = "";
                objreturn.isError = false;
                objreturn.result = projectService.Get(lgid, lgLangId);
            }
            else
            {
                objreturn.strMessage = "Enter Valid Id.";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
        }
        return Json(objreturn);
    }

    [Route("/Admin/DeleteProjectData")]
    [HttpPost]
    public JsonResult DeleteProjectData(string id)
    {
        JsonResponseModel objreturn = new JsonResponseModel();
        try
        {
            if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
            {
                if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                {
                    objreturn = projectService.Delete(lgid, UserModel.Username);
                }
                else
                {
                    objreturn.strMessage = "You Don't have Rights perform this action.";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            else
            {
                objreturn.strMessage = "Record not deleted, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            objreturn.strMessage = "Record not deleted, Try again";
            objreturn.isError = true;
            objreturn.type = PopupMessageType.error.ToString();
        }
        return Json(objreturn);
    }

    public bool ValidProjectData(ProjectMasterModel formmodel, ref JsonResponseModel objreturn)
    {
        bool allow = true; // Start with true, and set to false if any validation fails
        try
        {
            // Validate Project Name
            if (!ValidControlValue(formmodel.ProjectName, ControlInputType.none))
            {
                objreturn.strMessage = "Enter project name!";
                allow = false;
            }

            // Validate Project Date
            if (!ValidControlValue(formmodel.ProjectDate, ControlInputType.none))
            {
                objreturn.strMessage = "Enter valid project date!";
                allow = false;
            }

            // Validate Meta Title (if provided)
            if (!string.IsNullOrEmpty(formmodel.MetaTitle))
            {
                if (!ValidControlValue(formmodel.MetaTitle, ControlInputType.none))
                {
                    objreturn.strMessage = "Enter valid Meta Title!";
                    allow = false;
                }
            }

            // Validate Meta Description (if provided)
            if (!string.IsNullOrEmpty(formmodel.MetaDescription))
            {
                if (!ValidControlValue(formmodel.MetaDescription, ControlInputType.none))
                {
                    objreturn.strMessage = "Enter valid Meta description!";
                    allow = false;
                }
            }

            // Validate Location (if provided)
            if (!string.IsNullOrEmpty(formmodel.Location))
            {
                if (!ValidControlValue(formmodel.Location, ControlInputType.none))
                {
                    objreturn.strMessage = "Enter valid location!";
                    allow = false;
                }
            }

            // Validate Project Image
            if (formmodel.File == null && Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && formmodel.Id == 0)
            {
                objreturn.strMessage = "Upload project image!";
                allow = false;
            }

            // Validate Project Description
            if (string.IsNullOrEmpty(formmodel.Description))
            {
                objreturn.strMessage = "Enter project description!";
                allow = false;
            }

            // Validate Project Date (again to ensure it's not null)
            if (string.IsNullOrEmpty(formmodel.ProjectDate))
            {
                objreturn.strMessage = "Enter project date!";
                allow = false;
            }

            // Set error response if validation failed
            if (!allow)
            {
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            objreturn.strMessage = "Record not saved, Try again";
            objreturn.isError = true;
            objreturn.type = PopupMessageType.error.ToString();
            allow = false; // In case of an exception, don't allow the operation
        }

        return allow;
    }

    [Route("/Admin/UpdateProjectStatus")]
    [HttpPost]
    public JsonResult UpdateProjectStatus(string id, int isActive)
    {
        JsonResponseModel objreturn = new JsonResponseModel();
        try
        {
            if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
            {
                if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                {
                    objreturn = projectService.UpdateStatus(lgid, UserModel.Username, isActive);
                }
                else
                {
                    objreturn.strMessage = "You Don't have Rights to perform this action.";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            else
            {
                objreturn.strMessage = "Status not updated, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            objreturn.strMessage = "Status not updated, Try again";
            objreturn.isError = true;
            objreturn.type = PopupMessageType.error.ToString();
        }
        return Json(objreturn);
    }

}