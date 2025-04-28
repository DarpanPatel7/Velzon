using Velzon.Webs.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Models;
using Microsoft.AspNetCore.Mvc;
using Velzon.Common;
using Velzon.Webs.Controllers;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Filters;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class MenuResourceURLController : BaseController<MenuResourceURLController>
    {
        #region Controller Variable
        private IMenuResourceMasterService objIMenuResourceMasterService { get; set; }
        #endregion

        #region Controller Constructor
        public MenuResourceURLController(IMenuResourceMasterService _menuResourceMasterService)
        {
            this.objIMenuResourceMasterService = _menuResourceMasterService;
        }
        #endregion

        #region Controller Methods

        #region Menu Resource Master

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/MenuResource")]
        public IActionResult MenuResource()
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

        [Route("/Admin/SaveMenuResourceData")]
        [HttpPost]
        public JsonResult SaveMenuResourceData(MenuResourceFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidMenuResourceData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        MenuResourceMasterModel menuResourceMasterModel = new MenuResourceMasterModel();
                        menuResourceMasterModel.Id = objModel.Id;
                        menuResourceMasterModel.MenuName = objModel.MenuName;
                        menuResourceMasterModel.MenuURL = objModel.MenuURL;
                        menuResourceMasterModel.IsActive = objModel.IsActive;
                        menuResourceMasterModel.CreatedBy = UserModel.Username;

                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            objreturn = objIMenuResourceMasterService.AddOrUpdate(menuResourceMasterModel);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {
                            objreturn = objIMenuResourceMasterService.AddOrUpdate(menuResourceMasterModel);
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
                else
                {
                    objreturn.strMessage = objreturn.strMessage;
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

        public bool ValidMenuResourceData(MenuResourceFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.MenuName, ControlInputType.text))
                {
                    if (ValidLength(objModel.MenuName))
                    {
                        objreturn.strMessage = "Enter valid menu name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter menu name!";
                    }
                }
                else if (!ValidControlValue(objModel.MenuURL, ControlInputType.none))
                {
                    if (ValidLength(objModel.MenuURL))
                    {
                        objreturn.strMessage = "Enter valid menu url!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter menu url!";
                    }
                }
                else
                {
                    allow = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not saved, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return allow;
        }

        [Route("/Admin/GetMenuResourceData")]
        [HttpPost]
        public JsonResult GetMenuResourceData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            List<MenuResourceMasterModel> lsdata = new List<MenuResourceMasterModel>();
            try
            {
                lsdata = objIMenuResourceMasterService.GetList();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
        }

        [Route("/Admin/GetMenuResourceDataDetails")]
        [HttpPost]
        public JsonResult GetMenuResourceDataDetails(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            MenuResourceMasterModel lsdata = new MenuResourceMasterModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    objreturn.isError = false;
                    objreturn.result = lsdata = objIMenuResourceMasterService.Get(lgid);
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

        [Route("/Admin/DeleteMenuResourceData")]
        [HttpPost]
        public JsonResult DeleteMenuResourceData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = objIMenuResourceMasterService.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/UpdateMenuResourceStatus")]
        [HttpPost]
        public JsonResult UpdateMenuResourceStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = objIMenuResourceMasterService.UpdateStatus(lgid, UserModel.Username, isActive);
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

        #endregion

        #endregion

    }
}
