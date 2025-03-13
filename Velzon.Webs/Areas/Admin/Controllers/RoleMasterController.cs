using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Velzon.Webs.Models;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class RoleMasterController : BaseController<RoleMasterController>
    {
        #region Controller Variable
        private IRoleMasterService objIRoleMasterService { get; set; }
        #endregion

        #region Controller Constructor
        public RoleMasterController(IRoleMasterService _roleMasterService)
        {
            this.objIRoleMasterService = _roleMasterService;
        }
        #endregion

        #region Controller Methods

        #region Role Master

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/RoleMaster")]
        public IActionResult RoleMaster()
        {
            try
            {
                return View();
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Account");
            }
        }

        [Route("/Admin/SaveRoleData")]
        [HttpPost]
        public JsonResult SaveRoleData(RoleMasterFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ModelState.IsValid)
                {
                    RoleMasterModel roleMasterModel = new RoleMasterModel();
                    roleMasterModel.Id = objModel.Id;
                    roleMasterModel.RoleName = objModel.RoleName;
                    roleMasterModel.IsActive = objModel.IsActive;
                    roleMasterModel.CreatedBy = UserModel.Username;

                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                    {
                        objreturn = objIRoleMasterService.AddOrUpdate(roleMasterModel);
                    }
                    else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                    {
                        objreturn = objIRoleMasterService.AddOrUpdate(roleMasterModel);
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
                    objreturn.strMessage = "Form Input is not valid";
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
            }
            return Json(objreturn);
        }

        //[IgnoreAntiforgeryToken]
        [HttpPost]
        [Route("/Admin/GetRoleData")]
        public JsonResult GetRoleData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            List<RoleMasterModel> lsdata = new List<RoleMasterModel>();
            try
            {
                int SuperAdminRoleId = int.TryParse(ConfigDetailsValue.SuperAdminRoleId, out var result) ? result : 1;
                if (UserModel.RoleId != SuperAdminRoleId)
                {
                    lsdata = objIRoleMasterService.GetList().Where(x => x.Id != SuperAdminRoleId).ToList();
                }
                else
                {
                    lsdata = objIRoleMasterService.GetList();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
        }

        [Route("/Admin/GetRoleDataDetails")]
        [HttpPost]
        public JsonResult GetRoleDetails(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            RoleMasterModel lsdata = new RoleMasterModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    objreturn.result = lsdata = objIRoleMasterService.Get(lgid);
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

        [Route("/Admin/DeleteRoleData")]
        [HttpPost]
        public JsonResult DeleteRoleData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        var checkDependency = objIRoleMasterService.CheckRoleAssignedUser(lgid);
                        if (checkDependency == null || !checkDependency.Any())
                        {
                            objreturn = objIRoleMasterService.Delete(lgid, UserModel.Username);
                        }
                        else
                        {
                            objreturn.strMessage = "The role you are attempting to delete is already assigned to a user.";
                            objreturn.isError = true;
                            objreturn.type = PopupMessageType.error.ToString();
                        }
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

        #endregion

        #endregion
    }
}
