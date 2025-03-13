﻿
using Velzon.IService.Service;
using Velzon.Model.CouchDB;
using Velzon.Model.System;
using Velzon.Security;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Net.Mail;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;


namespace Velzon.Common
{
    public static class MyServer
    {
        public static string MapPath(string path)
        {
            return Path.Combine(
                (string)AppDomain.CurrentDomain.GetData("ContentRootPath"),
                path);
        }
    }

    public static class Functions
    {
        private static List<string> FindHrefs(string input)
        {
            List<string> strList = new List<string>();
            Regex regex = new Regex("href\\s*=\\s*(?:\"(?<1>[^\"]*)\"|(?<1>\\S+))", RegexOptions.IgnoreCase);
            Match match;
            for (match = regex.Match(input); match.Success; match = match.NextMatch())
            {
                Console.WriteLine("Found a href. Groups: ");
                foreach (Group group in match.Groups)
                {
                    Console.WriteLine("Group value: {0}", group);
                    strList.Add(group.Value);
                }
            }
            return strList;

        }
        private static List<string> FindSRCs(string input)
        {
            List<string> strList = new List<string>();
            Regex regex = new Regex("src\\s*=\\s*(?:\"(?<1>[^\"]*)\"|(?<1>\\S+))", RegexOptions.IgnoreCase);
            Match match;
            for (match = regex.Match(input); match.Success; match = match.NextMatch())
            {
                Console.WriteLine("Found a src. Groups: ");
                foreach (Group group in match.Groups)
                {
                    strList.Add(group.Value);
                }
            }
            return strList;
        }

        public static string ResolveURLHTML(IUrlHelper url,string html)
        {
            string updateUrl = string.Empty;

            List<string> objList = new List<string>();
            objList.AddRange(FindHrefs(html));
            objList.AddRange(FindSRCs(html));

            var datList = objList.Where(x => !x.StartsWith("#") && !x.StartsWith("mailto") && !x.StartsWith("href=\"mailto") && !x.StartsWith("tel") && !x.StartsWith("href=\"tel") && !x.StartsWith("href=\"#") && !x.StartsWith("src=\"#")).Select(x=>  x=(x.StartsWith("href=\"#")? x.Replace("href=\"#", ""):x) ).Distinct();

            string strSubDomain = url.Content("~/");

            if (strSubDomain.StartsWith("/"))
            {
                strSubDomain= strSubDomain.Substring(1);
            }
            if (strSubDomain.EndsWith("/"))
            {
                strSubDomain=strSubDomain.Substring(0,strSubDomain.Length-1);
            }

            foreach (var item in datList)
            {
                string strPath = item.ToString();
                string strOldPath = item.ToString();


                //if(strPath.Contains(strSubDomain+"/"+ strSubDomain))
                //{
                //    start:
                //    strPath=strPath.Replace(strSubDomain + "/" + strSubDomain, strSubDomain);

                //    if (strPath.Contains(strSubDomain + "/" + strSubDomain))
                //    {
                //        goto start;
                //    }
                //}

                if (strPath.StartsWith("href=\"") && !strPath.StartsWith("href=\"#") && strPath.EndsWith("\""))
                {
                    strPath = strPath.Replace("href=\"", "").Replace("\"", "");
                }
                else if (strPath.StartsWith("src=\"") && !strPath.StartsWith("src=\"#") && strPath.EndsWith("\""))
                {
                    strPath = strPath.Replace("src=\"", "").Replace("\"", "");
                }

                if (!strPath.StartsWith("http") && !strPath.Contains("java") && !strPath.StartsWith("href=\"#") && !string.IsNullOrWhiteSpace(strOldPath))
                {
                    if(!strPath.StartsWith("href=\"http"))
                    {
                        strPath = url.Content("~/" + strPath);
                        html = html.Replace(strOldPath, strPath.Replace("//", "/"));
                    }
                }
            }
            return html;
        }

        public static void MessagePopup(Controller p, string errorMessage, PopupMessageType msgType, string msgTitle = "", int timeOutInMinSec = 0, bool msgShowbutton = true)
        {
            if (!string.IsNullOrWhiteSpace(errorMessage))
            {
                string strMessage = " ShowMessage('" + errorMessage.Replace("\'", @"\'") + "!', '" + msgTitle + "', '" + msgType.ToString() + "'," + timeOutInMinSec + "," + msgShowbutton.ToString().ToLower() + "); ";

                if (!string.IsNullOrWhiteSpace(strMessage))
                    p.ViewBag.MyScriptToRun = "$(document).ready(function () { " + strMessage + " });";

            }

        }

