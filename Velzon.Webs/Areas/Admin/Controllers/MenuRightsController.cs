using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using System.Linq;
using System.Text;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class MenuRightsController : BaseController<RoleMasterController>
    {
        #region Controller Variable

        private IRoleMasterService roleMasterService { get; set; }

        private IMenuRightsMasterService menuRightsMasterService { get; set; }

        private IAdminMenuMasterService adminMenuMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public MenuRightsController(IRoleMasterService _roleMasterService, IMenuRightsMasterService _menuRightsMasterService, IAdminMenuMasterService _adminMenuMasterService)
        {
            this.roleMasterService = _roleMasterService;
            this.menuRightsMasterService = _menuRightsMasterService;
            this.adminMenuMasterService = _adminMenuMasterService;
        }

        #endregion


        #region Controller Private Functions

        private IEnumerable<AdminMenuMasterModel> GetParentChild(AdminMenuMasterModel adminMenuMasterModels, List<AdminMenuMasterModel> menuList)
        {
            List<AdminMenuMasterModel> parentChild = new List<AdminMenuMasterModel>();
            var SubList = menuList.Where(x => x.ParentId == adminMenuMasterModels.Id).OrderBy(x => x.MenuRank).ToList();
            if (SubList.Count() > 0)
            {
                parentChild.Add(adminMenuMasterModels);
                foreach (var sub in SubList)
                {
                    parentChild.AddRange(GetParentChild(sub, menuList));
                }
            }
            else
            {
                parentChild.Add(adminMenuMasterModels);
            }
            return parentChild;
        }

        private string GenerateMenu(List<AdminMenuMasterModel> menuList, List<MenuRightsMasterModel> roleWiseList)
        {

            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.Append("<table class=\"table display nowrap table-striped table-bordered scroll-horizontal text-center nowrap\" id=\"tblRoleRightdata\">");
            stringBuilder.Append("    <thead>");
            stringBuilder.Append("        <tr>");
            stringBuilder.Append("            <th>Page Name</th>");
            stringBuilder.Append("            <th>Page URL</th>");
            stringBuilder.Append("            <th> <input id=\"chkAllInsert\" type=\"checkbox\" onclick=\"return SelectAllCheckBox('Insert');\"/> Insert</th>");
            stringBuilder.Append("            <th> <input id=\"chkAllUpdate\" type=\"checkbox\" onclick=\"return SelectAllCheckBox('Update');\"/> Update</th>");
            stringBuilder.Append("            <th> <input id=\"chkAllDelete\" type=\"checkbox\" onclick=\"return SelectAllCheckBox('Delete');\"/> Delete</th>");
            stringBuilder.Append("            <th> <input id=\"chkAllView\"   type=\"checkbox\" onclick=\"return SelectAllCheckBox('View');\"  /> View  </th>");
            stringBuilder.Append("        </tr>");
            stringBuilder.Append("    </thead>");
            stringBuilder.Append("    <tbody>");

            var parentList = menuList.Where(x => x.ParentId == 0).OrderBy(x => x.ParentId).ThenBy(n => n.MenuRank).ToList();
            long parentLevel = 0;
            foreach (var item in parentList)
            {
                parentLevel = 0;
                stringBuilder.Append(GenerateSubList(item, menuList, roleWiseList, ref parentLevel));
            }

            stringBuilder.Append("    </tbody>");
            stringBuilder.Append("</table>");

            return stringBuilder.ToString();
        }

        private string GenerateSubList(AdminMenuMasterModel item, List<AdminMenuMasterModel> menuList, List<MenuRightsMasterModel> roleWiseList, ref long parentLevel)
        {
            StringBuilder stringBuilder = new StringBuilder();

            var lstSubList = menuList.Where(x => x.ParentId == item.Id).OrderBy(x => x.MenuRank).ToList();
            if (lstSubList.Count() > 0)
            {
                if (lstSubList.Count(x => x.MenuType != ((int)MenuType.InternalLinks).ToString()) > 0)
                {
                    parentLevel++;
                }
                var roleModel = roleWiseList.Where(x => x.Id == item.Id).FirstOrDefault();
                string menuName = "";
                for (long i = parentLevel; i < 0; i--)
                {
                    menuName += "==> ";
                }

                item.Name = menuName + item.Name;
                stringBuilder.Append(GenerateRow(item, roleModel));


                foreach (var subItem in lstSubList)
                {
                    stringBuilder.Append(GenerateSubList(subItem, menuList, roleWiseList, ref parentLevel));
                }
            }
            else
            {
                var roleModel = roleWiseList.Where(x => x.Id == item.Id).FirstOrDefault();
                string menuName = "";
                for (long i = parentLevel; i > 0; i--)
                {
                    menuName += "==> ";
                }

                item.Name = menuName + item.Name;
                stringBuilder.Append(GenerateRow(item, roleModel));

            }
            return stringBuilder.ToString();
        }

        private string GenerateRow(AdminMenuMasterModel item, MenuRightsMasterModel? roleModel)
        {
            StringBuilder stringBuilder = new StringBuilder();

            stringBuilder.Append("        <tr>");
            stringBuilder.Append("            <td>" + item.Name + "</td>");
            stringBuilder.Append("            <td>" + item.MenuURL + "</td>");

            if (roleModel != null)
            {
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "Insert\" class=\" Insert\" " + (roleModel.Insert ? "checked=\"checked\"" : "") + " type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','Insert');\" /> </td>");
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "Update\" class=\" Update\" " + (roleModel.Update ? "checked=\"checked\"" : "") + " type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','Update');\" /> </td>");
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "Delete\" class=\" Delete\" " + (roleModel.Delete ? "checked=\"checked\"" : "") + " type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','Delete');\" /> </td>");
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "View\"   class=\" View\"   " + (roleModel.View ? "checked=\"checked\"" : "") + " type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','View');\" /> </td>");
            }
            else
            {
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "Insert\" class=\" Insert\" type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','Insert');\" /> </td>");
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "Update\" class=\" Update\" type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','Update');\" /> </td>");
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "Delete\" class=\" Delete\" type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','Delete');\" /> </td>");
                stringBuilder.Append("            <td> <input id=\"chk" + item.Id + "View\"   class=\" View\"   type=\"checkbox\" onclick=\"return SetCheckBoxCheck(\'" + item.Id + "\','View'  );\" /> </td>");
            }
            stringBuilder.Append("        </tr>");

            return stringBuilder.ToString();
        }

        #endregion

        #region Controller Methods

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/MenuRights")]
        public IActionResult MenuRights()
        {
            try
            {
                MenuRightsFilterModel menuRightsFilterModel = new MenuRightsFilterModel();
                menuRightsFilterModel.StrTable = "";
                menuRightsFilterModel.SubmitDisable = "none";
                int SuperAdminRoleId = int.TryParse(ConfigDetailsValue.SuperAdminRoleId, out var result) ? result : 1;
                if (UserModel.RoleId != SuperAdminRoleId)
                {
                    menuRightsFilterModel.RoleList = roleMasterService.GetList().Where(x => x.IsActive && x.Id != SuperAdminRoleId).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                }
                else
                {
                    menuRightsFilterModel.RoleList = roleMasterService.GetList().Where(x => x.IsActive).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                }
                menuRightsFilterModel.ParentMenuList = adminMenuMasterService.GetList().Where(x => x.ParentId == 0).Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList();
                return View(menuRightsFilterModel);
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "Account");
            }
        }

        [HttpPost]
        [Route("/Admin/MenuRights")]
        public IActionResult MenuRights(MenuRightsFilterMainModel menuRightsFilterModel)
        {
            MenuRightsFilterModel modelReturn = new MenuRightsFilterModel();
            try
            {
                if (ModelState.IsValid)
                {
                    List<AdminMenuMasterModel> lstMain = new List<AdminMenuMasterModel>();
                    var menuList = adminMenuMasterService.GetList();
                    if (menuRightsFilterModel.SelectedMenuId != null)
                    {
                        menuList = adminMenuMasterService.GetList().Where(x => x.Id == menuRightsFilterModel.SelectedMenuId || x.ParentId == menuRightsFilterModel.SelectedMenuId).ToList();
                    }
                    if (menuRightsFilterModel.SelectedMenuId > 0)
                    {
                        foreach (var menu in menuList.Where(x => x.ParentId == menuRightsFilterModel.SelectedMenuId).OrderBy(x => x.ParentId).ThenBy(n => n.MenuRank).ToList())
                        {
                            lstMain.AddRange(GetParentChild(menu, menuList));
                        }
                    }
                    else
                    {
                        lstMain.AddRange(menuList);
                    }
                    var roleWiseList = menuRightsMasterService.GetListByRoleId(menuRightsFilterModel.SelectedRoleId);
                    int SuperAdminRoleId = int.TryParse(ConfigDetailsValue.SuperAdminRoleId, out var result) ? result : 1;
                    if (menuList.Count() > 0)
                    {
                        if (menuRightsFilterModel.SelectedRoleId != SuperAdminRoleId)
                        {
                            menuList.Remove(menuList.FirstOrDefault(x => x.MenuURL == "/Admin/UtilityMaster"));
                            menuList.Remove(menuList.FirstOrDefault(x => x.MenuURL == "/Admin/ChangeCouchDB"));
                            menuList.Remove(menuList.FirstOrDefault(x => x.MenuURL == "/Admin/SqlExecute"));
                        }
                        string strtable = GenerateMenu(menuList, roleWiseList);
                        modelReturn.StrTable = strtable;
                        modelReturn.SubmitDisable = "block";
                    }
                    if (UserModel.RoleId != SuperAdminRoleId)
                    {
                        modelReturn.RoleList = roleMasterService.GetList().Where(x => x.IsActive && x.Id != SuperAdminRoleId).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                    }
                    else
                    {
                        modelReturn.RoleList = roleMasterService.GetList().Where(x => x.IsActive).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                    }
                    modelReturn.ParentMenuList = adminMenuMasterService.GetList().Where(x => x.ParentId == 0).Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList();
                    return View(modelReturn);
                }
                else
                {
                    Functions.MessagePopup(this, "Please select role", PopupMessageType.error);
                    ModelState.Clear();
                    modelReturn.SubmitDisable = "none";
                    int SuperAdminRoleId = int.TryParse(ConfigDetailsValue.SuperAdminRoleId, out var result) ? result : 1;
                    if (UserModel.RoleId != SuperAdminRoleId)
                    {
                        modelReturn.RoleList = roleMasterService.GetList().Where(x => x.IsActive && x.Id != SuperAdminRoleId).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                    }
                    else
                    {
                        modelReturn.RoleList = roleMasterService.GetList().Where(x => x.IsActive).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                    }
                    modelReturn.ParentMenuList = adminMenuMasterService.GetList().Where(x => x.ParentId == 0).Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList();
                    return View(modelReturn);
                }
            }
            catch (Exception ex)
            {
                Functions.MessagePopup(this, "Message=> " + ex.Message + " InnerMessage=> " + ex.InnerException, PopupMessageType.error);
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                ModelState.Clear();
                modelReturn.SubmitDisable = "none";
                int SuperAdminRoleId = int.TryParse(ConfigDetailsValue.SuperAdminRoleId, out var result) ? result : 1;
                if (UserModel.RoleId != SuperAdminRoleId)
                {
                    modelReturn.RoleList = roleMasterService.GetList().Where(x => x.IsActive && x.Id != SuperAdminRoleId).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                }
                else
                {
                    modelReturn.RoleList = roleMasterService.GetList().Where(x => x.IsActive).Select(x => new ListItem { Text = x.RoleName, Value = x.Id.ToString() }).ToList();
                }
                modelReturn.ParentMenuList = adminMenuMasterService.GetList().Where(x => x.ParentId == 0).Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList();
                return View(modelReturn);
            }
        }

        [HttpPost]
        [Route("/Admin/UpdatePageRights")]
        public JsonResult UpdatePageRights(string strData, long lgRoleId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (!string.IsNullOrWhiteSpace(strData))
                {
                    strData = (strData);

                    List<string> list = strData.Split('|').Where(x => !string.IsNullOrWhiteSpace(x)).ToList();
                    List<MenuRightsMasterModel> lstMenuRightsList = new List<MenuRightsMasterModel>();
                    list.ForEach(x =>
                    {
                        List<string> listSub = x.Split(',').ToList();
                        if (listSub != null)
                        {
                            if (listSub.Count() == 5 && (Convert.ToBoolean(listSub[1]) || Convert.ToBoolean(listSub[2]) || Convert.ToBoolean(listSub[3]) || Convert.ToBoolean(listSub[4])))
                            {
                                MenuRightsMasterModel adminMenuMasterModel = new MenuRightsMasterModel();
                                adminMenuMasterModel.MenuResourceId = Convert.ToInt32(listSub[0]);
                                adminMenuMasterModel.Insert = Convert.ToBoolean(listSub[1]);
                                adminMenuMasterModel.Update = Convert.ToBoolean(listSub[2]);
                                adminMenuMasterModel.Delete = Convert.ToBoolean(listSub[3]);
                                adminMenuMasterModel.View = Convert.ToBoolean(listSub[4]);
                                adminMenuMasterModel.LastUpdateBy = UserModel.Username;
                                lstMenuRightsList.Add(adminMenuMasterModel);
                            }
                        }

                    });

                    if (!menuRightsMasterService.Insert(lstMenuRightsList.Where(x => !(x.Insert == false && x.Update == false && x.Delete == false && x.View == false)).ToList(), lgRoleId, UserModel.Username, out string strError))
                    {
                        objreturn.strMessage = strError;
                        objreturn.isError = false;
                        objreturn.type = PopupMessageType.success.ToString();
                    }
                    else
                    {
                        objreturn.strMessage = "Entry not Proper";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                    }
                }
                else
                {
                    objreturn.strMessage = "Entry not Proper";
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

        #endregion
    }
}
