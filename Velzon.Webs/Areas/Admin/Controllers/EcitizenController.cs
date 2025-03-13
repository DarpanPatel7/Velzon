using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Globalization;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class EcitizenController : BaseController<EcitizenController>
    {
        #region Controller Variable

        private IEcitizenService objEcitizenService { get; set; }
        private IBranchService objBranchService { get; set; }

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

        public EcitizenController(IEcitizenService _objEcitizenService, IBranchService _objBranchService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            objEcitizenService = _objEcitizenService;
            objBranchService = _objBranchService;
        }

        #endregion

        #region Controller Method
        
        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/EcitizenMaster")]
        public IActionResult EcitizenMaster()
        {
            try
            {
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
        }

        [Route("/Admin/SaveEcitizenData")]
        [HttpPost]
        [DisableRequestSizeLimit]
        public async Task<JsonResult> SaveEcitizenData([FromForm] EcitizenFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                objreturn = (ValidateForm(objModel));
                if (!objreturn.isError)
                {
                    if (ValidEcitizenData(objModel, ref objreturn))
                    {
                        if (ModelState.IsValid)
                        {
                            EcitizenModel ecitizenModel = new EcitizenModel();

                            if (objModel.ImageName != null)
                            {
                                var data = (await Functions.SaveFile(objModel.ImageName, httpClientFactory, "EcitizenDocument", objModel.ImagePath, FileType.PDFType));

                                if (data != null)
                                {
                                    if (!data.isError)
                                    {
                                        ecitizenModel.ImageName = data.result.Filename;
                                        ecitizenModel.ImagePath = data.result.FilePath;
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
                                ecitizenModel.ImagePath = objModel.ImagePath;

                            }

                            ecitizenModel.Id = objModel.Id;
                            ecitizenModel.LanguageId = objModel.LanguageId;
                            ecitizenModel.EcitizenTypeId = objModel.EcitizenTypeId;
                            ecitizenModel.BranchId = objModel.BranchId;
                            ecitizenModel.Date = string.IsNullOrWhiteSpace(objModel.Date) ? (DateTime?)null : DateTime.ParseExact(objModel.Date, "dd/MM/yyyy", null);
                            ecitizenModel.Number = objModel.Number;
                            ecitizenModel.Subject = objModel.Subject;
                            ecitizenModel.IsActive = objModel.IsActive;
                            if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                            {
                                objreturn = objEcitizenService.AddOrUpdate(ecitizenModel, UserModel.Username);
                            }
                            else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                            {
                                objreturn = objEcitizenService.AddOrUpdate(ecitizenModel, UserModel.Username);
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
                else
                {
                    return Json(objreturn);
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

        public bool ValidEcitizenData(EcitizenFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.EcitizenTypeId, ControlInputType.none))
                {
                    if (ValidLength(objModel.EcitizenTypeId))
                    {
                        objreturn.strMessage = "Select Valid Ecitizen Type!";
                        return allow;
                    }
                    else
                    {
                        objreturn.strMessage = "Select Ecitizen Type!";
                        return allow;
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
        [Route("/Admin/GetEcitizenData")]
        public JsonResult GetEcitizenData(CMSEcitizenGridModel model)
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            try
            {
                var lsdata = objEcitizenService.GetList().Where(x => model.EcitizenTypeId == null || x.EcitizenTypeId == model.EcitizenTypeId);
                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        [Route("/Admin/GetEcitizenDataDetails")]
        [HttpPost]
        public JsonResult GetEcitizenDataDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = objEcitizenService.Get(lgid, lgLangId);
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

        [Route("/Admin/DeleteEcitizenData")]
        [HttpPost]
        public JsonResult DeleteEcitizenData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = objEcitizenService.Delete(lgid, UserModel.Username);
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

        [HttpPost]
        [Route("/Admin/BindBranch")]
        public JsonResult BindBranch(long LGId = 0)
        {
            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                if (LanguageId == 2)
                {
                    lsdata.Add(new ListItem { Text = "-- શાખા પસંદ કરો --", Value = "" });
                }
                else
                {
                    lsdata.Add(new ListItem { Text = "-- Select Branch --", Value = "" });
                }
                if (LGId != 0)
                {
                    lsdata.AddRange(objBranchService.GetListFront(LGId).Select(x => new ListItem { Text = x.BranchName, Value = x.BranchId.ToString() }).ToList());
                }
                else
                {
                    lsdata.AddRange(objBranchService.GetListFront(LanguageId).Select(x => new ListItem { Text = x.BranchName, Value = x.BranchId.ToString() }).ToList());
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(lsdata);
        }

        [HttpPost]
        [Route("/Admin/BindEcitizenType")]
        public JsonResult BindEcitizenType()
        {
            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select Ecitizen Type --", Value = "" });
                lsdata.AddRange(objEcitizenService.GetEcitizenType().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }

        #endregion

        #region Validation 
        private JsonResponseModel ValidateForm(EcitizenFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            objreturn.isError = false;

            var lstFieldList = objModel.validationMainForm.Where(x => !x.IsFormClickTab).ToList();

            var dataDictionaryList = Functions.ObjectToDictionary(objModel);

            var model = Functions.ValidateForm(dataDictionaryList, lstFieldList);
            objreturn = model;
            return objreturn;
        }
        #endregion
    }
}