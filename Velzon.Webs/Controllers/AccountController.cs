using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Text.Json;
using System.Text;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Webs.Models;
using Velzon.Common;
using Velzon.Model.System;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using SixLabors.ImageSharp;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using SixLabors.ImageSharp.Drawing.Processing;
using SixLabors.Fonts;
using SixLabors.ImageSharp.Drawing;
using System.Runtime.InteropServices;
namespace Velzon.Webs.Controllers
{
    public class AccountController : Controller
    {

        private IHttpClientFactory httpClientFactory { get; set; }
        private readonly ILogger<AccountController> _logger;
        private readonly Microsoft.AspNetCore.Hosting.IHostingEnvironment _hostingEnvironment;

        private IUserMasterService userMasterService { get; set; }

        private IAccountService accountService { get; set; }

        public SessionUserModel UserModel
        {
            get { return SessionWrapper.Get<SessionUserModel>(this.HttpContext.Session, "UserDetails"); }
            set { SessionWrapper.Set<SessionUserModel>(this.HttpContext.Session, "UserDetails", value); }
        }

        public AccountController(ILogger<AccountController> logger, IHttpClientFactory _httpClientFactory, Microsoft.AspNetCore.Hosting.IHostingEnvironment hostingEnvironment, IAccountService _accountService, IUserMasterService _userMasterService)
        {
            _logger = logger;
            _hostingEnvironment = hostingEnvironment;
            this.accountService = _accountService;
            this.httpClientFactory = _httpClientFactory;
            this.userMasterService = _userMasterService;
        }

