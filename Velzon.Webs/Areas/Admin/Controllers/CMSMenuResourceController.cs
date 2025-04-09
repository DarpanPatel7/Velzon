using AngleSharp.Html.Forms.Submitters;
using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class CMSMenuResourceController : BaseController<CMSMenuResourceController>
    {
        #region Controller Variable

        private ICMSMenuResourceMasterService cMSMenuResourceMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public CMSMenuResourceController(ICMSMenuResourceMasterService _cMSMenuResourceMasterService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            this.cMSMenuResourceMasterService = _cMSMenuResourceMasterService;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/CMSMenuResource")]
        public IActionResult CMSMenuResource()
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

        [HttpPost]
        [Route("/Admin/BindParentCMSMenus")]
        public JsonResult BindParentCMSMenus(long? lgId)
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select Parent CMS Menu --" });
                if (lgId.HasValue)
                {
                    if (lgId.Value > 0)
                    {
                        List<CMSMenuResourceModel> lstMainList = new List<CMSMenuResourceModel>();

                        //lstMainList.AddRange(GetParentLists(cMSMenuResourceMasterService.GetParentList(lgId), lgId));

                        lsdata.AddRange(cMSMenuResourceMasterService.GetParentList().Select(x => new ListItem { Text = x.MenuName, Value = x.Id.ToString() }).ToList());
                        //lsdata.AddRange(cMSMenuResourceMasterService.GetParentList().Where(x => x.Id != lgId && !lstMainList.Select(y => y.Id).Contains(x.Id)).Select(x => new ListItem { Text = x.MenuName, Value = x.Id.ToString() }).ToList());
                    }
                    else
                    {
                        lsdata.AddRange(cMSMenuResourceMasterService.GetParentList().Select(x => new ListItem { Text = x.MenuName, Value = x.Id.ToString() }).ToList());
                    }
                }
                else
                {
                    lsdata.AddRange(cMSMenuResourceMasterService.GetParentList().Select(x => new ListItem { Text = x.MenuName, Value = x.Id.ToString() }).ToList());
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        private List<CMSMenuResourceModel> GetParentLists(List<CMSMenuResourceModel> adminMenuMasterModels, long? lgId)
        {
            List<CMSMenuResourceModel> lstMainList = new List<CMSMenuResourceModel>();
            CMSMenuResourceModel model = adminMenuMasterModels.Where(x => x.LanguageId == lgId).FirstOrDefault();
            if (model != null)
            {
                var lstSub = adminMenuMasterModels.Where((x) => x.Id == model.Id).ToList();
                lstMainList.Add(model);
                if (lstSub.Count() > 0)
                {
                    foreach (var item in lstSub)
                    {
                        lstMainList.AddRange(GetParentLists(adminMenuMasterModels, item.Id));
                    }
                }
            }
            return lstMainList;
        }

        [Route("/Admin/SaveCMSMenuResourceData")]
        [HttpPost]
        [DisableRequestSizeLimit]
        public async Task<JsonResult> SaveCMSMenuResourceData(CMSMenuResourceFrontModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidCmsMenuResource(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        CMSMenuResourceModel cmsMenuResource = new CMSMenuResourceModel();

                        if (objModel.BannerImage != null)
                        {
                            var data = (await Functions.SaveFile(objModel.BannerImage, httpClientFactory, "Banner", objModel.BannerImagePath, FileType.ImageType));

                            if (data != null)
                            {
                                if (!data.isError)
                                {
                                    cmsMenuResource.BannerImagePath = data.result.FilePath;
                                }
                                else
                                {
                                    return Json(data);
                                }
                            }
                            else
                            {
                                objreturn.strMessage = "File Save Error so Please try again.";
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                            }
                        }
                        else
                        {
                            cmsMenuResource.BannerImagePath = objModel.BannerImagePath;
                        }

                        if (objModel.IconImage != null)
                        {
                            var data = (await Functions.SaveFile(objModel.IconImage, httpClientFactory, "Icon", objModel.IconImagePath, FileType.ImageType));

                            if (data != null)
                            {
                                if (!data.isError)
                                {
                                    cmsMenuResource.IconImagePath = data.result.FilePath;
                                }
                                else
                                {
                                    return Json(data);
                                }
                            }
                            else
                            {
                                objreturn.strMessage = "File Save Error so Please try again.";
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                            }
                        }
                        else
                        {
                            cmsMenuResource.IconImagePath = objModel.IconImagePath;
                        }

                        cmsMenuResource.Id = objModel.Id;
                        cmsMenuResource.MenuName = objModel.MenuName;
                        cmsMenuResource.Tooltip = objModel.Tooltip;
                        cmsMenuResource.PageDescription = objModel.PageDescription;
                        cmsMenuResource.MenuURL = objModel.MenuURL;
                        cmsMenuResource.ResourceType = objModel.ResourceType;
                        cmsMenuResource.LanguageId = objModel.LanguageId;
                        cmsMenuResource.col_menu_type = objModel.col_menu_type;
                        cmsMenuResource.MetaDescription = objModel.MetaDescription;
                        cmsMenuResource.MetaTitle = objModel.MetaTitle;
                        if (objModel.col_parent_id != null)
                        {
                            cmsMenuResource.col_parent_id = (long)objModel.col_parent_id;
                        }
                        else
                        {
                            cmsMenuResource.col_parent_id = 0;
                        }
                        if (objModel.TemplateId != null && objModel.TemplateId != "0")
                        {
                            cmsMenuResource.TemplateId = objModel.TemplateId.TrimEnd(',');
                        }
                        else
                        {
                            cmsMenuResource.TemplateId = objModel.TemplateId;
                        }
                        cmsMenuResource.IsActive = objModel.IsActive;
                        cmsMenuResource.IsRedirect = objModel.IsRedirect;
                        cmsMenuResource.IsFullScreen = objModel.IsFullScreen;
                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            if (cMSMenuResourceMasterService.GetList().Count() == 0)
                            {
                                cmsMenuResource.MenuRank = 0;
                            }
                            else
                            {
                                cmsMenuResource.MenuRank = cMSMenuResourceMasterService.GetListMaster().Max(x => x.MenuRank) + 1;
                            }
                            objreturn = cMSMenuResourceMasterService.AddOrUpdate(cmsMenuResource, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {

                            cmsMenuResource.Id = objModel.CMSMenuResId.HasValue ? objModel.CMSMenuResId.Value : 0;
                            cmsMenuResource.MenuRank = cMSMenuResourceMasterService.Get(objModel.Id).MenuRank;
                            objreturn = cMSMenuResourceMasterService.AddOrUpdate(cmsMenuResource, UserModel.Username);
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

        public bool ValidCmsMenuResource(CMSMenuResourceFrontModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.MenuName, ControlInputType.none))
                {
                    if (ValidLength(objModel.MenuName))
                    {
                        objreturn.strMessage = "Enter valid menu name!";
                        objreturn.isError = true;
                        return false;
                    }
                    else
                    {
                        objreturn.strMessage = "Enter menu name!";
                        objreturn.isError = true;
                        return false;
                    }
                }
                if (!ValidControlValue(objModel.Tooltip, ControlInputType.none))
                {
                    if (ValidLength(objModel.Tooltip))
                    {
                        objreturn.strMessage = "Enter valid tooltip!";
                        objreturn.isError = true;

                        return false;
                    }
                    else
                    {
                        objreturn.strMessage = "Enter tooltip!";
                        objreturn.isError = true;
                        return false;

                    }
                }
                else if (!ValidControlValue(objModel.MenuURL, ControlInputType.none))
                {
                    if (ValidLength(objModel.MenuURL))
                    {
                        objreturn.strMessage = "Enter valid menu url!";
                        objreturn.isError = true;
                        return false;
                    }
                    else
                    {
                        objreturn.strMessage = "Enter menu url!";
                        objreturn.isError = true;
                        return false;
                    }
                }
                else if (!ValidControlValue(objModel.MetaTitle, ControlInputType.none))
                {
                    if (ValidLength(objModel.MetaTitle))
                    {
                        objreturn.strMessage = "Enter valid meta title!";
                        objreturn.isError = true;
                        return false;
                    }
                    else
                    {
                        objreturn.strMessage = "Enter meta title!";
                        objreturn.isError = true;
                        return false;
                    }
                }
                else if (!ValidControlValue(objModel.MetaDescription, ControlInputType.none))
                {
                    if (ValidLength(objModel.MetaDescription))
                    {
                        objreturn.strMessage = "Enter valid meta description!";
                        objreturn.isError = true;
                        return false;
                    }
                    else
                    {
                        objreturn.strMessage = "Enter meta description!";
                        objreturn.isError = true;
                        return false;
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

        [HttpPost]
        [Route("/Admin/GetCMSMenuResourceData")]
        public JsonResult GetCMSMenuResourceData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            List<CMSMenuResourceModel> adminMenuMasterModels = new List<CMSMenuResourceModel>();
            try

            {
                var lsdata = cMSMenuResourceMasterService.GetList().ToList();
                if (lsdata != null)
                {
                    lsdata.ForEach(x =>
                    {
                        var mainMenu = Enum.GetValues(typeof(CMSMenuType)).Cast<CMSMenuType>().Select(d => new ListItem { Text = d.ToString(), Value = ((int)d).ToString() }).Where(y => y.Value == x.col_menu_type).FirstOrDefault();
                        x.col_menu_type = mainMenu.Text;
                    });
                    var parentList = lsdata.Where(x => x.col_parent_id == 0).OrderBy(x => x.col_parent_id).ThenBy(n => n.MenuRank).OrderByDescending(x => x.col_menu_type).ToList();
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

        private IEnumerable<CMSMenuResourceModel> GenerateList(CMSMenuResourceModel item, List<CMSMenuResourceModel> lsdata)
        {
            List<CMSMenuResourceModel> adminMenuMasterModels = new List<CMSMenuResourceModel>();
            CMSMenuResourceModel mainModel = lsdata.Where(x => x.Id == item.Id).FirstOrDefault();
            if (mainModel != null)
            {
                adminMenuMasterModels.Add(mainModel);
            }
            List<CMSMenuResourceModel> lstSubList = lsdata.Where(x => x.col_parent_id == item.Id).OrderBy(x => x.MenuRank).ToList();
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
        [Route("/Admin/BindMenuResourceType")]
        public JsonResult BindMenuResourceType()
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select CMS Menu Resource Type --" });
                lsdata.AddRange(Enum.GetValues(typeof(CMSMenuResType)).Cast<CMSMenuResType>().Select(d => new ListItem { Text = d.ToString(), Value = ((int)d).ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        [Route("/Admin/GetCMSMenuResourceDataDetails")]
        [HttpPost]
        public JsonResult GetCMSMenuResourceDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                //id = HttpUtility.UrlDecode(id).Replace('+', '-');
                //langId = HttpUtility.UrlDecode(langId).Replace('+', '-');
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = cMSMenuResourceMasterService.Get(lgid, lgLangId);
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

        [Route("/Admin/GetCMSMenuResourceDataDetailsByResId")]
        [HttpPost]
        public JsonResult GetCMSMenuResourceDataDetailsByResId(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                //id = HttpUtility.UrlDecode(id).Replace('+', '-');
                //langId = HttpUtility.UrlDecode(langId).Replace('+', '-');
                if (long.TryParse((HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse((HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = cMSMenuResourceMasterService.GetMenuRes(lgid, lgLangId);
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

        [Route("/Admin/DeleteCMSMenuResourceData")]
        [HttpPost]
        public JsonResult DeleteCMSMenuResourceData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = cMSMenuResourceMasterService.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/CMSMenuResourceSwapDetails")]
        [HttpPost]
        public JsonResult CMSMenuResourceSwapDetails(string rank, string dir, string type, string parentid)
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
                        objreturn = cMSMenuResourceMasterService.SwapSequance(lgid, dir, UserModel.Username, type, pid);
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
                objreturn.strMessage = "Record not deleted, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        [Route("/Admin/UpdateCMSMenuResourceStatus")]
        [HttpPost]
        public JsonResult UpdateCMSMenuResourceStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = cMSMenuResourceMasterService.UpdateStatus(lgid, UserModel.Username, isActive);
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
    }
}
