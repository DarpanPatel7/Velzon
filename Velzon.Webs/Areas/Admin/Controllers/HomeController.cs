using Velzon.Common;
using Velzon.IService.Service;
using Velzon.IService.System;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Velzon.Webs.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Diagnostics;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using Velzon.Services.Service;
using Microsoft.AspNetCore.Mvc.Routing;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class HomeController : BaseController<HomeController>
    {
        #region Controller Variable

        private ISMTPMasterService sMTPMasterService { get; set; }
        private ICouchDBMasterService couchDBMasterService { get; set; }
        private IAccountService accountService { get; set; }
        private IUserMasterService userMasterService { get; set; }
        private IAdminMenuMasterService adminMenuMasterService { get; set; }

        private Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;

        #endregion

        #region Controller Constructor

        public HomeController(ILogger<HomeController> logger, IAccountService _accountService, IUserMasterService _userMasterService, ICouchDBMasterService _couchDBMasterService, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, ISMTPMasterService _sMTPMasterService , IHttpClientFactory _httpClientFactory, IAdminMenuMasterService _adminMenuMasterService) : base(_httpClientFactory)
        {
            this.accountService = _accountService;
            this.userMasterService = _userMasterService;
            this.sMTPMasterService = _sMTPMasterService;
            this.couchDBMasterService = _couchDBMasterService;

            _hostingEnvironment = hostingEnvironment;
            adminMenuMasterService = _adminMenuMasterService;
        }

        public SessionUserModel UserDetails
        {
            get { return SessionWrapper.Get<SessionUserModel>(this.HttpContext.Session, "UserDetails"); }
            set { SessionWrapper.Set<SessionUserModel>(this.HttpContext.Session, "UserDetails", value); }
        }

        #endregion

        #region Controller Methods

        [IgnoreAntiforgeryToken]
        [Route("/Admin/ViewFile")]
        public async Task<ActionResult> ViewFile(string fileName)
        {
            string strReturnPath = "";
            if (UserModel != null)
            {
                strReturnPath = "/Admin/Dashboard";
            }
            else
            {
                strReturnPath = Velzon.Webs.Common.Functions.GetHomePage(Url);
            }
            JsonResponseModel objreturn = new JsonResponseModel();
            fileName = HttpUtility.UrlDecode(fileName.ToString().Replace("?", "").Replace(");", "")).Replace("'", "").Trim();
            if (!string.IsNullOrWhiteSpace(fileName))
            {

                {
                    fileName = fileName.Replace("HASH_HASH", "+").Replace("HASH__HASH", "/");
                    fileName = Velzon.Common.Functions.FrontDecrypt(fileName).Replace("_", " ");
                    var docData = await Functions.DownloadFile(httpClientFactory, fileName);
                    if (docData != null)
                    {
                        if (docData.isError)
                        {
                            objreturn = docData;
                            DataIssue = objreturn;
                            return Redirect(Url.Content("~"+ strReturnPath));
                        }
                        else
                        {
                            objreturn.isError = false;
                            objreturn.strMessage = "";
                            string ContentType = "";
                            string extension = System.IO.Path.GetExtension(docData.result.Filename).Replace(".", "").ToUpper();

                            new FileExtensionContentTypeProvider().TryGetContentType(docData.result.Filename, out ContentType);

                            if (Functions.ValidateFileExtention(extension, FileType.ImageType) || Functions.ValidateFileExtention(extension, FileType.PDFType))
                            {
                                return new FileContentResult(docData.result.DataBytes, ContentType);
                            }

                            else
                            {
                                if (extension == ("apk").ToUpper())
                                {
                                    ContentType = "application/vnd.android.package-archive";
                                }
                                return File(docData.result.DataBytes, ContentType, docData.result.Filename);
                            }
                            //else
                            //{
                            //    objreturn.isError = true;
                            //    objreturn.strMessage = "This Type of File Don't able to View";
                            //    DataIssue = objreturn;
                            //    return Redirect(strReturnPath);
                            //}
                        }
                    }
                    else
                    {
                        objreturn.isError = true;
                        objreturn.strMessage = "File Don't able to View";
                        DataIssue = objreturn;
                        return Redirect(strReturnPath);
                    }
                }
            }
            else
            {
                objreturn.isError = true;
                objreturn.strMessage = "Please Enter File Path.";
                DataIssue = objreturn;
                return Redirect(strReturnPath);
            }
        }
        
        [IgnoreAntiforgeryToken]
        [Route("/Admin/DownloadFile")]
        public async Task<ActionResult> DownloadFile(string fileName)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            fileName = HttpUtility.UrlDecode(fileName.ToString().Replace("?", "").Replace(");", "")).Replace("'", "").Trim();
            if (!string.IsNullOrWhiteSpace(fileName))
            {
                if (Common.Functions.GetPageRightsCheck(HttpContext.Session).View)
                {
                    fileName = fileName.Replace("HASH_HASH", "+").Replace("HASH__HASH", "/");
                    fileName = Functions.FrontDecrypt(fileName).Replace("_", " ");
                    var docData = await Functions.DownloadFile(httpClientFactory, fileName);
                    if (docData != null)
                    {
                        if (docData.isError)
                        {
                            objreturn = docData;
                            ViewData.Add("DataIssue", objreturn);
                            return Redirect(Url.Content("~/Admin/Dashboard"));
                        }
                        else
                        {
                            objreturn.isError = false;
                            objreturn.strMessage = "";
                            string ContentType = "";
                            new FileExtensionContentTypeProvider().TryGetContentType(docData.result.Filename, out ContentType);

                            objreturn.result = new { dataBytes = docData.result.DataBytes, contentType = ContentType, fileName = docData.result.Filename };

                            return File(docData.result.DataBytes, ContentType, docData.result.Filename);
                        }
                    }
                    else
                    {
                        objreturn.isError = true;
                        objreturn.strMessage = "File Don't able to Download";
                        DataIssue = objreturn;
                        return Redirect(Url.Content("~/Admin/Dashboard"));
                    }
                }
                else
                {
                    objreturn.isError = true;
                    objreturn.strMessage = "You Don't have Rights perform this action.";
                    DataIssue = objreturn;
                    return Redirect(Url.Content("~/Admin/Dashboard"));
                }
            }
            else
            {
                objreturn.isError = true;
                objreturn.strMessage = "Please Enter File Path.";
                DataIssue = objreturn;
                return Redirect(Url.Content("~/Admin/Dashboard"));
            }
        }

        [Route("/Admin/Dashboard")]
        public IActionResult Dashboard()
        {
            try
            {
                if (UserModel == null)
                {
                    return RedirectToAction("Logout", "Account");
                }
                else if (UserModel.Id <= 0)
                {
                    return RedirectToAction("Logout", "Account");
                }

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

            }
            catch (Exception ex)
            {
                ErrorLogger.Error(" Controller Name => HomeController \n\r Action Name Index \n\r Method => GET ", ex.ToString());
                return RedirectToAction("Logout", "Account");
            }
            return View();
        }


        #region Change CouchDB

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/ChangeCouchDB")]
        public IActionResult ChangeCouchDB()
        {
            ChangeCouchDBModel changeMyProfileModel = new ChangeCouchDBModel();
            try
            {
                if (UserModel == null)
                {
                    return RedirectToAction("Logout", "Account");
                }
                else if (UserModel.Id <= 0)
                {
                    return RedirectToAction("Logout", "Account");
                }

                var smtpModel = couchDBMasterService.Get();
                if (smtpModel != null)
                {

                    changeMyProfileModel.CouchDBURL = smtpModel.CouchDBURL;
                    changeMyProfileModel.CouchDBUser = smtpModel.CouchDBUser;
                    changeMyProfileModel.CouchDBDbName = smtpModel.CouchDBDbName;
                    changeMyProfileModel.AllowCouchDBStore = (smtpModel.AllowCouchDBStore=="1"?true:false);

                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return RedirectToAction("Logout", "Account");
            }
            return View(changeMyProfileModel);
        }

        [HttpPost]
        [Route("/Admin/ChangeCouchDB")]
        public IActionResult ChangeCouchDB(ChangeCouchDBModel changeCouchDBModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string strError = "";
                    CouchDBModel userMasterModel = new CouchDBModel();
                    if (ValidateChangeCouchDB(changeCouchDBModel, out strError))
                    {
                        var mdl = new CouchDBModel();
                        mdl.AllowCouchDBStore = (changeCouchDBModel.AllowCouchDBStore?"1":"0");
                        mdl.CouchDBURL = changeCouchDBModel.CouchDBURL;
                        mdl.CouchDBUser = changeCouchDBModel.CouchDBUser;
                        mdl.CouchDBDbName = changeCouchDBModel.CouchDBDbName;

                        if (couchDBMasterService.InsertOrUpdate(mdl, out strError))
                        {

                            var smtpModel = couchDBMasterService.Get();
                            if (smtpModel != null)
                            {

                                changeCouchDBModel.AllowCouchDBStore = (smtpModel.AllowCouchDBStore == "1"?true : false);
                                changeCouchDBModel.CouchDBURL = smtpModel.CouchDBURL;
                                changeCouchDBModel.CouchDBUser = smtpModel.CouchDBUser;
                                changeCouchDBModel.CouchDBDbName = smtpModel.CouchDBDbName;

                            }

                            Functions.MessagePopup(this, "CouchDB Setting Updated Successfully..", PopupMessageType.success);
                            return View(changeCouchDBModel);
                        }
                        else
                        {
                            Functions.MessagePopup(this, strError, PopupMessageType.error);
                        }
                    }
                    else
                    {
                        Functions.MessagePopup(this, strError, PopupMessageType.error);
                        return View(changeCouchDBModel);
                    }
                }
                else
                {
                    Functions.MessagePopup(this, "Form Details Are Not Valid.", PopupMessageType.error);
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return RedirectToAction("Logout", "Account");
            }
            return RedirectToAction("ChangeCouchDB", "Home", new { area = "Admin" });
        }

        private bool ValidateChangeCouchDB(ChangeCouchDBModel changeMyProfileModel, out string strError)
        {
            bool isError = true;
            strError = "";

            if (string.IsNullOrWhiteSpace(changeMyProfileModel.CouchDBURL))
            {
                strError = "Please Enter CouchDB URL";
                return false;
            }
            else
            {
                if (!ValidControlValue(changeMyProfileModel.CouchDBURL, ControlInputType.none))
                {
                    strError = "Invalid CouchDB URL";
                    return false;
                }
            }

            if (string.IsNullOrWhiteSpace(changeMyProfileModel.CouchDBDbName))
            {
                strError = "Please Enter CouchDB Name";
                return false;
            }
            else
            {
                if (!ValidControlValue(changeMyProfileModel.CouchDBDbName, ControlInputType.text))
                {
                    strError = "Invalid CouchDB Name";
                    return false;
                }
            }

            if (string.IsNullOrWhiteSpace(changeMyProfileModel.CouchDBUser))
            {
                strError = "Please Enter CouchDB User";
                return false;
            }
            else
            {
                if (!ValidControlValue(changeMyProfileModel.CouchDBUser, ControlInputType.none))
                {
                    strError = "Invalid CouchDB User";
                    return false;
                }
            }

            return isError;
        }

        #endregion

        #region Change SMTP

        [Route("/Admin/ChangeSMTP")]
        public IActionResult ChangeSMTP()
        {
            ChangeSMTPModel changeMyProfileModel = new ChangeSMTPModel();
            try
            {
                if (UserModel == null)
                {
                    return Redirect(Url.Content("~/Account/Logout"));
                }
                else if (UserModel.Id <= 0)
                {
                    return Redirect(Url.Content("~/Account/Logout"));
                }
                changeMyProfileModel.SMTPIsTestNull = false;
                changeMyProfileModel.SMTPIsSecure = false;
                changeMyProfileModel.SMTPIsTest = false;
                changeMyProfileModel.TestSMTPIsSecure = false;
                changeMyProfileModel.TestSMTPIsTestNull = false;

                var smtpModel = sMTPMasterService.Get();
                if (smtpModel != null)
                {
                    changeMyProfileModel.SMTPIsTest = smtpModel.SMTPIsTest;
                    changeMyProfileModel.SMTPServer = smtpModel.SMTPServer;
                    changeMyProfileModel.SMTPAccount = smtpModel.SMTPAccount;
                    changeMyProfileModel.SMTPPassword = smtpModel.SMTPPassword;
                    changeMyProfileModel.SMTPFromEmail = smtpModel.SMTPFromEmail;
                    changeMyProfileModel.SMTPPort = smtpModel.SMTPPort == null ? "" : smtpModel.SMTPPort;
                    changeMyProfileModel.SMTPPortNull = smtpModel.SMTPPort == null ? true : false;
                    changeMyProfileModel.SMTPIsTestNull = smtpModel.SMTPIsSecure == null ? true : false;
                    changeMyProfileModel.SMTPIsSecure = smtpModel.SMTPIsSecureFlag == null ? false : smtpModel.SMTPIsSecureFlag.Value;

                    changeMyProfileModel.TestSMTPServer = smtpModel.TestSMTPServer;
                    changeMyProfileModel.TestSMTPAccount = smtpModel.TestSMTPAccount;
                    changeMyProfileModel.TestSMTPPassword = smtpModel.TestSMTPPassword;
                    changeMyProfileModel.TestSMTPPortNull = smtpModel.TestSMTPPort == null ? true : false;
                    changeMyProfileModel.TestSMTPIsTestNull = smtpModel.TestSMTPIsSecure == null ? true : false;
                    changeMyProfileModel.TestSMTPFromEmail = smtpModel.TestSMTPFromEmail;
                    changeMyProfileModel.TestSMTPPort = smtpModel.TestSMTPPort == null ? "" : smtpModel.TestSMTPPort;
                    changeMyProfileModel.TestSMTPIsSecure = smtpModel.TestSMTPIsSecureFlag == null ? false : smtpModel.TestSMTPIsSecureFlag.Value;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return Redirect(Url.Content("~/Account/Logout"));
            }
            return View(changeMyProfileModel);
        }

        [HttpPost]
        [Route("/Admin/ChangeSMTP")]
        public IActionResult ChangeSMTP(ChangeSMTPFormModel changeMyProfileModels)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string strError = "";
                    UserMasterModel userMasterModel = new UserMasterModel();
                    //if (ValidateChangeMyProfile(changeMyProfileModel, ref userMasterModel, out strError))
                    {
                        var mdl = new SMTPModel();
                        mdl.SMTPServer = changeMyProfileModels.SMTPServer;
                        mdl.SMTPAccount = changeMyProfileModels.SMTPAccount;
                        mdl.SMTPPassword = changeMyProfileModels.SMTPPassword;
                        mdl.SMTPFromEmail = changeMyProfileModels.SMTPFromEmail;
                        mdl.SMTPPort = changeMyProfileModels.SMTPPortNull ? null : changeMyProfileModels.SMTPPort;
                        mdl.SMTPIsSecure = changeMyProfileModels.SMTPIsTestNull ? null : (changeMyProfileModels.SMTPIsSecure.Value == true ? "1" : "0");

                        mdl.TestSMTPServer = changeMyProfileModels.TestSMTPServer;
                        mdl.TestSMTPAccount = changeMyProfileModels.TestSMTPAccount;
                        mdl.TestSMTPPassword = changeMyProfileModels.TestSMTPPassword;
                        mdl.TestSMTPFromEmail = changeMyProfileModels.TestSMTPFromEmail;
                        mdl.TestSMTPPort = changeMyProfileModels.TestSMTPPortNull ? null : changeMyProfileModels.TestSMTPPort;
                        mdl.TestSMTPIsSecure = changeMyProfileModels.TestSMTPIsTestNull ? null : (changeMyProfileModels.TestSMTPIsSecure.Value == true ? "1" : "0");

                        if (sMTPMasterService.InsertOrUpdate(mdl, out strError))
                        {
                            ChangeSMTPModel changeMyProfileModel = new ChangeSMTPModel();

                            ChangeSMTPModel objmodel = new ChangeSMTPModel();
                            objmodel.SMTPIsTestNull = false;
                            objmodel.SMTPIsSecure = false;
                            objmodel.SMTPIsTest = false;
                            objmodel.TestSMTPIsSecure = false;
                            objmodel.TestSMTPIsTestNull = false;

                            var smtpModel = sMTPMasterService.Get();
                            if (smtpModel != null)
                            {
                                objmodel.SMTPIsTest = smtpModel.SMTPIsTest;
                                objmodel.SMTPServer = smtpModel.SMTPServer;
                                objmodel.SMTPAccount = smtpModel.SMTPAccount;
                                objmodel.SMTPPassword = smtpModel.SMTPPassword;
                                objmodel.SMTPFromEmail = smtpModel.SMTPFromEmail;
                                objmodel.SMTPPort = smtpModel.SMTPPort == null ? "" : smtpModel.SMTPPort;
                                objmodel.SMTPPortNull = smtpModel.SMTPPort == null ? true : false;
                                objmodel.SMTPIsTestNull = smtpModel.SMTPIsSecure == null ? true : false;
                                objmodel.SMTPIsSecure = smtpModel.SMTPIsSecureFlag == null ? false : smtpModel.SMTPIsSecureFlag.Value;
                                
                                objmodel.TestSMTPServer = smtpModel.TestSMTPServer;
                                objmodel.TestSMTPAccount = smtpModel.TestSMTPAccount;
                                objmodel.TestSMTPPassword = smtpModel.TestSMTPPassword;
                                objmodel.TestSMTPPortNull = smtpModel.TestSMTPPort == null ? true : false;
                                objmodel.TestSMTPIsTestNull = smtpModel.TestSMTPIsSecure == null ? true : false;
                                objmodel.TestSMTPFromEmail = smtpModel.TestSMTPFromEmail;
                                objmodel.TestSMTPPort = smtpModel.TestSMTPPort == null ? "" : smtpModel.TestSMTPPort;
                                objmodel.TestSMTPIsSecure = smtpModel.TestSMTPIsSecureFlag == null ? false : smtpModel.TestSMTPIsSecureFlag.Value;

                            }

                            Functions.MessagePopup(this, "SMTP Setting Updated Successfully..", PopupMessageType.success);
                            return View(objmodel);
                        }
                        else
                        {
                            Functions.MessagePopup(this, strError, PopupMessageType.error);
                        }
                    }
                    //else
                    {
                        Functions.MessagePopup(this, strError, PopupMessageType.error);
                    }
                }
                else
                {
                    Functions.MessagePopup(this, "Form Details Are Not Valid.", PopupMessageType.error);
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return Redirect(Url.Content("~/Account/Logout"));
            }
            return Redirect(Url.Content("/Admin/ChangeSMTP"));
        }

        [HttpPost]
        [Route("/Admin/UpdateSMTPEnvironment")]
        public JsonResult UpdateSMTPEnvironment(SMTPEmailEnvoiromentModel changeMyProfileModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                string strError;
                if (ModelState.IsValid)
                {
                    if (!sMTPMasterService.UpdateSMTPEnvironment((changeMyProfileModel.SMTPIsTest ? "1" : "0"), out strError))
                    {
                        objreturn.strMessage = strError;
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.success.ToString();
                    }
                    else
                    {
                        objreturn.strMessage = strError;
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                    }
                }
                else
                {
                    objreturn.strMessage = "Form Details Are Not Valid.";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);

                objreturn.strMessage = ex.Message;
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        [HttpPost]
        [Route("/Admin/SendTestEmail")]
        public JsonResult SendTestEmail(SMTPEmailModel changeMyProfileModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                string strError;
                if (ModelState.IsValid)
                {
                    if (!Functions.ValidateEmailId(changeMyProfileModel.TestSentEmail))
                    {
                        objreturn.strMessage = "Please Enter Valid Email Id";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.success.ToString();
                    }
                    string strSubject = "This is Test Email";
                    string strBody = "";

                    string contentRootPath = _hostingEnvironment.ContentRootPath;

                    string content = System.IO.File.ReadAllText(contentRootPath + "/EmailTemplate/TestEmail.html");

                    StringBuilder stringBuilder = new StringBuilder(content);

                    content = stringBuilder.ToString();

                    if (Functions.SendEmail(changeMyProfileModel.TestSentEmail, strSubject, content, out strError, true,null, changeMyProfileModel.IsTest))
                    {
                        objreturn.strMessage = "Send Email From SMTP " + (ConfigDetailsValue.SMTPIsTest == "1" ? "Test" : "Live") + " Credential Successfully.";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.success.ToString();
                    }
                    else
                    {
                        objreturn.strMessage = "Send Email From SMTP " + (ConfigDetailsValue.SMTPIsTest == "1" ? "Test" : "Live") + " Credential Successfully. " + strError;
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                    }
                }
                else
                {
                    objreturn.strMessage = "Form Details Are Not Valid.";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);

                objreturn.strMessage = ex.Message;
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        #endregion

        #region Change Profile

        [Route("/Admin/ChangeMyProfile")]
        public IActionResult ChangeMyProfile()
        {
            ChangeMyProfileModel changeMyProfileModel = new ChangeMyProfileModel();
            try
            {
                if (UserModel == null)
                {
                    return RedirectToAction("Logout", "Account");
                }
                else if (UserModel.Id <= 0)
                {
                    return RedirectToAction("Logout", "Account");
                }
                changeMyProfileModel.FirstName = UserModel.FirstName;
                changeMyProfileModel.LastName = UserModel.LastName;
                changeMyProfileModel.Email = UserModel.Email;
                changeMyProfileModel.PhoneNo = UserModel.PhoneNo;
                changeMyProfileModel.UserName = UserModel.Username;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return RedirectToAction("Logout", "Account");
            }
            return View(changeMyProfileModel);
        }

        [HttpPost]
        [Route("/Admin/ChangeMyProfile")]
        public IActionResult ChangeMyProfile(ChangeMyProfileModel changeMyProfileModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string strError = "";
                    UserMasterModel userMasterModel = new UserMasterModel();
                    if (ValidateChangeMyProfile(changeMyProfileModel, ref userMasterModel, out strError))
                    {
                        var mdl = userMasterService.AddOrUpdate(userMasterModel);
                        if (!mdl.isError)
                        {
                            SessionUserModel objUserModel = new SessionUserModel();
                            accountService.LogInValidation(userMasterModel.Username, userMasterModel.UserPassword, "", out objUserModel, out strError, 1);
                            UserModel = objUserModel;
                            Functions.MessagePopup(this, "Profile updated successfully", PopupMessageType.success);
                            return View();
                        }
                        else
                        {
                            Functions.MessagePopup(this, mdl.strMessage, PopupMessageType.error);
                        }
                    }
                    else
                    {
                        Functions.MessagePopup(this, strError, PopupMessageType.error);
                    }
                }
                else
                {
                    Functions.MessagePopup(this, "Form Details Are Not Valid.", PopupMessageType.error);
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return RedirectToAction("Logout", "Account");
            }
            return View();
        }

        private bool ValidateChangeMyProfile(ChangeMyProfileModel changeMyProfileModel, ref UserMasterModel userMasterModel, out string strError)
        {
            bool isError = true;
            strError = "";
            userMasterModel.Id = UserModel.Id;
            userMasterModel.Username = UserModel.Username;
            userMasterModel.UserPassword = UserModel.UserPassword;
            userMasterModel.RoleId = UserModel.RoleId;
            userMasterModel.CreatedBy = userMasterModel.Username;
            userMasterModel.IsActive = UserModel.IsActive;

            if (string.IsNullOrWhiteSpace(changeMyProfileModel.FirstName))
            {
                strError = "Please Enter First Name";
                return false;
            }
            else
            {
                if (!ValidControlValue(changeMyProfileModel.FirstName, ControlInputType.text))
                {
                    strError = "Invalid First Name";
                    return false;
                }
                else
                {
                    userMasterModel.FirstName = changeMyProfileModel.FirstName;
                }
            }

            if (string.IsNullOrWhiteSpace(changeMyProfileModel.LastName))
            {
                strError = "Please Enter Last name";
                return false;
            }
            else
            {
                if (!ValidControlValue(changeMyProfileModel.LastName, ControlInputType.text))
                {
                    strError = "Invalid Last Name";
                    return false;
                }
                else
                {
                    userMasterModel.LastName = changeMyProfileModel.LastName;
                }
            }

            if (string.IsNullOrWhiteSpace(changeMyProfileModel.PhoneNo))
            {
                strError = "Please Enter Mobile No";
                return false;
            }
            else
            {
                if (!ValidControlValue(changeMyProfileModel.PhoneNo, ControlInputType.mobileno))
                {
                    strError = "Invalid Mobile No";
                    return false;
                }
                else
                {
                    userMasterModel.PhoneNo = changeMyProfileModel.PhoneNo;
                }
                
            }

            if (string.IsNullOrWhiteSpace(changeMyProfileModel.Email))
            {
                strError = "Please Enter Email";
                return false;
            }
            else
            {
                if (!ValidControlValue(changeMyProfileModel.Email, ControlInputType.email))
                {
                    strError = "Invalid Email Id";
                    return false;
                }
                else
                {
                    userMasterModel.Email = changeMyProfileModel.Email;
                }
                
            }

            return isError;
        }

        [HttpPost]
        [Route("/Admin/UpdateProfilePic")]
        public IActionResult UpdateProfilePic(string strData)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (strData != null)
                {
                    objreturn = userMasterService.UpdateProfilePic(UserModel.Id, strData, UserModel.Username);
                    var userDetails = this.UserDetails;
                    if (userDetails != null)
                    {
                        userDetails.ProfilePic = strData; // Modify any property
                        this.UserDetails = userDetails; // Set it back to update session
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
                objreturn.strMessage = "Profile picture not updated, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        #endregion

        #region Change Password

        [Route("/Admin/ChangePassword")]
        public IActionResult ChangePassword()
        {
            ChangePasswordFormModel changePasswordModel = new ChangePasswordFormModel();
            try
            {
                if (UserModel == null)
                {
                    return RedirectToAction("Logout", "Account");
                }
                else if (UserModel.Id <= 0)
                {
                    return RedirectToAction("Logout", "Account");
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error(" Controller Name => HomeController \n\r Action Name ChangePassword \n\r Method => GET ", ex.ToString());
                DapperConnection.ErrorLogEntry(ex.ToString(), "HomeController", "ChangePassword", "Web", "");
                return RedirectToAction("Logout", "Account");
            }
            return View(changePasswordModel);
        }

        [HttpPost]
        [Route("/Admin/ChangePassword")]
        public IActionResult ChangePassword(ChangePasswordFormModel ChangePasswordFormModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {

                ChangePasswordFormModel.OldPassword = Functions.FrontDecrypt(ChangePasswordFormModel.OldPassword);
                ChangePasswordFormModel.NewPassword = Functions.FrontDecrypt(ChangePasswordFormModel.NewPassword);
                ChangePasswordFormModel.ConfirmPassword = Functions.FrontDecrypt(ChangePasswordFormModel.ConfirmPassword);
                if (ValidateChangePassword(ChangePasswordFormModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        ChangePasswordModel ChangePasswordModel = new ChangePasswordModel();
                        ChangePasswordModel.Id = (int)UserModel.Id;
                        ChangePasswordModel.CreateBy = UserModel.Id.ToString();
                        // ChangePasswordModel.UserPassword = Functions.Encrypt(ChangePasswordFormModel.NewPassword);
                        ChangePasswordModel.OldPassword = ChangePasswordFormModel.OldPassword;
                        ChangePasswordModel.NewPassword = Functions.Encrypt(ChangePasswordFormModel.NewPassword);
                        ChangePasswordModel.ConfirmPassword = ChangePasswordFormModel.ConfirmPassword;
                        if (!userMasterService.ChangePassword(ChangePasswordModel).isError)
                        {
                            Functions.MessagePopup(this, "Password Updated Successfully!", PopupMessageType.success);
                            return Redirect(Url.Content("~/Account/Logout"));
                        }
                        else
                        {
                            Functions.MessagePopup(this, "Record not saved, Try again!", PopupMessageType.error);
                            return View();
                        }
                    }
                    else
                    {
                        Functions.MessagePopup(this, "Form details are not valid.", PopupMessageType.error);
                        return View();
                    }
                }
                else
                {
                    Functions.MessagePopup(this, objreturn.strMessage, PopupMessageType.warning);
                    return View();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return RedirectToAction("ChangePassword");
            }
        }

        private bool ValidateChangePassword(ChangePasswordFormModel ChangePasswordFormModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (ChangePasswordFormModel.OldPassword != Functions.Decrypt(UserModel.UserPassword))
                {
                    objreturn.strMessage = " Old password is wrong.";
                }
                //if (!ValidControlValue(ChangePasswordFormModel.OldPassword, ControlInputType.password))
                //{
                //    if (ValidLength(ChangePasswordFormModel.OldPassword))
                //    {
                //        objreturn.strMessage = "Enter valid old password!";
                //    }
                //    else
                //    {
                //        objreturn.strMessage = "Enter old password!";
                //    }
                //}
                
                else if (!ValidControlValue(ChangePasswordFormModel.NewPassword, ControlInputType.password))
                {
                    if (ValidLength(ChangePasswordFormModel.NewPassword))
                    {
                        objreturn.strMessage = "Enter valid new password!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter new password!";
                    }
                }
                else if (!ValidControlValue(ChangePasswordFormModel.ConfirmPassword, ControlInputType.password))
                {
                    if (ValidLength(ChangePasswordFormModel.ConfirmPassword))
                    {
                        objreturn.strMessage = "Enter valid confirm password!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter confirm password!";
                    }
                }
                else if (ChangePasswordFormModel.NewPassword == Functions.Decrypt(UserModel.UserPassword))
                {
                    objreturn.strMessage = "New password is same as old password.";
                }
                else if (ChangePasswordFormModel.NewPassword != ChangePasswordFormModel.ConfirmPassword)
                {
                    objreturn.strMessage = "Confirm password not match with new password!";
                }
                else
                {
                    allow = true;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }

            return allow;
        }

        #endregion

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/SqlExecute")]
        public IActionResult SqlExecute()
        {
            return View();
        }
        
        [Route("/Admin/GETMYSQLResult")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult GETMYSQLResult(SqlExecuteModel objModel)
        {
            var response = new JsonResponseModel();
            try
            {
                if (string.IsNullOrWhiteSpace(objModel.SqlQuery))
                {
                    response.strMessage = "Query is empty.";
                    response.isError = true;
                    response.type = PopupMessageType.error.ToString();
                    return Json(response);
                }

                var query = objModel.SqlQuery.Trim();

                // Allow only SELECT queries, disallow DROP/DELETE/UPDATE/INSERT
                if (!query.StartsWith("SELECT", StringComparison.OrdinalIgnoreCase))
                {
                    response.strMessage = "Only SELECT queries are allowed.";
                    response.isError = true;
                    response.type = PopupMessageType.error.ToString();
                    return Json(response);
                }

                // Optional: further sanitize input
                string disallowed = "UPDATE|DELETE|INSERT|DROP|ALTER|TRUNCATE";
                if (Regex.IsMatch(query, $@"\b({disallowed})\b", RegexOptions.IgnoreCase))
                {
                    response.strMessage = "Only SELECT queries are permitted. Query contains invalid keywords.";
                    response.isError = true;
                    response.type = PopupMessageType.error.ToString();
                    return Json(response);
                }

                response = accountService.ExecuteQueryData(query);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                response.strMessage = "An error occurred while executing the query.";
                response.isError = true;
                response.type = PopupMessageType.error.ToString();
            }

            return Json(response);
        }

        #region Search

        [HttpPost]
        [Route("/Admin/GetSearchData")]
        public JsonResult GetSearchData(string search)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                SearchMenuModel menuItem = adminMenuMasterService.GetSearch(UserModel.RoleId, search);

                if (menuItem.Search != null)
                {
                    objreturn.result = menuItem.Search;
                    objreturn.isError = false;
                }
                else
                {
                    objreturn.result = null;
                    objreturn.isError = false;
                }

                return Json(objreturn);
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                return Json("");
            }
        }

        #endregion

        #endregion
    }
}
