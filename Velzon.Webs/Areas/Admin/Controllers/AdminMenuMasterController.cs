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
    public class AdminMenuMasterController : BaseController<AdminMenuMasterController>
    {
        #region Controller Variable

        private IAdminMenuMasterService objAdminMenuMasterService { get; set; }
        private IMenuResourceMasterService objMenuResourceMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public AdminMenuMasterController(IAdminMenuMasterService _adminMenuMasterService, IMenuResourceMasterService _menuResourceMasterService)
        {
            this.objAdminMenuMasterService = _adminMenuMasterService;
            this.objMenuResourceMasterService = _menuResourceMasterService;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/AdminMenu")]
        public IActionResult AdminMenu()
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


        [Route("/Admin/SaveAdminMenuData")]
        [HttpPost]
        public JsonResult SaveAdminMenuData(AdminMenuFromModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ModelState.IsValid)
                {
                    AdminMenuMasterModel adminMenuMasterModel = new AdminMenuMasterModel();
                    adminMenuMasterModel.Id = objModel.Id;
                    adminMenuMasterModel.MenuId = objModel.MenuId;
                    adminMenuMasterModel.Name = objModel.Name;
                    adminMenuMasterModel.ParentId = (objModel.ParentId==null?0: objModel.ParentId);
                    adminMenuMasterModel.MenuType = objModel.MenuType;
                    adminMenuMasterModel.IsActive = objModel.IsActive;
                    adminMenuMasterModel.CreatedBy = UserModel.Username;

                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                    {
                        adminMenuMasterModel.MenuRank = objAdminMenuMasterService.GetList().Max(x=> x.MenuRank)+1;
                        objreturn = objAdminMenuMasterService.AddOrUpdate(adminMenuMasterModel);
                    }
                    else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                    {
                        adminMenuMasterModel.MenuRank = objAdminMenuMasterService.Get(objModel.Id).MenuRank;
                        objreturn = objAdminMenuMasterService.AddOrUpdate(adminMenuMasterModel);
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

        [HttpPost]
        [Route("/Admin/GetAdminMenuData")]
        public JsonResult GetAdminMenuData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            List<AdminMenuMasterModel> adminMenuMasterModels = new List<AdminMenuMasterModel>();
            try
            {
                var lsdata = objAdminMenuMasterService.GetList().ToList();
                if (lsdata != null)
                {
                    lsdata.ForEach(x =>
                    {
                        if(string.IsNullOrWhiteSpace(x.ParentName))
                        {
                            x.ParentName = x.Name;
                        }
                        var mainMenu = Enum.GetValues(typeof(MenuType)).Cast<MenuType>().Select(d => new ListItem { Text = d.ToString(), Value = ((int)d).ToString() }).Where(y => y.Value == x.MenuType).FirstOrDefault();
                        x.MenuType = mainMenu.Text;
                    });
                    var parentList = lsdata.Where(x => x.ParentId == 0).OrderBy(x => x.ParentId).ThenBy(n => n.MenuRank).OrderByDescending(x => x.MenuType).ToList();
                    if (parentList.Count() > 0)
                    {
                        foreach (var item in parentList.ToList())
                        {
                            adminMenuMasterModels.AddRange(GenerateList(item, lsdata));
                        }
                    }
                }
                return Json(new { draw = draw, recordsFiltered = adminMenuMasterModels.Count(), recordsTotal = adminMenuMasterModels.Count(), data = adminMenuMasterModels });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        private IEnumerable<AdminMenuMasterModel> GenerateList(AdminMenuMasterModel item, List<AdminMenuMasterModel> lsdata)
        {
            List<AdminMenuMasterModel> adminMenuMasterModels = new List<AdminMenuMasterModel>();
            AdminMenuMasterModel mainModel = lsdata.Where(x => x.Id == item.Id).FirstOrDefault();
            if (mainModel != null)
            {
                adminMenuMasterModels.Add(mainModel);
            }
            List<AdminMenuMasterModel> lstSubList = lsdata.Where(x => x.ParentId == item.Id).OrderBy(x => x.MenuRank).ToList();
            if (lstSubList.Count() > 0)
            {
                foreach (var subList in lstSubList.ToList())
                {
                    adminMenuMasterModels.AddRange(GenerateList(subList, lsdata));
                }
            }
            return adminMenuMasterModels;
        }

        [HttpPost]
        [Route("/Admin/BindMenu")]
        public JsonResult BindMenu()
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select Menu --" });
                lsdata.AddRange(objMenuResourceMasterService.GetList().Where(x => x.IsActive == true).Select(x => new ListItem { Text = x.MenuName, Value = x.Id.ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        [HttpPost]
        [Route("/Admin/BindMenuType")]
        public JsonResult BindMenuType()
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select Project Type --" });
                lsdata.AddRange(Enum.GetValues(typeof(MenuType)).Cast<MenuType>().Select(d => new ListItem { Text = d.ToString(), Value = ((int)d).ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        [HttpPost]
        [Route("/Admin/BindParentMenu")]
        public JsonResult BindParentMenu(long? lgId)
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select Parent Menu --" });
                if (lgId.HasValue)
                {
                    if (lgId.Value > 0)
                    {
                        List<AdminMenuMasterModel> lstMainList = new List<AdminMenuMasterModel>();

                        lstMainList.AddRange(GetParentList(objAdminMenuMasterService.GetList(), lgId));

                        lsdata.AddRange(objAdminMenuMasterService.GetList().Where(x => x.Id != lgId && !lstMainList.Select(y=> y.Id).Contains(x.Id) ).Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
                    }
                    else
                    {
                        lsdata.AddRange(objAdminMenuMasterService.GetList().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
                    }
                }
                else
                {
                    lsdata.AddRange(objAdminMenuMasterService.GetList().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        private List<AdminMenuMasterModel> GetParentList(List<AdminMenuMasterModel> adminMenuMasterModels, long? lgId)
        {
            List<AdminMenuMasterModel> lstMainList = new List<AdminMenuMasterModel>();
            AdminMenuMasterModel model = adminMenuMasterModels.Where(x=> x.Id==lgId).FirstOrDefault();
            if(model!=null)
            {
                var lstSub= adminMenuMasterModels.Where((x)=>x.ParentId==model.Id).ToList();
                lstMainList.Add(model);
                if(lstSub.Count()>0)
                {
                    foreach(var item in lstSub)
                    {
                        lstMainList.AddRange(GetParentList(adminMenuMasterModels, item.Id));
                    }
                }
            }
            return lstMainList;
        }

        [Route("/Admin/GetAdminMenuDataDetails")]
        [HttpPost]
        public JsonResult GetAdminMenuDetails(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    objreturn.result = objAdminMenuMasterService.Get(lgid);
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

        [Route("/Admin/DeleteAdminMenuData")]
        [HttpPost]
        public JsonResult DeleteAdminMenuData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = objAdminMenuMasterService.Delete(lgid, UserModel.Username);
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


        [Route("/Admin/AdminMenuSwapDetails")]
        [HttpPost]
        public JsonResult AdminMenuSwapDetails(string rank, string dir, string type, string parentid)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                dir = Velzon.Common.Functions.FrontDecrypt(dir);
                type = Velzon.Common.Functions.FrontDecrypt(type);
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(rank), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(parentid), out long pid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = objAdminMenuMasterService.SwapSequance(lgid, dir, UserModel.Username, type, pid);
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
                    objreturn.strMessage = "Record not Swap, Try again";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not Swap, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        #endregion
    }
}
