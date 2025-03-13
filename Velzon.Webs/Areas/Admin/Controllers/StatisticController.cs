using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class StatisticController : BaseController<StatisticController>
    {
        #region Controller Variable

        private IStatisticServices StatisticServices { get; set; }

        #endregion

        #region Controller Constructor

        public StatisticController(IStatisticServices _StatisticServices, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            StatisticServices = _StatisticServices;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/StatisticMaster")]
        [HttpGet]
        public IActionResult StatisticMaster()
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
        #endregion

        #region Save Method
        [Route("/Admin/SaveStatisticData")]
        [HttpPost]
        [DisableRequestSizeLimit]
        public async Task<JsonResult> SaveStatisticData(StatisticFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                objreturn = (ValidateForm(objModel));
                if (!objreturn.isError)
                {
                    if (ValidStatisticData(objModel, ref objreturn))
                    {
                        if (ModelState.IsValid)
                        {
                            StatisticModel StatisticModel = new StatisticModel();
                            if (objModel.LogoImage != null)
                            {
                                var data = (await Functions.SaveFile(objModel.LogoImage, httpClientFactory, "Statistic", objModel.ImagePath, FileType.ImageType));
                                if (data != null)
                                {
                                    if (!data.isError)
                                    {
                                        StatisticModel.ImageName = data.result.Filename;
                                        StatisticModel.ImagePath = data.result.FilePath;
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
                                if (objModel.Id != 0 && objModel.ImagePath != null)
                                {
                                    StatisticModel.ImagePath = objModel.ImagePath;
                                }
                            }
                            StatisticModel.LanguageId = objModel.LanguageId;
                            StatisticModel.Id = objModel.Id;
                            StatisticModel.StatisticTypeId = objModel.StatisticTypeId;
                            StatisticModel.Title = objModel.Title;
                            StatisticModel.Count = objModel.Count;
                            StatisticModel.Url = objModel.Url;
                            StatisticModel.IsActive = objModel.IsActive;
                            if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Id == 0)
                            {
                                objreturn = StatisticServices.AddOrUpdate(StatisticModel, UserModel.Username);
                            }
                            else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Id != 0)
                            {
                                objreturn = StatisticServices.AddOrUpdate(StatisticModel, UserModel.Username);
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

        public bool ValidStatisticData(StatisticFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.Title, ControlInputType.none))
                {
                    if (ValidLength(objModel.Title))
                    {
                        objreturn.strMessage = "Enter valid Title!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Title!";
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

        #endregion

        #region Get Master Data
        [HttpPost]
        [Route("/Admin/GetStatisticData")]
        public JsonResult GetStatisticData(CMSStatisticGridModel model)
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            try
            {
                var lsdata = StatisticServices.GetList().Where(x => model.StatisticTypeId == null || x.StatisticTypeId == model.StatisticTypeId);
                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }
        #endregion

        #region Get Master Details Data
        [Route("/Admin/GetStatisticDetails")]
        [HttpPost]
        public JsonResult GetStatisticDetails(string id, string langId)
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
                    objreturn.result = StatisticServices.Get(lgid, lgLangId);
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
        #endregion

        #region Delete Data
        [Route("/Admin/DeleteStatisticData")]
        [HttpPost]
        public JsonResult DeleteStatisticData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = StatisticServices.Delete(lgid, UserModel.Username);
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
        [Route("/Admin/BindStatisticType")]
        public JsonResult BindStatisticType()
        {

            List<ListItem> lsdata = new List<ListItem>();
            try
            {
                lsdata.Add(new ListItem { Text = "-- Select Statistic Type --", Value = "" });
                lsdata.AddRange(StatisticServices.GetStatisticType().Select(x => new ListItem { Text = x.Name, Value = x.Id.ToString() }).ToList());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return Json(lsdata);
        }
        #endregion

        #region Validation 
        private JsonResponseModel ValidateForm(StatisticFormModel objModel)
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