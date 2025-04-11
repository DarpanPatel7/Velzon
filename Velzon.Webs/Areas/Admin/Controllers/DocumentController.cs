using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
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
    public class DocumentController : BaseController<DocumentController>
    {
        #region Controller Variable

        private IDocumentServices DocumentServices { get; set; }

        #endregion

        #region Controller Constructor

        public DocumentController(IDocumentServices _DocumentServices, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            DocumentServices = _DocumentServices;
        }

        #endregion

        #region Controller Method

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/DocumentMaster")]
        public IActionResult DocumentMaster()
        {
            try
            {
                try
                {
                    var sDataIssue = DataIssue;
                    if (sDataIssue != null)
                    {
                        Functions.MessagePopup(this, sDataIssue.strMessage, (sDataIssue.isError ? PopupMessageType.error : PopupMessageType.success));
                        DataIssue = null;
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

        [Route("/Admin/SaveDocumentMasterData")]

        [HttpPost]
        [DisableRequestSizeLimit]
        [RequestFormLimits(ValueLengthLimit = int.MaxValue, MultipartBodyLengthLimit = long.MaxValue)]
        public async Task<JsonResult> SaveDocumentMasterData(DocumentFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidDocumentData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        DocumentModel goiLogoModel = new DocumentModel();

                        if (objModel.CouchFile != null)
                        {
                            bool isSizeLarge = true;
                            //if(objModel.CouchFile.Length >= 100000000)
                            //{
                            //    isSizeLarge = false;
                            //}
                            var data = (await Functions.SaveFile(objModel.CouchFile, httpClientFactory, "Document", objModel.File_Name, FileType.AllType, isSizeLarge));

                            if (data != null)
                            {
                                if (!data.isError)
                                {
                                    goiLogoModel.Doc_Path = data.result.FilePath;
                                    goiLogoModel.File_Name = data.result.Filename;
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
                        goiLogoModel.LanguageId = objModel.LanguageId;
                        goiLogoModel.Doc_Id = objModel.Doc_Id;
                        goiLogoModel.Doc_Name = objModel.Doc_Name;
                        goiLogoModel.IsActive = objModel.IsActive;

                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objModel.Doc_Id == 0)
                        {
                            objreturn = DocumentServices.AddOrUpdate(goiLogoModel, UserModel.Username);
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objModel.Doc_Id != 0)
                        {
                            objreturn = DocumentServices.AddOrUpdate(goiLogoModel, UserModel.Username);
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

        public bool ValidDocumentData(DocumentFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {                
                if (!ValidControlValue(objModel.Doc_Name, ControlInputType.none))
                {
                    if (ValidLength(objModel.Doc_Name))
                    {
                        objreturn.strMessage = "Enter valid document name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter document name!";
                    }

                }
                else if (objModel.Doc_Id == 0 && objModel.CouchFile == null)
                {
                    objreturn.strMessage = "Please choose document!";

                }
                else if ((bool)VerifyExistingDocumentDetails(objModel.Doc_Name, objModel.Doc_Id).Value)
                {
                    objreturn.strMessage = "Document already exists!";
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
        public JsonResult VerifyExistingDocumentDetails(string Value, long Doc_Id)
        {
            bool isExist = false;
            try
            {
                DocumentModel objdata = new DocumentModel();
                if (!string.IsNullOrEmpty(Value))
                {
                    if (Doc_Id == 0)
                    {
                        objdata = DocumentServices.GetList().Where(x => x.Doc_Name.ToLower() == Value.ToLower()).FirstOrDefault();
                    }
                    else
                    {
                        objdata = DocumentServices.GetList().Where(x => x.Doc_Name.ToLower() == Value.ToLower() && x.Doc_Id != Doc_Id).FirstOrDefault();
                    }

                }
                isExist = objdata != null ? true : false;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(isExist);
        }

        #region Get Master Data
        [HttpPost]
        [Route("/Admin/GetDocumentMasterData")]
        public JsonResult GetDocumentMasterData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = DocumentServices.GetList();

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
        [Route("/Admin/GetDocumentDetails")]
        [HttpPost]
        public JsonResult GetDocumentDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = DocumentServices.Get(lgid, lgLangId);
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
        [Route("/Admin/DeleteDocumentMasterData")]
        [HttpPost]
        public JsonResult DeleteDocumentMasterData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = DocumentServices.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/UpdateDocumentMasterStatus")]
        [HttpPost]
        public JsonResult UpdateDocumentMasterStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = DocumentServices.UpdateStatus(lgid, UserModel.Username, isActive);
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

        public IActionResult Index()
        {
            return View();
        }

    }
}
