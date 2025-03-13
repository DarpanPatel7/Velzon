using Velzon.Common;
using Velzon.Model.Service;
using Velzon.Model.System;
using Microsoft.AspNetCore.Mvc;
using Velzon.IService.Service;
using System.Transactions;

using System.Text;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Services.Service;

namespace Velzon.Webs.Controllers
{
    [AutoValidateAntiforgeryToken]

    public class FeedBackController : Controller // BaseController<FeeddbackMaster>
    {
        [Route("/FeedBack")]
        public IActionResult FeedBack()
        {
            return View();
        }

        #region Controller Variable

        private IFeedbackServices objFeedbackService { get; set; }
        protected readonly IHttpClientFactory objHttpClientFactory;
        protected readonly ICMSTemplateMasterService objCMSTemplateMasterService;
        private static HashSet<string> UsedCaptchaCodes = new();
        #endregion

        #region Controller Constructor

        public FeedBackController(ICMSTemplateMasterService _objCMSTemplateMasterService, IFeedbackServices _objFeedbackService, IHttpClientFactory _httpClientFactory)
        {
            objCMSTemplateMasterService = _objCMSTemplateMasterService;
            objFeedbackService = _objFeedbackService;
            objHttpClientFactory = _httpClientFactory;
        }

        #endregion


        #region Save Method

        [Route("/Admin/AddFeedback")]
        [HttpPost]
        public JsonResult AddFeedback(Feedback objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            using (var transactionScope = new TransactionScope())
            {
                try
                {
                    if (ValidDocumentData(objModel, ref objreturn))
                    {
                        if (ModelState.IsValid)
                        {
                            //objModel.Captcha = Functions.FrontDecrypt(objModel.Captcha);
                            string[] srtEmail = Functions.FrontDecrypt(objModel.hfEmail).Split("--exegil--");
                            objModel.Email = srtEmail[0];
                            objModel.Captcha = srtEmail[1];

                            lock (UsedCaptchaCodes) // Ensure thread safety
                            {
                                if(string.IsNullOrEmpty(objModel.Captcha))
                                {
                                    objreturn.strMessage = "Enter the captcha";
                                    objreturn.isError = true;
                                    objreturn.type = PopupMessageType.error.ToString();
                                }
                                else if (UsedCaptchaCodes.Contains(objModel.Captcha))
                                {
                                    objreturn.strMessage = "Captcha is not Match";
                                    objreturn.isError = true;
                                    objreturn.type = PopupMessageType.error.ToString();
                                }
                                else if (objModel.Captcha == Functions.FromHexString(objModel.hfCaptcha) && Captcha.ValidateFeedbackCaptchaCode(objModel.Captcha, "CaptchaCode", HttpContext))
                                {
                                    objreturn = objFeedbackService.AddFeedback(objModel);

                                    if (!objreturn.isError)
                                    {
                                        // Mark CAPTCHA as used
                                        UsedCaptchaCodes.Add(objModel.Captcha);
                                        transactionScope.Complete();
                                    }
                                }
                                else
                                {
                                    objreturn.strMessage = "Captcha is not Match";
                                    objreturn.isError = true;
                                    objreturn.type = PopupMessageType.error.ToString();
                                }
                            }

                            //if (objModel.Captcha == Functions.FromHexString(objModel.hfCaptcha) && Captcha.ValidateFeedbackCaptchaCode(objModel.Captcha, "CaptchaCode", HttpContext))
                            //{
                            //    // Feedback FeedbackModel = new Feedback();

                            //    objreturn = objFeedbackService.AddFeedback(objModel);
                            //}
                            //else
                            //{
                            //    objreturn.strMessage = "Captcha Is not Match";
                            //    objreturn.isError = true;
                            //    objreturn.type = PopupMessageType.error.ToString();
                            //    //Functions.MessagePopup(this, "Captcha Is not Match", PopupMessageType.error);
                            //    //ModelState.Clear();
                            //}
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
            }
               
            return Json(objreturn);
        }

        #endregion

        public bool ValidControlValue(dynamic controlValue, ControlInputType type = ControlInputType.none)
        {
            return Common.Functions.ValidControlValue(controlValue, type);
        }
        public bool ValidLength(dynamic controlValue)
        {
            return Common.Functions.ValidLength(controlValue);
        }
        public bool ValidDocumentData(Feedback objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.FName, ControlInputType.text))
                {
                    if (ValidLength(objModel.FName))
                    {
                        objreturn.strMessage = "Enter valid name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter name!";
                    }

                }
                else if (!ValidControlValue(objModel.LName, ControlInputType.text))
                {
                    if (ValidLength(objModel.LName))
                    {
                        objreturn.strMessage = "Enter valid last name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter last name!";
                    }

                }
                else if (!ValidControlValue(objModel.Email, ControlInputType.email))
                {
                    if (ValidLength(objModel.Email))
                    {
                        objreturn.strMessage = "Enter valid email!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter email!";
                    }

                }
                else if (!ValidControlValue(objModel.MobileNo, ControlInputType.mobileno))
                {
                    if (ValidLength(objModel.MobileNo))
                    {
                        objreturn.strMessage = "Enter valid Mobile Number!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Mobile Number!";
                    }

                }

                else if (!ValidControlValue(objModel.Subject, ControlInputType.text))
                {
                    if (ValidLength(objModel.Subject))
                    {
                        objreturn.strMessage = "Enter valid Subject!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Subject!";
                    }

                }
                else if (!ValidControlValue(objModel.City, ControlInputType.text))
                {
                    if (ValidLength(objModel.City))
                    {
                        objreturn.strMessage = "Enter valid city!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter city!";
                    }

                }
                else if (!string.IsNullOrEmpty(objModel.Address) && !ValidControlValue(objModel.Address, ControlInputType.text))
                {
                    objreturn.strMessage = ValidLength(objModel.Address) ? "Enter valid Address!" : "Enter Address!";
                }

                else if (!ValidControlValue(objModel.FeedbackDetails, ControlInputType.none))
                {
                    if (ValidLength(objModel.FeedbackDetails))
                    {
                        objreturn.strMessage = "Enter valid Message Details!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Message Details!";
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
    }
}
