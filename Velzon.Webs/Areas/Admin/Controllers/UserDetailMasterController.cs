using Velzon.Webs.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Models;
using Microsoft.AspNetCore.Mvc;
using Velzon.Common;
using Velzon.Webs.Controllers;
using Velzon.Webs.Areas.Admin.Models;
using Google.Protobuf.WellKnownTypes;
using Velzon.Webs.Filters;
using Velzon.Services.Service;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class UserDetailMasterController : BaseController<UserDetailMasterController>
    {
        #region Controller Variable

        private IUserMasterService objUserMasterService { get; set; }
        private IRoleMasterService objRoleMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public UserDetailMasterController(IUserMasterService _userMasterService, IRoleMasterService _roleMasterService)
        {
            this.objUserMasterService = _userMasterService;
            this.objRoleMasterService = _roleMasterService;
        }
        #endregion

        #region Controller Methods

        #region User Master

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/UserMaster")]
        public IActionResult UserMaster()
        {
            try
            {
                UserMasterFormModel userMasterFormModel = new UserMasterFormModel();
                int SuperAdminRoleId = int.TryParse(ConfigDetailsValue.SuperAdminRoleId, out var result) ? result : 1;
                if (UserModel.RoleId != SuperAdminRoleId)
                {
                    userMasterFormModel.RoleList = objRoleMasterService.GetList().Where(x => x.IsActive && x.Id != SuperAdminRoleId).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                }
                else
                {
                    userMasterFormModel.RoleList = objRoleMasterService.GetList().Where(x => x.IsActive).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                }
                return View(userMasterFormModel);
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Account");
            }
        }

        [Route("/Admin/SaveUserData")]
        [HttpPost]
        public JsonResult SaveUserData(UserMasterFrontModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidUserData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        UserMasterModel userMasterModel = new UserMasterModel();
                        userMasterModel.Id = objModel.Id;
                        userMasterModel.FirstName = objModel.FirstName;
                        userMasterModel.LastName = objModel.LastName;
                        //userMasterModel.Username = Velzon.Common.Functions.FrontDecrypt(objModel.Username);
                        //userMasterModel.UserPassword = Velzon.Common.Functions.Encrypt(Velzon.Common.Functions.FrontDecrypt(objModel.UserPassword));
                        userMasterModel.RoleId = objModel.RoleId;
                        userMasterModel.Email = objModel.Email;
                        userMasterModel.PhoneNo = objModel.PhoneNo;
                        userMasterModel.IsActive = objModel.IsActive;
                        userMasterModel.CreatedBy = UserModel.Username;
                        userMasterModel.Username = Velzon.Common.Functions.FrontDecrypt(objModel.Username);
                        if (!string.IsNullOrEmpty(objModel.UserPassword))
                        {
                            userMasterModel.UserPassword = Velzon.Common.Functions.Encrypt(objModel.UserPassword);
                        }

                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            objreturn = objUserMasterService.AddOrUpdate(userMasterModel);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {
                            objreturn = objUserMasterService.AddOrUpdate(userMasterModel);
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

        public bool ValidUserData(UserMasterFrontModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.FirstName, ControlInputType.text))
                {
                    if (ValidLength(objModel.FirstName))
                    {
                        objreturn.strMessage = "Enter valid first name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter first name!";
                    }
                }
                else if (ValidLength(objModel.LastName) && !ValidControlValue(objModel.LastName, ControlInputType.text))
                {
                    objreturn.strMessage = "Enter valid last name!";
                }
                else if (!ValidControlValue(Velzon.Common.Functions.FrontDecrypt(objModel.Username), ControlInputType.text))
                {
                    if (ValidLength(Velzon.Common.Functions.FrontDecrypt(objModel.Username)))
                    {
                        objreturn.strMessage = "Enter valid user name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter user name!";
                    }
                }
                else if ((bool)VerifyExistingUserDetails(Velzon.Common.Functions.FrontDecrypt(objModel.Username), 1, objModel.Id).Value)
                {
                    objreturn.strMessage = "User already exists!";
                }
                else if (!ValidControlValue(objModel.UserPassword, ControlInputType.none) && Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                {
                    if (ValidLength(objModel.UserPassword))
                    {
                        objreturn.strMessage = "Enter valid password!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter password!";
                    }
                }
                else if (!ValidControlValue(objModel.Email, ControlInputType.email))
                {
                    if (ValidLength(objModel.Email))
                    {
                        objreturn.strMessage = "Enter valid email ID!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter email ID!";
                    }
                }
                else if ((bool)VerifyExistingUserDetails(objModel.Email, 2, objModel.Id).Value)
                {
                    objreturn.strMessage = "Email ID already exists!";
                }
                else if (!ValidControlValue(objModel.PhoneNo, ControlInputType.mobileno))
                {
                    if (ValidLength(objModel.PhoneNo))
                    {
                        objreturn.strMessage = "Enter valid mobile no.!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter mobile no.!";
                    }
                }
                else if ((bool)VerifyExistingUserDetails(objModel.PhoneNo, 3, objModel.Id).Value)
                {
                    objreturn.strMessage = "Mobile no. already exists!";
                }
                else if (!ValidControlValue(objModel.RoleId, ControlInputType.dropdown))
                {
                    objreturn.strMessage = "Select role!";
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

        public JsonResult VerifyExistingUserDetails(string Value, int flg, long Id)
        {
            bool isExist = false;
            try
            {
                UserMasterModel objdata = new UserMasterModel();
                if (!string.IsNullOrEmpty(Value) && flg == 1)
                {
                    if (Id == 0)
                    {
                        objdata = objUserMasterService.GetList().Where(x => x.Username.ToLower() == Value.ToLower()).FirstOrDefault();
                    }
                    else
                    {
                        objdata = objUserMasterService.GetList().Where(x => x.Username.ToLower() == Value.ToLower() && x.Id != Id).FirstOrDefault();
                    }
                    isExist = objdata != null ? true : false;
                }
                else if (!string.IsNullOrEmpty(Value) && flg == 2)
                {
                    if (Id == 0)
                    {
                        objdata = objUserMasterService.GetList().Where(x => x.Email.ToLower() == Value.ToLower()).FirstOrDefault();
                    }
                    else
                    {
                        objdata = objUserMasterService.GetList().Where(x => x.Email.ToLower() == Value.ToLower() && x.Id != Id).FirstOrDefault();
                    }
                    isExist = objdata != null ? true : false;
                }
                else if (!string.IsNullOrEmpty(Value) && flg == 3)
                {
                    if (Id == 0)
                    {
                        objdata = objUserMasterService.GetList().Where(x => x.PhoneNo == Value).FirstOrDefault();
                    }
                    else
                    {
                        objdata = objUserMasterService.GetList().Where(x => x.PhoneNo == Value && x.Id != Id).FirstOrDefault();
                    }
                    isExist = objdata != null ? true : false;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(isExist);

        }

        [Route("/Admin/GetUserData")]
        [HttpPost]
        public JsonResult GetUserData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            List<UserMasterModel> lsdata = new List<UserMasterModel>();
            try
            {
                int SuperAdminRoleId = int.TryParse(ConfigDetailsValue.SuperAdminRoleId, out var result) ? result: 1;
                if (UserModel.RoleId != SuperAdminRoleId)
                {
                    lsdata = objUserMasterService.GetList().Where(x => x.RoleId != SuperAdminRoleId).ToList();
                }
                else
                {
                    lsdata = objUserMasterService.GetList();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
        }

        [Route("/Admin/GetUserDataDetails")]
        [HttpPost]
        public JsonResult GetUserDataDetails(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            UserMasterModel lsdata = new UserMasterModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    objreturn.isError = false;
                    objreturn.result = lsdata = objUserMasterService.Get(lgid);
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

        [Route("/Admin/DeleteUserData")]
        [HttpPost]
        public JsonResult DeleteUserData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = objUserMasterService.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/UpdateUserStatus")]
        [HttpPost]
        public JsonResult UpdateUserStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = objUserMasterService.UpdateStatus(lgid, UserModel.Username, isActive);
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
