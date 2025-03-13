using Velzon.Common;
using Velzon.Model.Service;
using Velzon.IService.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    // Represents the controller responsible for handling video-related requests and operations in the application. <summary>
    // Represents the controller responsible for handling video-related requests and operations in the application.
    // The VideoController class inherits from BaseController where T is VideoController.
    // This inheritance provides the controller with common functionalities and properties defined in the base controller,
    // while allowing it to specialize in video-related actions.   
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class VideoController : BaseController<VideoController>
    {
        #region Controller Variable

        // Private field for accessing video services
        // This field is used to interact with video-related operations through the IVideoServices interface.
        private IVideoService objVideoMasterServices { get; set; }

        // Gets or sets the VideoFormModel instance stored in the current HTTP session.
        public VideoFormModel mdlVideoFrontModel
        {
            get { return SessionWrapper.Get<VideoFormModel>(this.HttpContext.Session, "VideoFormModel"); }
            set { SessionWrapper.Set<VideoFormModel>(this.HttpContext.Session, "VideoFormModel", value); }
        }
        #endregion

        #region Controller Constructor
        // Initializes a new instance of the  VideoController class.
        public VideoController(IVideoService _VideoMasterServices, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            this.objVideoMasterServices = _VideoMasterServices;
        }
        #endregion

        #region Controller Method
        // This action method handles the GET request for the VideoMaster page.
        // It is protected by the PageRightsFilter, which ensures the user has the necessary permissions.
        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/VideoMaster")]
        [HttpGet]
        public IActionResult VideoMaster()
        {
            try
            {
                // Return the view for the VideoMaster page.
                return View();
            }
            catch (Exception ex)
            {
                // If an exception occurs, redirect the user to the Index action of the Account controller.
                return RedirectToAction("Index", "Account");
            }
        }
        
        // This action method handles the POST request to save video data.
        // It accepts form data as a VideoFormModel and returns a JSON response.
        [Route("/Admin/SaveVideoData")]
        [DisableRequestSizeLimit]
        [HttpPost]
        public JsonResult SaveVideoData([FromForm] VideoFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                // Validate the form data using the ValidateForm method.
                // This method likely checks for required fields and data integrity.
                objreturn = (ValidateForm(objModel));
                if (!objreturn.isError)
                {
                    if (mdlVideoFrontModel == null)
                    {
                        mdlVideoFrontModel = new VideoFormModel();
                    }
                    if (mdlVideoFrontModel.lstEventVideoMasterModels == null)
                    {
                        mdlVideoFrontModel.lstEventVideoMasterModels = new List<VideoNameModelform>();
                    }
                    else
                    {
                        objModel.lstEventVideoMasterModels = mdlVideoFrontModel.lstEventVideoMasterModels;
                    }
                    // Perform additional validation on the video data.
                    // The ValidVideoData method likely checks specific business rules related to videos.
                    if (ValidVideoData(ref objModel, ref objreturn))
                    {
                        VideoModel videoModel = new VideoModel();

                        if (objModel.Id == null)
                        {
                            objModel.Id = 0;
                        }
                        videoModel.Id = objModel.Id;
                        videoModel.LanguageId = objModel.LanguageId;
                        videoModel.VideoTitle = objModel.VideoTitle;
                        videoModel.IsActive = objModel.IsActive;
                        videoModel.Username = UserModel.Username;
                        videoModel.lstVideoModels = objModel.lstEventVideoMasterModels.Select(x => new VideoNameModel
                        {
                            VideoName = x.VideoName,
                            ThumbImage = x.ThumbImage,
                            VideoUrl = x.VideoUrl,
                            urllink = x.urllink,
                            ThumbFileName = x.ThumbFileName,
                            ThumbFilePath = x.ThumbFilePath
                        }).ToList();

                        if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && videoModel.Id == 0)
                        {
                            if (objModel.LanguageId == 2)
                            {
                                videoModel.Id = objModel.VideoId.Value;

                            }
                            objreturn = objVideoMasterServices.AddOrUpdate(videoModel);
                            objreturn.strMessage = "Record created successfully.";
                            objreturn.isError = false;
                            objreturn.type = PopupMessageType.success.ToString();
                            mdlVideoFrontModel = new VideoFormModel();
                        }
                        else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && videoModel.Id != 0)
                        {
                            // Assign the VideoId from the form model to the VideoModel.
                            // VideoId is required for updates.
                            videoModel.VideoId = objModel.VideoId.Value;
                            objreturn = objVideoMasterServices.AddOrUpdate(videoModel);
                            objreturn.strMessage = "Record updated successfully.";
                            objreturn.isError = false;
                            objreturn.type = PopupMessageType.success.ToString();
                            mdlVideoFrontModel = new VideoFormModel();
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
                        // If video data validation fails, set the error message accordingly.
                        // The ValidateVideoData method is expected to set objreturn.strMessage.
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
                // Log the exception details for debugging and monitoring purposes.
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
                objreturn.strMessage = "Record not saved, Try again";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        // Route for saving gallery video data
        [Route("/Admin/SaveGallaryVideoData")]
        // Disable request size limit for file uploads
        [DisableRequestSizeLimit]
        // Set request form limits for value length and multipart body length
        [RequestFormLimits(ValueLengthLimit = int.MaxValue, MultipartBodyLengthLimit = long.MaxValue)]
        [HttpPost]
        public async Task<JsonResult> SaveGallaryVideoData([FromForm] VideoNameModelform objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            int urllink = 0;
            try
            {
                List<VideoNameModelform> lstData = new List<VideoNameModelform>();
                objreturn = (validatevideoform(objModel));
                if (!objreturn.isError)
                {
                    if (mdlVideoFrontModel == null)
                    {
                        mdlVideoFrontModel = new VideoFormModel();
                    }
                    if (mdlVideoFrontModel.lstEventVideoMasterModels == null)
                    {
                        mdlVideoFrontModel.lstEventVideoMasterModels = new List<VideoNameModelform>();
                    }
                    else
                    {
                        lstData = mdlVideoFrontModel.lstEventVideoMasterModels;
                    }
                    VideoNameModelform objBovideo = new VideoNameModelform();
                    if (objModel.Image != null)
                    {
                        if (objModel.Image.Count() > 0)
                        {

                            string strFileName = ""; int countVIdeo = 0;
                            foreach (IFormFile image in objModel.Image)
                            {
                                if (!Functions.ValidateFileExtention(System.IO.Path.GetExtension(image.FileName).Replace(".", "").ToUpper(), FileType.VideoType))
                                {
                                    strFileName += " only allow videos!!!";
                                }
                            }
                            if (strFileName.Length > 0)
                            {
                                objreturn.strMessage = "File type is not valid " + strFileName.Remove(strFileName.Length - 1, 1);
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                                return Json(objreturn);
                            }
                            foreach (var image in objModel.Image)
                            {
                                var data = (await Functions.SaveFile(image, httpClientFactory, "Video", "", FileType.VideoType, true));

                                if (data != null)
                                {
                                    if (!data.isError)
                                    {
                                        if (objModel.ThumbFile != null)
                                        {

                                            if (objModel.ThumbFile.Count() > 0)
                                            {
                                                foreach (var thumb in objModel.ThumbFile)
                                                {
                                                    var data1 = (await Functions.SaveFile(thumb, httpClientFactory, "Image", "", FileType.ImageType, true));

                                                    if (data1 != null)
                                                    {
                                                        if (!data1.isError)
                                                        {
                                                            objModel.ThumbImage = (data1.result.FilePath);
                                                        }
                                                        else
                                                        {
                                                            return Json(data1);
                                                        }

                                                    }
                                                }
                                            }
                                            else
                                            {
                                                if (objModel == null)
                                                {
                                                    objreturn.strMessage = "Please Save atleast one Image";
                                                }
                                                else
                                                {
                                                    objreturn.strMessage = "Form Input is not valid";
                                                }
                                                objreturn.isError = true;
                                                objreturn.type = PopupMessageType.error.ToString();
                                            }
                                        }
                                        objModel.ImageName = data.result.Filename;
                                        objModel.ImagePath = (data.result.FilePath);
                                        if (lstData == null)
                                        {
                                            lstData = new List<VideoNameModelform>();
                                        }
                                        if (objModel.RowIndex.ToString() == "0")
                                        {
                                            objBovideo = new VideoNameModelform();
                                            objBovideo.RowIndex = objModel.RowIndex;
                                            objBovideo.ImagePath = objModel.ImagePath;
                                            objBovideo.ImageName = objModel.ImageName;
                                            objBovideo.VideoName = objModel.VideoName;
                                            objBovideo.ThumbImage = objModel.ThumbImage;
                                            objBovideo.VideoUrl = objModel.ImagePath;
                                        }
                                        else
                                        {
                                            objBovideo = lstData.Where((i, x) => i.RowIndex == objModel.RowIndex).FirstOrDefault();
                                            objBovideo.ImagePath = objModel.ImagePath;
                                            objBovideo.ImageName = objModel.ImageName;
                                            objBovideo.VideoName = objModel.VideoName;
                                            objBovideo.ThumbImage = objModel.ThumbImage;
                                            objBovideo.VideoUrl = objModel.ImagePath;
                                        }
                                    }
                                    else
                                    {
                                        return Json(data);
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (objModel == null)
                            {
                                objreturn.strMessage = "Please Save atleast one Video";
                            }
                            else
                            {
                                objreturn.strMessage = "Form Input is not valid";
                            }
                            objreturn.isError = true;
                            objreturn.type = PopupMessageType.error.ToString();
                        }
                    }
                    if (ValidAllVideoData(ref objModel, ref objreturn))
                    {
                        VideoNameModelform objBo = new VideoNameModelform();
                        if (objModel != null)
                        {
                            if (lstData == null)
                            {
                                lstData = new List<VideoNameModelform>();
                            }
                            if (objModel.RowIndex.ToString() == "0")
                            {
                                objBo = new VideoNameModelform();
                                objBo.RowIndex = objModel.RowIndex;
                                objBo.VideoName = objModel.VideoName;
                                objBo.ThumbImage = objModel.ThumbImage;
                                objBo.VideoUrl = objModel.VideoUrl;
                            }
                            else
                            {
                                objBo = lstData.Where((i, x) => i.RowIndex == objModel.RowIndex).FirstOrDefault();
                                objBo.VideoName = objModel.VideoName;
                                objBo.ThumbImage = objModel.ThumbImage;
                                objBo.VideoUrl = objModel.VideoUrl;
                            }

                            bool isInsert = Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert;
                            bool isUpdate = Common.Functions.GetPageRightsCheck(HttpContext.Session).Update;
                            if (objModel.RowIndex == 0 && isInsert)
                            {
                                if (objBovideo.ImagePath == null)
                                {
                                    urllink = 1;
                                    objBo.urllink = urllink;
                                    lstData.Add(objBo);
                                }
                                else
                                {
                                    urllink = 0;
                                    objBovideo.urllink = urllink;
                                    lstData.Add(objBovideo);
                                }
                            }
                            else if (isUpdate)
                            {

                            }
                            else
                            {
                                objreturn.strMessage = "You Don't have Rights perform this action.";
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                                return Json(objreturn);
                            }
                        }
                        else
                        {
                            objreturn.strMessage = "Please Select File.";
                            objreturn.isError = true;
                            objreturn.type = PopupMessageType.error.ToString();
                            return Json(objreturn);

                        }


                        VideoFormModel tabSubDetails = new VideoFormModel();
                        tabSubDetails = mdlVideoFrontModel;
                        tabSubDetails.lstEventVideoMasterModels = lstData;


                        if (tabSubDetails.lstEventVideoMasterModels.Count() > 0)
                        {
                            int i = 0;
                            tabSubDetails.lstEventVideoMasterModels.OrderBy(x => x.RowIndex).ToList().ForEach(x =>
                            {
                                x.RowIndex = i;
                                i++;
                            });
                        }

                        mdlVideoFrontModel = tabSubDetails;
                        var dataSet = mdlVideoFrontModel;

                        objreturn.isError = false;
                        objreturn.type = PopupMessageType.success.ToString();

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

        // Method to validate video data
        public bool ValidVideoData(ref VideoFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.VideoTitle, ControlInputType.none))
                {
                    if (ValidLength(objModel.VideoTitle))
                    {
                        objreturn.strMessage = "Enter valid Name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter Name!";
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

        [IgnoreAntiforgeryToken]
        [Route("/Admin/DownloadresourceFile")]
        public async Task<ActionResult> DownloadresourceFile(string fileName)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            fileName = HttpUtility.UrlDecode(fileName.ToString().Replace("?", "").Replace(");", "")).Replace("'", "").Trim();
            if (!string.IsNullOrWhiteSpace(fileName))
            {
                if (Common.Functions.GetPageRightsCheck(HttpContext.Session).View)
                {
                    fileName = fileName.Replace("HASH_HASH", "+").Replace("HASH__HASH", "/");
                    fileName = Velzon.Common.Functions.FrontDecrypt(fileName).Replace("_", " ");
                    var docData = await Functions.DownloadFile(httpClientFactory, fileName);
                    if (docData != null)
                    {
                        if (docData.isError)
                        {
                            objreturn = docData;
                            ViewData.Add("DataIssue", objreturn);
                            return Redirect(Url.Content("~/Admin/Video"));
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
                        return Redirect(Url.Content("~/Admin/Video"));
                    }
                }
                else
                {
                    objreturn.isError = true;
                    objreturn.strMessage = "You Don't have Rights perform this action.";
                    DataIssue = objreturn;
                    return Redirect(Url.Content("~/Admin/Video"));
                }
            }
            else
            {
                objreturn.isError = true;
                objreturn.strMessage = "Please Enter File Path.";
                DataIssue = objreturn;
                return Redirect(Url.Content("~/Admin/Video"));
            }
        }

        // Method to validate all video data in the VideoNameModelform object
        public bool ValidAllVideoData(ref VideoNameModelform objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (objModel.Image != null)
                {
                    if (objModel.Image.Count == 0)
                    {
                        if (!ValidControlValue(objModel.VideoName, ControlInputType.none))
                        {
                            if (ValidLength(objModel.VideoName))
                            {
                                objreturn.strMessage = "Enter valid Name!";
                            }
                            else
                            {
                                objreturn.strMessage = "Enter Name!";
                            }
                        }
                        else if (!ValidControlValue(objModel.ThumbImage, ControlInputType.none))
                        {
                            if (ValidLength(objModel))
                            {
                                objreturn.strMessage = "Enter valid Thumb Image Url!";
                            }
                            else
                            {
                                objreturn.strMessage = "Enter Thumb Image Url!";
                            }
                        }
                        else if (!ValidControlValue(objModel.VideoUrl, ControlInputType.none))
                        {
                            if (ValidLength(objModel))
                            {
                                objreturn.strMessage = "Enter valid Video Url!";
                            }
                            else
                            {
                                objreturn.strMessage = "Enter Video Url!";
                            }
                        }
                        else
                        {
                            allow = true;
                        }
                    }
                    else
                    {
                        if (!ValidControlValue(objModel.VideoName, ControlInputType.none))
                        {
                            if (ValidLength(objModel.VideoName))
                            {
                                objreturn.strMessage = "Enter valid Name!";
                            }
                            else
                            {
                                objreturn.strMessage = "Enter Name!";
                            }
                        }

                        else
                        {
                            allow = true;
                        }
                    }
                }
                else
                {
                    if (!ValidControlValue(objModel.VideoName, ControlInputType.none))
                    {
                        if (ValidLength(objModel.VideoName))
                        {
                            objreturn.strMessage = "Enter valid Name!";
                        }
                        else
                        {
                            objreturn.strMessage = "Enter Name!";
                        }
                    }
                    else if (!ValidControlValue(objModel.ThumbImage, ControlInputType.none))
                    {
                        if (ValidLength(objModel))
                        {
                            objreturn.strMessage = "Enter valid Thumb Image Url!";
                        }
                        else
                        {
                            objreturn.strMessage = "Enter Thumb Image Url!";
                        }
                    }
                    else if (!ValidControlValue(objModel.VideoUrl, ControlInputType.none))
                    {
                        if (ValidLength(objModel))
                        {
                            objreturn.strMessage = "Enter valid Video Url!";
                        }
                        else
                        {
                            objreturn.strMessage = "Enter Video Url!";
                        }
                    }
                    else
                    {
                        allow = true;
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
            return allow;
        }

        // Handles POST requests to retrieve video data for a DataTable
        [HttpPost]
        [Route("/Admin/GetVideoData")]
        public JsonResult GetVideoData(CMSCommonGridModel cgt)
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = objVideoMasterServices.GetList((long)cgt.lgLangId);

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        // Retrieves detailed video data based on provided identifiers.
        [Route("/Admin/GetVideoDataDetails")]
        [HttpPost]
        public JsonResult GetVideoDataDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            VideoFormModel videoFrontModel = new VideoFormModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    var data = objVideoMasterServices.Get(lgid, lgLangId);
                    if (data != null)
                    {
                        videoFrontModel.Id = data.Id;
                        videoFrontModel.VideoId = data.VideoId;
                        videoFrontModel.VideoTitle = data.VideoTitle;
                        videoFrontModel.IsActive = data.IsActive;
                        videoFrontModel.LanguageId = data.LanguageId;
                        var videoData = data.lstVideoModels.Select(x => new VideoNameModelform
                        {
                            VideoName = x.VideoName,
                            ThumbImage = x.ThumbImage,
                            VideoUrl = x.VideoUrl,
                            urllink = x.urllink
                        }).ToList();
                        int i = 0;
                        if (videoData.Count() > 0)
                        {
                            i = 1;
                            videoData.OrderBy(x => x.RowIndex).ToList().ForEach(x =>
                            {
                                x.RowIndex = i;
                                i++;
                            });
                        }
                        videoFrontModel.lstEventVideoMasterModels = videoData;
                        mdlVideoFrontModel = videoFrontModel;
                        objreturn.result = mdlVideoFrontModel;
                    }
                    else
                    {
                        objreturn.result = data;
                    }
                }
                //else
                //{
                //    objreturn.strMessage = "Enter Valid Id.";
                //    objreturn.isError = true;
                //    objreturn.type = PopupMessageType.error.ToString();
                //}
                else
                {
                    mdlVideoFrontModel = new VideoFormModel();
                    objreturn.result = mdlVideoFrontModel;

                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(objreturn);
        }


        // Retrieves detailed video data based on provided identifiers.
        [Route("/Admin/GetVideoDetails")]
        [HttpPost]
        public JsonResult GetVideoDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                VideoFormModel videoFrontModel = new VideoFormModel();
                if (id == "0")
                {
                    objreturn.isError = false;
                    mdlVideoFrontModel = new VideoFormModel();
                    return Json(objreturn);
                }
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Velzon.Common.Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    var data = objVideoMasterServices.Get(lgid, lgLangId);
                    if (data != null)
                    {
                        videoFrontModel.Id = data.Id;
                        videoFrontModel.VideoId = data.VideoId;
                        videoFrontModel.LanguageId = data.LanguageId;
                        videoFrontModel.VideoTitle = data.VideoTitle;
                        videoFrontModel.IsActive = data.IsActive;

                        var videoData = data.lstVideoModels.Select(x => new VideoNameModelform
                        {
                            VideoName = x.VideoName,
                            ThumbImage = x.ThumbImage,
                            VideoUrl = x.VideoUrl,
                            urllink = x.urllink
                        }).ToList();
                        int i = 0;
                        if (videoData.Count() > 0)
                        {
                            i = 1;
                            videoData.OrderBy(x => x.RowIndex).ToList().ForEach(x =>
                            {
                                x.RowIndex = i;
                                i++;
                            });
                        }
                        videoFrontModel.lstEventVideoMasterModels = videoData;

                    }
                    else
                    {
                        objreturn.strMessage = "Record Not Found.";
                        objreturn.isError = true;
                        mdlVideoFrontModel = new VideoFormModel();
                        objreturn.type = PopupMessageType.error.ToString();

                    }

                    mdlVideoFrontModel = videoFrontModel;
                    objreturn.result = mdlVideoFrontModel;
                }
                else
                {
                    mdlVideoFrontModel = new VideoFormModel();
                    objreturn.result = mdlVideoFrontModel;

                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(objreturn);
        }

        // Deletes a video record based on the provided identifier.
        [Route("/Admin/DeleteVideoData")]
        [HttpPost]
        public JsonResult DeleteVideoData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = objVideoMasterServices.Delete(lgid, UserModel.Username);
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

        [IgnoreAntiforgeryToken]
        [Route("/Admin/DownloadVideoFile")]
        public async Task<ActionResult> DownloadVideoFile(string fileName)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            fileName = HttpUtility.UrlDecode(fileName.ToString().Replace("?", "").Replace(");", "")).Replace("'", "").Trim();
            if (!string.IsNullOrWhiteSpace(fileName))
            {
                if (Common.Functions.GetPageRightsCheck(HttpContext.Session).View)
                {
                    fileName = fileName.Replace("HASH_HASH", "+").Replace("HASH__HASH", "/");
                    fileName = Velzon.Common.Functions.FrontDecrypt(fileName).Replace("_", " ");
                    var docData = await Functions.DownloadFile(httpClientFactory, fileName);
                    if (docData != null)
                    {
                        if (docData.isError)
                        {
                            objreturn = docData;
                            ViewData.Add("DataIssue", objreturn);
                            return Redirect(Url.Content("~/Admin/VideoMaster"));
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
                        return Redirect(Url.Content("~/Admin/VideoMaster"));
                    }
                }
                else
                {
                    objreturn.isError = true;
                    objreturn.strMessage = "You Don't have Rights perform this action.";
                    DataIssue = objreturn;
                    return Redirect(Url.Content("~/Admin/VideoMaster"));
                }
            }
            else
            {
                objreturn.isError = true;
                objreturn.strMessage = "Please Enter File Path.";
                DataIssue = objreturn;
                return Redirect(Url.Content("~/Admin/VideoMaster"));
            }
        }
        // Retrieves gallery video data and returns it in a JSON format suitable for DataTables or similar components.
        [HttpPost]
        [Route("/Admin/GetGallaryVideoData")]
        public JsonResult GetGallaryVideoData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                VideoFormModel objData = new VideoFormModel();

                List<VideoNameModelform> lstMainData = new List<VideoNameModelform>();

                if (mdlVideoFrontModel == null)
                {
                    objData = new VideoFormModel();
                    mdlVideoFrontModel = objData;
                }
                if (mdlVideoFrontModel.lstEventVideoMasterModels == null)
                {
                    objData.lstEventVideoMasterModels = lstMainData;
                    mdlVideoFrontModel = objData;
                }
                objData = mdlVideoFrontModel;

                var lsdata = mdlVideoFrontModel.lstEventVideoMasterModels;

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        // Retrieves the details of a specific gallery video based on the provided ID.
        [Route("/Admin/GetGallaryVideoDetails")]
        [HttpPost]
        public JsonResult GetGallaryVideoDetails(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                //id = HttpUtility.UrlDecode(id).Replace('+', '-');
                //langId = HttpUtility.UrlDecode(langId).Replace('+', '-');
                if (long.TryParse(Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    var data = mdlVideoFrontModel.lstEventVideoMasterModels[(int)lgid - 1];
                    if (data != null)
                    {
                        //{
                        //    var Type = ((TenderDocumentType)Convert.ToInt16(data.DocType));
                        //    data.DocType = Functions.DescriptionAttr<TenderDocumentType>(Type);
                        //}
                        objreturn.result = data;
                    }
                    else
                    {
                        objreturn.strMessage = "Record not Found.";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                    }
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

                objreturn.strMessage = "Record not Found.";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
            }
            return Json(objreturn);
        }

        // Deletes a gallery video data based on the provided ID.
        [Route("/Admin/DeleteGallaryVideoData")]
        [HttpPost]
        public JsonResult DeleteGallaryVideoData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        var maindata = mdlVideoFrontModel;

                        var data = maindata.lstEventVideoMasterModels[((int)lgid - 1)];

                        maindata.lstEventVideoMasterModels.Remove(data);

                        int i = 1;

                        maindata.lstEventVideoMasterModels.ForEach(x =>
                        {
                            x.RowIndex = i;
                            i++;
                        });

                        mdlVideoFrontModel = maindata;


                        objreturn.strMessage = "Removed Done.";
                        objreturn.isError = false;
                        objreturn.type = PopupMessageType.success.ToString();
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

        // Validates the video data before saving it. Returns true if the data is valid, otherwise false.
        // Updates the JsonResponseModel to provide feedback on validation results.
        public bool ValidVideosaveData(VideoFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.VideoTitle, ControlInputType.none))
                {
                    if (ValidLength(objModel.VideoTitle))
                    {
                        objreturn.strMessage = "Enter valid section name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter section name!";
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

        #region Validation 

        //Validates the fields of a given VideoFormModel object and returns a JsonResponseModel with validation results.
        private JsonResponseModel ValidateForm(VideoFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            objreturn.isError = false;

            var lstFieldList = objModel.validationMainForm.Where(x => !x.IsFormClickTab).ToList();

            var dataDictionaryList = Functions.ObjectToDictionary(objModel);

            var model = Functions.ValidateForm(dataDictionaryList, lstFieldList);
            objreturn = model;
            return objreturn;
        }

        // Validates the fields of a given VideoNameModelform object and returns a JsonResponseModel with validation results.
        private JsonResponseModel validatevideoform(VideoNameModelform objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            objreturn.isError = false;
            if (objModel.validationMainFormv.Count != 0)
            {
                if (objModel.urllink == 1)
                {
                    var lstFieldList = objModel.validationMainFormv.Where(x => !x.IsFormClickTab).ToList();

                    var dataDictionaryList = Functions.ObjectToDictionary(objModel);

                    var model = Functions.ValidateForm(dataDictionaryList, lstFieldList);
                    objreturn = model;
                }
            }
            return objreturn;
        }
        #endregion
    }
}
