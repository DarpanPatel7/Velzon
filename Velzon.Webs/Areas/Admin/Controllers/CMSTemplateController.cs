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
    public class CMSTemplateController : BaseController<CMSTemplateController>
    {
        #region Controller Variable

        private ICMSTemplateMasterService CMSTemplateMasterService { get; set; }

        #endregion

        #region Controller Constructor

        public CMSTemplateController(ICMSTemplateMasterService _CMSTemplateMasterService)
        {
            this.CMSTemplateMasterService = _CMSTemplateMasterService;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/CMSTemplate")]
        public IActionResult CMSTemplate()
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

        [Route("/Admin/SaveCMSTemplateData")]
        [HttpPost]
        public JsonResult SaveCMSTemplateData(CMSTemplateModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidTemplateData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        var strPageDescription = objModel.Content;

                        objModel.Content = strPageDescription;
                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                        {
                            objreturn = CMSTemplateMasterService.AddOrUpdate(objModel, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                        {
                            objModel.Id = objModel.TemplateId.HasValue ? objModel.TemplateId.Value : 0;
                            objreturn = CMSTemplateMasterService.AddOrUpdate(objModel, UserModel.Username);
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

        public bool ValidTemplateData(CMSTemplateModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.TemplateName, ControlInputType.none))
                {
                    if (ValidLength(objModel.TemplateName))
                    {
                        objreturn.strMessage = "Enter valid template name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter template name!";
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
        [Route("/Admin/GetCMSTemplateData")]
        public JsonResult GetCMSTemplateData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = CMSTemplateMasterService.GetList();

                if (lsdata != null)
                {
                    lsdata.ForEach(x =>
                    {
                        var mainMenu = Enum.GetValues(typeof(CMSTemplateType)).Cast<CMSTemplateType>().Select(d => new ListItem { Text = d.ToString(), Value = ((int)d).ToString() }).Where(y => y.Value == x.TemplateType).FirstOrDefault();
                        x.TemplateType = mainMenu.Text;
                    });
                }
                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        [HttpPost]
        [Route("/Admin/BindCMSTemplateType")]
        public JsonResult BindCMSTemplateType()
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select CMS Template Type --" });
                lsdata.AddRange(Enum.GetValues(typeof(CMSTemplateType)).Cast<CMSTemplateType>().Select(d => new ListItem { Text = d.ToString(), Value = ((int)d).ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        //[HttpPost]
        //[Route("/Admin/BindParentMenu")]
        //public JsonResult BindParentMenu(long? lgId)
        //{

        //    List<ListItem> lsdata = new List<ListItem>();
        //    try
        //    {
        //        lsdata.Add(new ListItem { Text = "-- Select Parent Menu --" });
        //        if (lgId.HasValue)
        //        {
        //            if (lgId.Value > 0)
        //            {
        //                lsdata.AddRange(objCMSTemplateMasterService.GetList().Where(x => x.Id != lgId).Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
        //            }
        //            else
        //            {
        //                lsdata.AddRange(objCMSTemplateMasterService.GetList().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
        //            }
        //        }
        //        else
        //        {
        //            lsdata.AddRange(objCMSTemplateMasterService.GetList().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
        //    }

        //    return Json(lsdata);
        //}

        [Route("/Admin/GetCMSTemplateDataDetails")]
        [HttpPost]
        public JsonResult GetCMSTemplateDetails(string id,string langId)
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
                    objreturn.result = CMSTemplateMasterService.Get(lgid,lgLangId);
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

        [Route("/Admin/GetCMSTemplateDataDetailsByTempId")]
        [HttpPost]
        public JsonResult GetCMSTemplateDataDetailsByTempId(string id, string langId)
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
                    objreturn.result = CMSTemplateMasterService.Get(lgid, lgLangId);
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

        [Route("/Admin/DeleteCMSTemplateData")]
        [HttpPost]
        public JsonResult DeleteCMSTemplateData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = CMSTemplateMasterService.Delete(lgid, UserModel.Username);
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
    }
}