        public static void MessagePopupWithRedirect(Controller p, string errorMessage, PopupMessageType msgType, string msgTitle = "", int timeOutInMinSec = 0, bool msgShowbutton = true, string redirectUrl = "")
        {
            if (!string.IsNullOrWhiteSpace(errorMessage))
            {
                // Set reloadPageFlag to false when redirectUrl is provided, as redirection takes precedence
                bool reloadPageFlag = string.IsNullOrWhiteSpace(redirectUrl);

                // Prepare the script for ShowMessageWithCallback
                string strMessage = $" ShowMessageWithCallback('{errorMessage.Replace("'", @"\'")}', '{msgTitle}', '{msgType}', null, {timeOutInMinSec}, {msgShowbutton.ToString().ToLower()}, {reloadPageFlag.ToString().ToLower()}, '{redirectUrl}'); ";

                // Assign the script to ViewBag for execution in the view
                if (!string.IsNullOrWhiteSpace(strMessage))
                    p.ViewBag.MyScriptToRun = "$(document).ready(function () { " + strMessage + " });";
            }
        }


        public static void MessagePopupForLogin(Controller p, string errorMessage, PopupMessageType msgType, string msgTitle = "", int timeOutInMinSec = 0, bool msgShowbutton = true)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(errorMessage))
                {
                    string strMessage = " ShowMessageForLogin('" + errorMessage.Replace("\'", @"\'") + "!', '" + msgTitle + "', '" + msgType.ToString() + "'," + timeOutInMinSec + "," + msgShowbutton.ToString().ToLower() + "); ";

                    // Store the message in session using SetString
                    if (!string.IsNullOrWhiteSpace(strMessage))
                    {
                        p.HttpContext.Session.SetString("PopupMessagehhhasdas", "$(document).ready(function () { " + strMessage + " });");
                    }
                }
            }
            catch (Exception ex)
            {
                // In case of an error, set a default message or value
                p.HttpContext.Session.SetString("PopupMessagehhhasdas", "var a=1;");
            }
        }



        public static bool ValidateMobileNumber(string mobileNumber)
        {
            // This regex pattern ensures that the mobile number is exactly 10 digits long.
            return Regex.IsMatch(mobileNumber, @"^\d{10}$");
        }

        public static bool ValidateEmailId(string emailId)
        {
            return Regex.IsMatch(emailId, @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", RegexOptions.IgnoreCase);
        }



        public static bool ValidatePassword(string password)
        {
            // Correct regex pattern without extra spaces
            string regexPassword = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$";

            // Validate password if it's not null or empty
            if (!string.IsNullOrEmpty(password))
            {
                // Use Regex.IsMatch to check if the password matches the regex pattern
                return Regex.IsMatch(password, regexPassword);
            }
            else
            {
                return false;
            }
        }


        public static string GetRandomNumberString()
        {
            Random generator = new Random();
            string r = generator.Next(0, 1000000).ToString("D6");
            return r;
        }
        public static bool SendEmail(string strToEMail, string strSubject, string strBody, out string strError, bool ishtml = false, List<Attachment> lstAttachment = null, bool? isTest = null)
        {
            strError = "";
            bool isAuth = false;
            try
            {
                string smtpserver = "";
                string smtpPassword = "";
                string fromemail = "";
                string smtpaccount = "";
                string smtpPort = "";
                string smtpIsSecure = "";
                string Email = "";
                if (isTest == null)
                {
                    isTest = (ConfigDetailsValue.SMTPIsTest != "1" ? false : true);
                }
                if (!isTest.Value)
                {
                    smtpserver = ConfigDetailsValue.SMTPServer;
                    smtpPassword = ConfigDetailsValue.SMTPPassword;
                    fromemail = ConfigDetailsValue.SMTPFromEmail;
                    smtpaccount = ConfigDetailsValue.SMTPAccount;
                    smtpPort = ConfigDetailsValue.SMTPPort;
                    smtpIsSecure = ConfigDetailsValue.SMTPIsSecure;
                    Email = strToEMail;
                }
                else
                {

                    smtpserver = ConfigDetailsValue.TestSMTPServer;
                    smtpPassword = ConfigDetailsValue.TestSMTPPassword;
                    fromemail = ConfigDetailsValue.TestSMTPFromEmail;
                    smtpaccount = ConfigDetailsValue.TestSMTPAccount;
                    smtpPort = ConfigDetailsValue.TestSMTPPort;
                    smtpIsSecure = ConfigDetailsValue.TestSMTPIsSecure;
                    Email = strToEMail;
                }

                if (string.IsNullOrWhiteSpace(smtpPassword) && string.IsNullOrWhiteSpace(smtpaccount))
                {
                    isAuth = false;
                }
                else
                {
                    isAuth = true;
                }

                MailMessage msg = new MailMessage();

                SmtpClient client = new SmtpClient();
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.Host = smtpserver;
                if (!string.IsNullOrWhiteSpace(smtpPort))
                {
                    client.Port = Convert.ToInt32(smtpPort);
                }
                // setup Smtp authentication
                if (isAuth)
                {
                    System.Net.NetworkCredential credentials =
                        new System.Net.NetworkCredential(smtpaccount, smtpPassword);
                    client.Credentials = credentials;
                }
                client.UseDefaultCredentials = false;
                msg.To.Add(Email);
                //msg.CC.Add("hardik.mistry@kcspl.co.in");
                // msg.CC.Add("parul@kcspl.co.in");
                msg.IsBodyHtml = ishtml;
                if (lstAttachment != null)
                {
                    foreach (var row in lstAttachment)
                    {
                        msg.Attachments.Add(row);
                    }
                }
                //msg.Subject = strSubject;
                msg.Subject  = strSubject.Replace("\r", "").Replace("\n", "");
                msg.Body = strBody;

                msg.From = new System.Net.Mail.MailAddress(fromemail);
                if (smtpIsSecure != "0" && smtpIsSecure != "")
                {
                    client.EnableSsl = smtpIsSecure == "1" ? true : false;
                }
                else if (smtpIsSecure == "0")
                {
                    client.EnableSsl = false;
                }
                //client.UseDefaultCredentials = false;
                //client.Credentials = new NetworkCredential(smtpaccount, smtpPassword);
                //client.ServicePoint.MaxIdleTime = 1;
                client.Send(msg);
                return true;
            }
            catch (Exception ex)
            {

                strError = "Message=>" + ex.Message;
                if (ex.InnerException != null)
                {
                    strError += " Inner Exception=>" + ex.InnerException != null ? Convert.ToString(ex.InnerException.Message) : "";
                }

                return false;
            }
        }

        #region File Upload, Download and View Code

        public static async Task<JsonResponseModel> DownloadFile(IHttpClientFactory httpClientFactory, string strFolderName)
        {

            JsonResponseModel model = new JsonResponseModel();
            FileDownloadModel fileDownloadModel = new FileDownloadModel();
            try
            {


                if (strFolderName.StartsWith("CouchDB"))
                {
                    #region CouchDb File

                    string[] strFileDetails = strFolderName.Replace("CouchDB##", "").Split("||");
                    string docId= strFileDetails[0], filname= strFileDetails[2].Replace(" ","_");
                    CoutchDBFileManagement coutchDBFileManagement = new CoutchDBFileManagement(httpClientFactory);

                    var docData = (await coutchDBFileManagement.GetAttachmentByteArray(docId, filname));
                    if(docData!=null)
                    {
                        byte[] fileBytes = docData.Result;

                        fileDownloadModel.Filename = filname;
                        fileDownloadModel.DataBytes = fileBytes;
                        fileDownloadModel.FileExtension = System.IO.Path.GetExtension(filname).Replace(".", "").ToUpper();

                        model.isError = false;
                        model.result = fileDownloadModel;
                    }
                    else
                    {
                        model.strMessage = "File Not Found.";
                        model.isError = true;
                        model.type = PopupMessageType.error.ToString();
                    }

                    #endregion
                }
                else
                {
                    var strPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot") + strFolderName;
                    if (File.Exists(strPath))
                    {
                        byte[] fileBytes = File.ReadAllBytes(strPath);
                        string fileName= System.IO.Path.GetFileName(strPath);
                        fileDownloadModel.Filename = fileName;
                        fileDownloadModel.DataBytes = fileBytes;
                        fileDownloadModel.FileExtension = System.IO.Path.GetExtension(fileName).Replace(".", "").ToUpper();

                        model.isError = false;
                        model.result = fileDownloadModel;
                    }
                    else
                    {
                        model.strMessage = "File Not Found.";
                        model.isError = true;
                        model.type = PopupMessageType.error.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), "Functions", "DownloadFile", "");
                model.strMessage = "Record not saved, Try again";
                model.isError = true;
                model.type = PopupMessageType.error.ToString();
            }

            return model;
        }

        /* public static async Task<JsonResponseModel> SaveFile(IFormFile attachment, IHttpClientFactory httpClientFactory, string strFolderName, string strImagePath, FileType fileType, bool? isCouchDBStore = null)
         {
             JsonResponseModel model = new JsonResponseModel();
             try
             {
                 #region File Upload Logic

                 if (strImagePath == null)
                 {
                     strImagePath = "";
                 }
                 var provider = new FileExtensionContentTypeProvider();
                 if (isCouchDBStore == null)
                 {
                     isCouchDBStore = ConfigDetailsValue.AllowCouchDBStore;
                 }

                 CoutchDBFileManagement coutchDBFileManagement = new CoutchDBFileManagement(httpClientFactory);

                 CoutchDBFileManagementResponse coutchDBFileManagementResponse = new CoutchDBFileManagementResponse();

                 coutchDBFileManagementResponse.Filename = attachment.FileName;
                 coutchDBFileManagementResponse.FileExtension = System.IO.Path.GetExtension(attachment.FileName).Replace(".", "").ToUpper();

                 string contentType;
                 if (!provider.TryGetContentType(coutchDBFileManagementResponse.Filename, out contentType))
                 {
                     contentType = "application/octet-stream";
                 }
                 if (contentType.ToLower() != attachment.ContentType.ToLower())
                 {
                     model.strMessage = "Upload valid file!!.";
                     model.isError = true;
                     model.type = PopupMessageType.error.ToString();
                     return model;
                 }

                 if (ValidateFileExtention(coutchDBFileManagementResponse.FileExtension, fileType))
                 {
                     string strNewFIleNAme = DateTime.Now.ToString("ddMMyyyyhhmmssfffff") + GetRandomNumberString() + System.IO.Path.GetExtension(attachment.FileName);
                     if (isCouchDBStore.Value)
                     {
                         CoutchDBFileManagementResponse cfmRes = new CoutchDBFileManagementResponse();
                         CouchResponseModel couchResponseModel = new CouchResponseModel();

                         coutchDBFileManagementResponse.IsCouchDBSave = true;
                         var ms = new MemoryStream();
                         attachment.OpenReadStream().CopyTo(ms);
                         byte[] fileBytes = ms.ToArray();

                         if (strImagePath.Contains("CouchDB"))
                         {

                             string[] strFileDetails = strImagePath.Replace("CouchDB##", "").Split("||");
                             string docId = strFileDetails[0], revId = strFileDetails[1], filname = strNewFIleNAme;
                             await coutchDBFileManagement.DeleteDocumentAsync(docId, revId);
                             var docData = await coutchDBFileManagement.GetAttachmentByteArray(docId, filname);

                             SaveCouchDBAttachment attachmentFile = new SaveCouchDBAttachment();


                             // attachmentFile.FileName = attachment.FileName;
                             attachmentFile.FileName = strNewFIleNAme;
                             attachmentFile.AttachmentData = fileBytes;
                             cfmRes = await coutchDBFileManagement.UpdateAttachment(attachmentFile);
                             if (cfmRes.IsSuccess)
                             {
                                 couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                 coutchDBFileManagementResponse.IsSuccess = true;
                             }
                             else
                             {
                                 attachmentFile = new SaveCouchDBAttachment();
                                 // attachmentFile.FileName = attachment.FileName;
                                 attachmentFile.FileName = strNewFIleNAme;
                                 attachmentFile.AttachmentData = fileBytes;
                                 attachmentFile.FileExtension = System.IO.Path.GetExtension(strNewFIleNAme).Replace(".", "").ToUpper();

                                 cfmRes = await coutchDBFileManagement.AddAttachment(attachmentFile);
                                 if (cfmRes.IsSuccess)
                                 {
                                     couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                     coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                     coutchDBFileManagementResponse.FilePath = "CouchDB##" + couchResponseModel.id + "||" + couchResponseModel.rev + "||" + strNewFIleNAme;
                                 }
                                 else
                                 {
                                     couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                     coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                     ErrorLogger.Trace(cfmRes.Result.ToString(), "Functions=>SaveFile");
                                 }
                             }
                         }
                         else
                         {


                             SaveCouchDBAttachment attachmentFile = new SaveCouchDBAttachment();
                             //attachmentFile.FileName = attachment.FileName;
                             attachmentFile.FileName = strNewFIleNAme;
                             attachmentFile.AttachmentData = fileBytes;
                             attachmentFile.FileExtension = System.IO.Path.GetExtension(strNewFIleNAme).Replace(".", "").ToUpper();

                             cfmRes = await coutchDBFileManagement.AddAttachment(attachmentFile);
                             if (cfmRes.IsSuccess)
                             {
                                 couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                 coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                 coutchDBFileManagementResponse.FilePath = "CouchDB##" + couchResponseModel.id + "||" + couchResponseModel.rev + "||" + strNewFIleNAme;
                             }
                             else
                             {
                                 couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                 coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                 ErrorLogger.Trace(cfmRes.Result.ToString(), "Functions=>SaveFile");
                             }
                         }
                     }
                     else
                     {
                         if (strImagePath.Contains("CouchDB"))
                         {
                             string[] strFileDetails = strImagePath.Replace("CouchDB##", "").Split("||");
                             string docId = strFileDetails[0], revId = strFileDetails[1], filname = strNewFIleNAme;
                             await coutchDBFileManagement.DeleteDocumentAsync(docId, revId);
                         }

                         coutchDBFileManagementResponse.IsCouchDBSave = true;
                         string extension = System.IO.Path.GetExtension(attachment.FileName).Replace(".", "").ToUpper();
                         var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot") + @"\Files\" + strFolderName + @"\";
                         bool exists = System.IO.Directory.Exists(path);

                         if (!exists)
                             System.IO.Directory.CreateDirectory(path);

                         int count = 0;
                         string strPath = path + strNewFIleNAme;
                         string strFileName = Path.GetFileNameWithoutExtension(strPath);
                         while (File.Exists(strPath))
                         {
                             string tempFileName = string.Format("{0}({1})", strFileName, count++);
                             coutchDBFileManagementResponse.Filename = tempFileName + "." + extension;
                             strPath = Path.Combine(path, coutchDBFileManagementResponse.Filename);
                         }

                         using (var stream = new FileStream(path + coutchDBFileManagementResponse.Filename, FileMode.Create))
                         {
                             attachment.CopyTo(stream);
                             coutchDBFileManagementResponse.FilePath = @"\Files\" + strFolderName + @"\" + coutchDBFileManagementResponse.Filename;
                             coutchDBFileManagementResponse.IsSuccess = true;
                         }
                     }


                     if (coutchDBFileManagementResponse != null)
                     {
                         if (coutchDBFileManagementResponse.IsSuccess)
                         {
                             model.isError = false;
                             model.result = coutchDBFileManagementResponse;
                         }
                         else
                         {
                             model.strMessage = "File Save Error so Please try again.";
                             model.isError = true;
                             model.type = PopupMessageType.error.ToString();
                         }
                     }
                     else
                     {
                         model.strMessage = "File Save Error so Please try again.";
                         model.isError = true;
                         model.type = PopupMessageType.error.ToString();
                     }
                 }
                 else
                 {
                     model.strMessage = "File Type Must Be " + DescriptionAttr<FileType>(fileType);
                     model.isError = true;
                     model.type = PopupMessageType.error.ToString();
                 }
                 #endregion

             }
             catch (Exception ex)
             {
                 ErrorLogger.Error(ex.Message, ex.ToString(), "Functions", "SaveFile", "");
                 model.strMessage = "Record not saved, Try again";
                 model.isError = true;
                 model.type = PopupMessageType.error.ToString();
             }

             return model;

         }*/
        public static bool hasSpecialChar(string input)
        {
            string specialChar = @"\|!#$%&/()=?»«@£§€{}.-;'<>_,";
            foreach (var item in specialChar)
            {
                if (input.Contains(item)) return true;
            }

            return false;
        }

        public static async Task<JsonResponseModel> SaveFile(IFormFile attachment, IHttpClientFactory httpClientFactory, string strFolderName, string strImagePath, FileType fileType, bool? isCouchDBStore = null, bool isFixSize = false,long lgLength= 20971520)
        {
            JsonResponseModel model = new JsonResponseModel();
            try
            {
                #region File Upload Logic

                if (strImagePath == null)
                {
                    strImagePath = "";
                }
                var provider = new FileExtensionContentTypeProvider();
                if (isCouchDBStore == null)
                {
                    isCouchDBStore = ConfigDetailsValue.AllowCouchDBStore;
                }

                CoutchDBFileManagement coutchDBFileManagement = new CoutchDBFileManagement(httpClientFactory);

                CoutchDBFileManagementResponse coutchDBFileManagementResponse = new CoutchDBFileManagementResponse();

                coutchDBFileManagementResponse.Filename = attachment.FileName;
                coutchDBFileManagementResponse.FileExtension = System.IO.Path.GetExtension(attachment.FileName).Replace(".", "").ToUpper();
                string fileName = System.IO.Path.GetFileNameWithoutExtension(attachment.FileName);

                string contentType;
                if (!provider.TryGetContentType(coutchDBFileManagementResponse.Filename, out contentType))
                {
                    contentType = "application/octet-stream";
                }
                int CountFileExtension = coutchDBFileManagementResponse.Filename.Count(f => f == '.');
                if (CountFileExtension > 1)
                {
                    model.strMessage = "Not Allow Double Extension File!!.";
                    model.isError = true;
                    model.type = PopupMessageType.error.ToString();
                    return model;
                }
                if (hasSpecialChar(fileName))
                {
                    model.strMessage = "Not Allow Meta Characters In FileName!!.";
                    model.isError = true;
                    model.type = PopupMessageType.error.ToString();
                    return model;
                }
                if (contentType.ToLower() != attachment.ContentType.ToLower())
                {
                    model.strMessage = "Upload valid file format(jpg,jpeg,png)!!.";
                    model.isError = true;
                    model.type = PopupMessageType.error.ToString();
                    return model;
                }
                if (isFixSize)
                {
                    if (attachment.Length > lgLength)
                    {

                        model.strMessage = "file size must be "+(lgLength/ 1048576) +" MB!!.";
                        model.isError = true;
                        model.type = PopupMessageType.error.ToString();
                        return model;
                    }
                }
                if (ValidateFileExtention(coutchDBFileManagementResponse.FileExtension, fileType))
                {
                    string strNewFIleNAme = DateTime.Now.ToString("ddMMyyyyhhmmssfffff") + GetRandomNumberString() + System.IO.Path.GetExtension(attachment.FileName);
                    if (isCouchDBStore.Value)
                    {
                        CoutchDBFileManagementResponse cfmRes = new CoutchDBFileManagementResponse();
                        CouchResponseModel couchResponseModel = new CouchResponseModel();

                        coutchDBFileManagementResponse.IsCouchDBSave = true;
                        var ms = new MemoryStream();
                        attachment.OpenReadStream().CopyTo(ms);
                        byte[] fileBytes = ms.ToArray();

                        if (strImagePath.Contains("CouchDB"))
                        {

                            string[] strFileDetails = strImagePath.Replace("CouchDB##", "").Split("||");
                            string docId = strFileDetails[0], revId = strFileDetails[1], filname = strNewFIleNAme;


                            var responSeDelete= await coutchDBFileManagement.DeleteDocumentRevAsync(docId, revId);
                            if (responSeDelete.IsSuccess)
                            {
                                SaveCouchDBAttachment attachmentFile = new SaveCouchDBAttachment();

                                // attachmentFile.FileName = attachment.FileName;
                                attachmentFile.FileName = strNewFIleNAme;
                                attachmentFile.AttachmentData = fileBytes;
                                cfmRes = await coutchDBFileManagement.UpdateAttachment(attachmentFile);
                                if (cfmRes.IsSuccess)
                                {
                                    couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                    coutchDBFileManagementResponse.IsSuccess = true;
                                    coutchDBFileManagementResponse.FilePath = "CouchDB##" + couchResponseModel.id + "||" + couchResponseModel.rev + "||" + strNewFIleNAme;
                                }
                                else
                                {
                                    attachmentFile = new SaveCouchDBAttachment();
                                    // attachmentFile.FileName = attachment.FileName;
                                    attachmentFile.FileName = strNewFIleNAme;
                                    attachmentFile.AttachmentData = fileBytes;
                                    attachmentFile.FileExtension = System.IO.Path.GetExtension(strNewFIleNAme).Replace(".", "").ToUpper();

                                    cfmRes = await coutchDBFileManagement.AddAttachment(attachmentFile);
                                    if (cfmRes.IsSuccess)
                                    {
                                        couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                        coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                        coutchDBFileManagementResponse.FilePath = "CouchDB##" + couchResponseModel.id + "||" + couchResponseModel.rev + "||" + strNewFIleNAme;
                                    }
                                    else
                                    {
                                        couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                        coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                        ErrorLogger.Trace(cfmRes.Result.ToString(), "Functions=>SaveFile");
                                    }
                                }
                            }
                            else
                            {
                                if (Convert.ToString(responSeDelete.Result).Contains("NotFound"))
                                {

                                    SaveCouchDBAttachment attachmentFile = new SaveCouchDBAttachment();
                                    // attachmentFile.FileName = attachment.FileName;
                                    attachmentFile.FileName = strNewFIleNAme;
                                    attachmentFile.AttachmentData = fileBytes;
                                    attachmentFile.FileExtension = System.IO.Path.GetExtension(strNewFIleNAme).Replace(".", "").ToUpper();

                                    cfmRes = await coutchDBFileManagement.AddAttachment(attachmentFile);
                                    if (cfmRes.IsSuccess)
                                    {
                                        couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                        coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                        coutchDBFileManagementResponse.FilePath = "CouchDB##" + couchResponseModel.id + "||" + couchResponseModel.rev + "||" + strNewFIleNAme;
                                    }
                                    else
                                    {
                                        //couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                        coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                        ErrorLogger.Error(cfmRes.Result.ToString(), "Functions=>SaveFile");
                                    }
                                }
                                else
                                {
                                    coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                    ErrorLogger.Error(cfmRes.Result.ToString(), "Functions=>SaveFile");

                                }
                            }
                        }
                        else
                        {


                            SaveCouchDBAttachment attachmentFile = new SaveCouchDBAttachment();
                            //attachmentFile.FileName = attachment.FileName;
                            attachmentFile.FileName = strNewFIleNAme;
                            attachmentFile.AttachmentData = fileBytes;
                            attachmentFile.FileExtension = System.IO.Path.GetExtension(strNewFIleNAme).Replace(".", "").ToUpper();

                            cfmRes = await coutchDBFileManagement.AddAttachment(attachmentFile);
                            if (cfmRes.IsSuccess)
                            {
                                couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                coutchDBFileManagementResponse.FilePath = "CouchDB##" + couchResponseModel.id + "||" + couchResponseModel.rev + "||" + strNewFIleNAme;
                            }
                            else
                            {
                                //couchResponseModel = JsonConvert.DeserializeObject<CouchResponseModel>(cfmRes.Result);
                                coutchDBFileManagementResponse.IsSuccess = cfmRes.IsSuccess;
                                ErrorLogger.Error(cfmRes.Result.ToString(), "Functions=>SaveFile");
                            }
                        }
                    }
                    else
                    {
                        if (strImagePath.Contains("CouchDB"))
                        {
                            string[] strFileDetails = strImagePath.Replace("CouchDB##", "").Split("||");
                            string docId = strFileDetails[0], revId = strFileDetails[1], filname = strNewFIleNAme;
                            await coutchDBFileManagement.DeleteDocumentAsync(docId, revId);
                        }

                        coutchDBFileManagementResponse.IsCouchDBSave = true;
                        string extension = System.IO.Path.GetExtension(attachment.FileName).Replace(".", "").ToUpper();
                        var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot") + @"\Files\" + strFolderName + @"\";
                        bool exists = System.IO.Directory.Exists(path);

                        if (!exists)
                            System.IO.Directory.CreateDirectory(path);

                        int count = 0;
                        string strPath = path + strNewFIleNAme;
                        string strFileName = Path.GetFileNameWithoutExtension(strPath);
                        while (File.Exists(strPath))
                        {
                            string tempFileName = string.Format("{0}({1})", strFileName, count++);
                            coutchDBFileManagementResponse.Filename = tempFileName + "." + extension;
                            strPath = Path.Combine(path, coutchDBFileManagementResponse.Filename);
                        }

                        using (var stream = new FileStream(path + coutchDBFileManagementResponse.Filename, FileMode.Create))
                        {
                            attachment.CopyTo(stream);
                            coutchDBFileManagementResponse.FilePath = @"\Files\" + strFolderName + @"\" + coutchDBFileManagementResponse.Filename;
                            coutchDBFileManagementResponse.IsSuccess = true;
                        }
                    }


                    if (coutchDBFileManagementResponse != null)
                    {
                        if (coutchDBFileManagementResponse.IsSuccess)
                        {
                            model.isError = false;
                            model.result = coutchDBFileManagementResponse;
                        }
                        else
                        {
                            model.strMessage = "File Save Error so Please try again.";
                            model.isError = true;
                            model.type = PopupMessageType.error.ToString();
                        }
                    }
                    else
                    {
                        model.strMessage = "File Save Error so Please try again.";
                        model.isError = true;
                        model.type = PopupMessageType.error.ToString();
                    }
                }
                else
                {
                    model.strMessage = "File Type Must Be " + DescriptionAttr<FileType>(fileType);
                    model.isError = true;
                    model.type = PopupMessageType.error.ToString();
                }
                #endregion

            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), "Functions", "SaveFile", "");
                model.strMessage = "Record not saved, Try again";
                model.isError = true;
                model.type = PopupMessageType.error.ToString();
            }

            return model;

        }

        public static bool ValidateFileExtention(string fileExtension, FileType fileType)
        {
            bool isProper = false;
            string[] strExt= DescriptionAttr<FileType>(fileType).ToLower().Split(',');
            if(strExt.Length == 0 && fileExtension.ToLower()== DescriptionAttr<FileType>(fileType).ToLower())
            {
                return true;
            }
            else if(strExt.Contains(fileExtension.ToLower()))
            {
                return true;
            }
            else
            {
                return isProper;
            }
        }

        public static string DescriptionAttr<T>(this T source)
        {
            FieldInfo fi = source.GetType().GetField(source.ToString());

            DescriptionAttribute[] attributes = (DescriptionAttribute[])fi.GetCustomAttributes(
                typeof(DescriptionAttribute), false);

            if (attributes != null && attributes.Length > 0) return attributes[0].Description;
            else return source.ToString();
        }

        #endregion

        #region Encode Decode Methods

        public static string Encrypt(string strDecText, bool isHtmlEncode = false)
        {

            //string strEncrypt = EncryptDecrypt.EncryptUsingCBC(strDecText);
            ////return isHtmlEncode ? HttpUtility.UrlEncode(strEncrypt) : strEncrypt;
            //strEncrypt = strEncrypt.Replace("=", "♬").Replace("&", "✦").Replace("/", "✤").Replace("+", "✿");
            //return strEncrypt;

            string strEncrypt = EncryptDecrypt.EncryptUsingCBC(strDecText);
            //return isHtmlEncode ? HttpUtility.UrlEncode(strEncrypt) : strEncrypt;
            return strEncrypt;
        }

        public static string Decrypt(string strEncText, bool isHtmlEncode = false)
        {
            ////    strEncText =strEncText.Replace("$^", "=").Replace("^$", "&").Replace("$€", "/").Replace("€$", "+");
            //strEncText = strEncText.Replace("♬", "=").Replace("✦", "&").Replace("✤", "/").Replace("✿", "+");
            //string strDecrypt = EncryptDecrypt.DecryptUsingCBC(strEncText);
            ////return isHtmlEncode ? HttpUtility.UrlDecode(strDecrypt) : strDecrypt;
            //return strDecrypt;

            string strDecrypt = EncryptDecrypt.DecryptUsingCBC(strEncText);
            //return isHtmlEncode ? HttpUtility.UrlDecode(strDecrypt) : strDecrypt;
            return strDecrypt;
        }


        public static string FrontEncrypt(string strEncText)
        {
            strEncText = strEncText.Replace("=", "♬").Replace("&", "✦").Replace("/", "✤").Replace("+", "✿");
            string strDecrypt = EncDecFront.EncryptStringAES(strEncText);
            //return isHtmlEncode ? HttpUtility.UrlDecode(strDecrypt) : strDecrypt;
            return strDecrypt;
        }

        public static string FrontDecrypt(string strEncText)
        {
            //strEncText = strEncText.Replace("$^", "=").Replace("^$", "&").Replace("$€", "/").Replace("€$", "+");
            strEncText = strEncText.Replace("♬", "=").Replace("✦", "&").Replace("✤", "/").Replace("✿", "+");
            string strDecrypt = EncDecFront.DecryptStringAES(strEncText);
            //return isHtmlEncode ? HttpUtility.UrlDecode(strDecrypt) : strDecrypt;
            return strDecrypt;

            //strEncText = strEncText.Replace("♬", "=").Replace("✦", "&").Replace("✤", "/").Replace("✿", "+");
            //string strDecrypt = EncDecFront.DecryptStringAES(strEncText);
            ////return isHtmlEncode ? HttpUtility.UrlDecode(strDecrypt) : strDecrypt;
            //return strDecrypt;
        }

        public static string ToHexString(string str
            )
        {
            var sb = new StringBuilder();

            var bytes = Encoding.Unicode.GetBytes(str);
            foreach (var t in bytes)
            {
                sb.Append(t.ToString("X2"));
            }

            return sb.ToString(); // returns: "48656C6C6F20776F726C64" for "Hello world"
        }

        public static string FromHexString(string hexString)
        {
            var bytes = new byte[hexString.Length / 2];
            for (var i = 0; i < bytes.Length; i++)
            {
                bytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
            }

            return Encoding.Unicode.GetString(bytes); // returns: "Hello world" for "48656C6C6F20776F726C64"
        }

        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }

        public static Dictionary<string, object> ObjectToDictionary(object obj)
        {
            Dictionary<string, object> ret = new Dictionary<string, object>();

            foreach (PropertyInfo prop in obj.GetType().GetProperties())
            {
                string propName = prop.Name;
                var val = obj.GetType().GetProperty(propName).GetValue(obj, null);
                if (val != null)
                {
                    ret.Add(propName, val);
                }
                else
                {
                    ret.Add(propName, null);
                }
            }

            return ret;
        }

        public static JsonResponseModel ValidateForm(Dictionary<string, object> dataDictionaryList, List<ValidationType> lstFieldList)
        {
            JsonResponseModel objreturn = new JsonResponseModel();

            int fieldCount = lstFieldList.Count();
            int fieldCurrentCount = 0;

            if (dataDictionaryList.Count() > 0)
            {
                foreach (var row in lstFieldList)
                {
                    string strRegEx = row.RegExVAlidation;

                    if (row.IsRequired && String.IsNullOrWhiteSpace(Convert.ToString(dataDictionaryList[row.FieldName])))
                    {
                        objreturn.result = row;
                        objreturn.strMessage = row.StrMessage;
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                        return objreturn;
                    }
                    else if (!String.IsNullOrWhiteSpace(strRegEx))
                    {
                        if (!Regex.Match(Convert.ToString(dataDictionaryList[row.FieldName]), strRegEx).Success)
                        {
                            objreturn.result = row;
                            objreturn.strMessage = row.StrRegExMessage;
                            objreturn.isError = true;
                            objreturn.type = PopupMessageType.error.ToString();
                            return objreturn;
                        }
                    }

                    if (row.CharacterMaxLength != null)
                    {
                        if (row.CharacterMaxLength > 0)
                        {
                            if (row.CharacterMinLength != null)
                            {
                                if (row.CharacterMinLength > 0)
                                {

                                    if (!(Convert.ToString(dataDictionaryList[row.FieldName]).Length <= row.CharacterMaxLength && Convert.ToString(dataDictionaryList[row.FieldName]).Length >= row.CharacterMinLength))
                                    {
                                        objreturn.result = row;
                                        objreturn.strMessage = row.StrTypeMessage;
                                        objreturn.isError = true;
                                        objreturn.type = PopupMessageType.error.ToString();
                                        return objreturn;
                                    }
                                }
                            }
                        }
                        else
                        {

                            if (Convert.ToString(dataDictionaryList[row.FieldName]).Length >= row.CharacterMaxLength)
                            {
                                objreturn.result = row;
                                objreturn.strMessage = row.RegExVAlidation;
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                                return objreturn;
                            }
                        }
                    }

                    fieldCurrentCount++;

                }
            }
            if (fieldCurrentCount == fieldCount)
            {
                objreturn.isError = false;
                objreturn.type = PopupMessageType.error.ToString();
                return objreturn;
            }

            objreturn.strMessage = "Form Input Is Not valid";
            objreturn.isError = true;
            return objreturn;

        }

        public static string ConvertDataTableToHTML(DataTable dt)
        {
            string html = "<table class=\"table table-striped table-bordered text-center nowrap\" id=\"dvReportTable\"><thead>";
            //add header row
            html += "<tr>";
            for (int i = 0; i < dt.Columns.Count; i++)
                html += "<th>" + dt.Columns[i].ColumnName + "</th>";
            html += "</tr></thead><tbody>";
            //add rows
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                html += "<tr>";
                for (int j = 0; j < dt.Columns.Count; j++)
                    html += "<td>" + dt.Rows[i][j].ToString() + "</td>";
                html += "</tr>";
            }
            html += "</tbody></table>";
            return html;
        }
        #endregion

    }
}