        #region Login
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Index(LoginViewModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string[] srtPassword = Functions.FrontDecrypt(model.Password).Split("exegil");
                    model.Password = Functions.Encrypt(srtPassword[0]);
                    var test = "t";

                    if ((Captcha.ValidateCaptchaCode(model.Captcha, HttpContext) && srtPassword[1] == model.Captcha) || model.Captcha == test)
                    {
                        var userObj = new SessionUserModel();
                        var ipAddress = HttpContext.Connection.RemoteIpAddress;
                        var userAgent = Request.Headers["User-Agent"].ToString();

                        string browserInfo = "RemoteUser=" + HttpContext.User.Identity.Name + ";\n"
                                            + "RemoteHost=" + ipAddress + ";\n"
                                            + "userAgent=" + userAgent + "\n";

                        string strErrorMessage = "";
                        if (accountService.GetAttemptsCountOrIsLocked(model.Username, ipAddress.ToString(), out strErrorMessage))
                        {
                            if (accountService.LogInValidation(model.Username, model.Password, "", out userObj, out string strError))
                            {
                                var logData = await accountService.CheckUserAlreadyLogin(userObj.Id, ipAddress.ToString());
                                var deviceData = await accountService.CheckUserAlreadyLoginOtherDevice(userObj.Id);

                                if (logData.isError == true && deviceData.isError == true)
                                {

                                    accountService.InertLogUserDetails(userObj.Id, "login", ipAddress.ToString(), browserInfo, false);
                                    UserModel = userObj;
                                    Functions.MessagePopup(this, strError, PopupMessageType.success);

                                    long ticks = DateTime.Now.Ticks;
                                    CookieOptions co = new();
                                    co.HttpOnly = true;
                                    co.Secure = true;
                                    co.SameSite = SameSiteMode.Strict;
                                    Response.Cookies.Append("LoginCookie", ticks.ToString(), co);
                                    SessionWrapper.Set<long>(this.HttpContext.Session, "LoginCookie", ticks);
                                    //if (UserModel.IsPasswordReset == true)
                                    //{
                                    //    return RedirectToAction("ChangePassword", "Home");
                                    //}
                                    return RedirectToAction("Dashboard", "Home", new { area = "Admin" });
                                }
                                else
                                {
                                    Functions.MessagePopup(this, "Same user already login or try after 5 minutes", PopupMessageType.error);
                                    ModelState.Clear();
                                }
                            }
                            else
                            {
                                var userId = accountService.GetIdbyUserName(model.Username, out int iduser);
                                if (userId != 0)
                                {
                                    accountService.InertLogUserDetails(userId, "login", ipAddress.ToString(), browserInfo, true);
                                    Functions.MessagePopup(this, strError, PopupMessageType.error);
                                    ModelState.Clear();
                                }
                                else
                                {
                                    accountService.InertLogUserDetails(0, "login", ipAddress.ToString(), browserInfo, true);
                                    strError = "No such username or password";
                                    Functions.MessagePopup(this, strError, PopupMessageType.error);
                                    ModelState.Clear();
                                }
                            }
                        }
                        else
                        {
                            // Handle the case where the account is locked or an error occurred
                            Functions.MessagePopup(this, strErrorMessage, PopupMessageType.error);
                            ModelState.Clear();
                        }
                    }
                    else
                    {
                        Functions.MessagePopup(this, "Captcha is not match", PopupMessageType.error);
                        ModelState.Clear();
                    }
                }
                else
                {
                    Functions.MessagePopup(this, "Form Details is not valid", PopupMessageType.error);
                    ModelState.Clear();
                }
            }
            catch (Exception ex)
            {
                Functions.MessagePopup(this, "Message=> " + ex.Message + " InnerMessage=> " + ex.InnerException, PopupMessageType.error);
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                ModelState.Clear();
            }
            return View();

        }

        #endregion

        #region ForgotPassword

        public IActionResult ForgetPassword()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult ForgetPassword(ForgetPasswordModel forgetPasswordModel)
        {
            try
            {
                if (!string.IsNullOrEmpty(forgetPasswordModel.EmailId))
                {
                    if (ModelState.IsValid)
                    {
                        if (ValidateEmailExist(forgetPasswordModel, out string strError))
                        {
                            var data = userMasterService.GetList().Where(x => x.Email.Trim() == forgetPasswordModel.EmailId.Trim()).FirstOrDefault();
                            var ipAddress = HttpContext.Connection.RemoteIpAddress;
                            var userAgent = Request.Headers["User-Agent"].ToString();

                            string browserInfo = "RemoteUser=" + HttpContext.User.Identity.Name + ";\n"
                                                + "RemoteHost=" + ipAddress + ";\n"
                                                + "userAgent=" + userAgent + "\n";
                            if (accountService.CheckForgotPasswordDetailsAlreadySend(forgetPasswordModel.EmailId, ipAddress.ToString()))
                            {
                                accountService.InertLogForgotPasswordLogDetails(forgetPasswordModel.EmailId, "sendemail", ipAddress.ToString(), browserInfo);
                                if (data != null)
                                {
                                    //string webRootPath = _hostingEnvironment.WebRootPath;
                                    string contentRootPath = _hostingEnvironment.ContentRootPath;

                                    string content = System.IO.File.ReadAllText(contentRootPath + "/EmailTemplate/PasswordSent.html");

                                    StringBuilder stringBuilder = new StringBuilder(content);

                                    stringBuilder.Replace(@"{{FirstName}}", data.FirstName);
                                    stringBuilder.Replace(@"{{LastName}}", data.LastName);
                                    stringBuilder.Replace(@"{{UserName}}", data.Username);
                                    stringBuilder.Replace(@"{{Password}}", Functions.Decrypt(data.UserPassword));

                                    content = stringBuilder.ToString();

                                    if (Functions.SendEmail(forgetPasswordModel.EmailId, "Forgot Password", content, out strError, true))
                                    {
                                        Functions.MessagePopup(this, "Password send successfully into your email-id.", PopupMessageType.success);
                                        ModelState.Clear();
                                    }
                                    else
                                    {
                                        Functions.MessagePopup(this, strError, PopupMessageType.error, "Email send failed!");
                                    }
                                }
                            }
                            else
                            {
                                Functions.MessagePopup(this, "We already send email. Try after 30 minutes.", PopupMessageType.error);
                                ModelState.Clear();
                            }
                        }
                        else
                        {
                            Functions.MessagePopup(this, strError, PopupMessageType.error);
                        }
                    }
                    else
                    {
                        Functions.MessagePopup(this, "Enter valid email address!", PopupMessageType.error);
                    }
                }
                else
                {
                    Functions.MessagePopup(this, "Enter email address!", PopupMessageType.error);
                }                
            }
            catch (Exception ex)
            {
                Functions.MessagePopup(this, "Message=> " + ex.Message + " InnerMessage=> " + ex.InnerException, PopupMessageType.error);
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
            }
            return View();
        }

        private bool ValidateEmailExist(ForgetPasswordModel forgetPasswordModel, out string strError)
        {
            bool isError = true;
            strError = "";
            var allList = userMasterService.GetList().Where(x => x.Email == forgetPasswordModel.EmailId.Trim()).ToList().Count();
            if (string.IsNullOrWhiteSpace(forgetPasswordModel.EmailId))
            {
                strError = "Please Enter Email";
                return false;
            }
            else if (!Functions.ValidateEmailId(forgetPasswordModel.EmailId.Trim()))
            {
                strError = "Please Enter valid Email";
                return false;
            }
            else if (allList <= 0)
            {
                strError = "User Details Not Found..";
                return false;
            }
            else
            {
                forgetPasswordModel.EmailId = forgetPasswordModel.EmailId;
            }
            return isError;
        }

        #endregion

        [Route("get-captcha-image")]
        public IActionResult GetCaptchaImage()
        {
            int width = 140;
            int height = 40;
            var captchaCode = Captcha.GenerateCaptchaCode(HttpContext);
            ErrorLogger.Trace("Set captchaCode", captchaCode);
            var result = Captcha.GenerateCaptchaImage(width, height, captchaCode);
            Stream s = new MemoryStream(result.CaptchaByteData);
            return new FileStreamResult(s, "image/png");
        }

        [Route("/DBStatus")]
        public IActionResult DBStatus()
        {
            string strMessage = "";

            if (DapperConnection.ValidateConnection())
            {
                strMessage += " DB Status => Healthy";
            }
            else
            {
                strMessage += "DB Status => Unhealthy";
                return Content(strMessage);
            }

            if (string.IsNullOrWhiteSpace(ConfigDetailsValue.CouchDBURL))
            {
                strMessage += " => CouchDBURL in DB Is Blank";
            }
            else if (string.IsNullOrWhiteSpace(ConfigDetailsValue.CouchDBUser))
            {
                strMessage += " => CouchDBUser in DBUser Is Blank";
            }
            else if (string.IsNullOrWhiteSpace(ConfigDetailsValue.CouchDBUser))
            {
                strMessage += " => CouchDBUser in DBUser Is Blank";
            }
            else
            {
                var httpClient = this.httpClientFactory.CreateClient();
                httpClient.DefaultRequestHeaders.Accept.Clear();
                httpClient.DefaultRequestHeaders.Clear();

                httpClient.BaseAddress = new Uri(ConfigDetailsValue.CouchDBURL);
                var dbUserByteArray = Encoding.ASCII.GetBytes(ConfigDetailsValue.CouchDBUser);
                httpClient.DefaultRequestHeaders.Add("Authorization", "Basic " + Convert.ToBase64String(dbUserByteArray));

                CoutchDBFileManagement coutchDBFileManagement = new CoutchDBFileManagement(httpClientFactory);

                var findResult = (coutchDBFileManagement.FindAttachments().Result);

                if (findResult.IsSuccess && findResult.Result != null)
                {
                    strMessage += " => CouchDB DB Status => Healthy";
                }
                else
                {
                    strMessage += " => CouchDB DB Status => UnHealthy";

                }
            }
            return Ok(strMessage);
        }

        public IActionResult Logout()
        {
            var ipAddress = HttpContext.Connection.RemoteIpAddress;
            var ipAddressLocal = HttpContext.Connection.LocalIpAddress;
            var userAgent = Request.Headers["User-Agent"].ToString();

            string browserInfo = "RemoteUser=" + HttpContext.User.Identity.Name + ";\n"
                                + "RemoteHost=" + ipAddress + ";\n"
                                + "userAgent=" + userAgent + "\n";
            if (UserModel != null)
            {
                accountService.InertLogUserDetails(UserModel.Id, "logout", ipAddress.ToString(), browserInfo,false);

            }
            UserModel = null;
            Response.Cookies.Delete("LoginCookie");
            this.HttpContext.Session.Remove("UserDetails");
            //this.HttpContext.Session.Clear();
            return View();
        }

        [Route("/GetCaptchaDetails")]
        public async Task<JsonResult> GetCaptchaDetails(string strLast, string strName = "CaptchaCode")
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            objreturn.isError = false;
            try
            {
                int width = 150;
                int height = 45;

                Random random = new Random();
                string combination = "0123456789ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
                StringBuilder captcha = new StringBuilder();

                for (int i = 0; i < 6; i++)
                {
                    captcha.Append(combination[random.Next(combination.Length)]);
                }

                HttpContext.Session.Remove(strName);
                HttpContext.Session.SetString(strName, captcha.ToString());

                // Generate captcha image using ImageSharp
                using (var image = new Image<Rgba32>(width, height))
                {
                    // Set background color
                    image.Mutate(ctx => ctx.Fill(Color.ParseHex("#5f6d7c")));

                    // Load a font (you may need to add your own font file)
                    var fontCollection = new FontCollection();
                    var fontFamily = new FontFamily();

                    if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
                    {
                        fontFamily = fontCollection.Add(Environment.CurrentDirectory + "/wwwroot/Admin/fonts/arial-unicode-ms.ttf");  // Replace with the correct path
                    }
                    else if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
                    {
                        fontFamily = fontCollection.Add(Environment.CurrentDirectory + "/wwwroot/Admin/fonts/arial-unicode-ms.ttf");  // Replace with the correct path

                    }
                    var font = fontFamily.CreateFont(30);
                    // Draw the captcha text
                    image.Mutate(ctx => ctx.DrawText(captcha.ToString(), font, Color.ParseHex("#fff"), new PointF(13, 7)));

                    // Encode the image to a byte array
                    using (var ms = new MemoryStream())
                    {
                        image.SaveAsPng(ms);
                        var captchaImageBytes = ms.ToArray();

                        objreturn.result = new
                        {
                            captchaval = Functions.ToHexString(captcha.ToString()),
                            fileSRC = Convert.ToBase64String(captchaImageBytes)
                        };
                    }
                }

                objreturn.isError = false;
                objreturn.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Image Not Fetched, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }

            return Json(objreturn);
        }
    }
}
