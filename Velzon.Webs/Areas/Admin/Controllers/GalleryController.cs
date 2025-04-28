using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Webs.Areas.Admin.Controllers;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using System.Web;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [AutoValidateAntiforgeryToken]
    [Area("Admin")]
    public class GalleryController : BaseController<BannerController>
    {
        #region Controller Variable

        private IGalleryService galleryService { get; set; }

        public GalleryFormModel mdlGalleryFrontModel
        {
            get { return SessionWrapper.Get<GalleryFormModel>(this.HttpContext.Session, "GalleryFrontModel"); }
            set { SessionWrapper.Set<GalleryFormModel>(this.HttpContext.Session, "GalleryFrontModel", value); }
        }

        #endregion

        #region Controller Constructor

        public GalleryController(IGalleryService _galleryService, IHttpClientFactory _httpClientFactory) : base(_httpClientFactory)
        {
            galleryService = _galleryService;
        }

        #endregion

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/GalleryMaster")]
        public IActionResult GalleryMaster()
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
                    mdlGalleryFrontModel = new GalleryFormModel();
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

        #region Gallery Album 

        [Route("/Admin/GetGalleryData")]
        [HttpPost]
        public JsonResult GetGalleryData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                var lsdata = galleryService.GetList().OrderBy(x => x.AlbumRank);

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }
        }

        [Route("/Admin/GallerySwapDetails")]
        [HttpPost]
        public JsonResult GallerySwapDetails(string rank, string dir)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {

                dir = Velzon.Common.Functions.FrontDecrypt(dir);
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(rank), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = galleryService.SwapSequance(lgid, dir, UserModel.Username);
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

        [Route("/Admin/GetGalleryDataById")]
        [HttpPost]
        public JsonResult GetGalleryDataById(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse((HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse((HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    objreturn.result = galleryService.GetMenuRes(lgid, lgLangId);
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

        [Route("/Admin/GetGalleryDetails")]
        [HttpPost]
        public JsonResult GetGalleryDetails(string id, string langId)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                GalleryFormModel galleryFrontModel = new GalleryFormModel();
                if (id == "0")
                {
                    objreturn.isError = false;
                    mdlGalleryFrontModel = new GalleryFormModel();
                    return Json(objreturn);
                }
                //id = HttpUtility.UrlDecode(id).Replace('+', '-');
                //langId = HttpUtility.UrlDecode(langId).Replace('+', '-');
                if (long.TryParse(Functions.FrontDecrypt(HttpUtility.UrlDecode(id)), out long lgid) && long.TryParse(Functions.FrontDecrypt(HttpUtility.UrlDecode(langId)), out long lgLangId))
                {
                    objreturn.strMessage = "";
                    objreturn.isError = false;
                    var data = galleryService.Get(lgid, lgLangId);
                    if (data != null)
                    {
                        galleryFrontModel.Id = data.Id;
                        galleryFrontModel.GallerymasterId = data.GallerymasterId;
                        galleryFrontModel.LanguageId = data.LanguageId;
                        galleryFrontModel.PlaceName = data.PlaceName;
                        galleryFrontModel.ThumbImageName = data.ThumbImageName;
                        galleryFrontModel.ThumbImagePath = data.ThumbImagePath;
                        galleryFrontModel.IsActive = data.IsActive;
                        galleryFrontModel.IsVideo = data.IsVideo;


                        var imgData = data.lstGalleryImagesModels.Select(x => new EventImageModel
                        {
                            ImageName = x.ImageName,
                            ImagePath = x.ImagePath
                        }).ToList();
                        int i = 0;
                        if (imgData.Count() > 0)
                        {
                            i = 1;
                            imgData.OrderBy(x => x.RowIndex).ToList().ForEach(x =>
                            {
                                x.RowIndex = i;
                                i++;
                            });
                        }
                        galleryFrontModel.lstEventImagesMasterModels = imgData;

                    }
                    else
                    {
                        objreturn.strMessage = "Record Not Found.";
                        objreturn.isError = true;
                        mdlGalleryFrontModel = new GalleryFormModel();
                        objreturn.type = PopupMessageType.error.ToString();

                    }

                    mdlGalleryFrontModel = galleryFrontModel;
                    objreturn.result = mdlGalleryFrontModel;
                }
                else
                {
                    mdlGalleryFrontModel = new GalleryFormModel();
                    objreturn.result = mdlGalleryFrontModel;

                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            }
            return Json(objreturn);
        }

        [Route("/Admin/DeleteGalleryData")]
        [HttpPost]
        public JsonResult DeleteGalleryData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        objreturn = galleryService.Delete(lgid, UserModel.Username);
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

        [Route("/Admin/SaveGalleryData")]
        [HttpPost]
        [DisableRequestSizeLimit]
        [RequestFormLimits(ValueLengthLimit = int.MaxValue, MultipartBodyLengthLimit = long.MaxValue)]
        public async Task<JsonResult> SaveGalleryData(GalleryFormModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ValidGalleryData(objModel, ref objreturn))
                {
                    if (ModelState.IsValid)
                    {
                        if (mdlGalleryFrontModel == null)
                        {
                            mdlGalleryFrontModel = new GalleryFormModel();
                        }
                        if (mdlGalleryFrontModel.lstEventImagesMasterModels == null)
                        {
                            mdlGalleryFrontModel.lstEventImagesMasterModels = new List<EventImageModel>();
                        }
                        else
                        {
                            objModel.lstEventImagesMasterModels = mdlGalleryFrontModel.lstEventImagesMasterModels;
                        }
                        if (!ValidateMainForm(ref objModel, ref objreturn))
                        {

                            GalleryModel objMainModel = new GalleryModel();
                            objMainModel.Id = objModel.Id.Value;
                            //objMainModel.GallerymasterId = (int)objModel.GallerymasterId;
                            objMainModel.LanguageId = objModel.LanguageId;
                            objMainModel.PlaceName = objModel.PlaceName;
                            objMainModel.IsActive = objModel.IsActive;
                            objMainModel.IsVideo = objModel.IsVideo;
                            objMainModel.ThumbImageName = objModel.ThumbImageName;
                            objMainModel.ThumbImagePath = objModel.ThumbImagePath;
                            objMainModel.GallerymasterId = objModel.Id.Value;
                            objMainModel.AlbumRank = objModel.AlbumRank;
                            objMainModel.lstGalleryImagesModels = objModel.lstEventImagesMasterModels.Select(x => new GalleryImagesModel
                            {
                                ImageName = x.ImageName,
                                ImagePath = x.ImagePath
                            }).ToList();

                            if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert && objMainModel.Id == 0)
                            {
                                if (galleryService.GetList().Count() == 0)
                                {
                                    objMainModel.AlbumRank = 0;
                                }
                                else
                                {
                                    objMainModel.AlbumRank = galleryService.GetList().Max(x => x.AlbumRank) + 1;
                                }
                                objreturn = galleryService.AddOrUpdate(objMainModel, UserModel.Username);
                                objreturn.strMessage = "Record Created Successfully.";
                                objreturn.isError = false;
                                objreturn.type = PopupMessageType.success.ToString();
                                mdlGalleryFrontModel = new GalleryFormModel();
                            }
                            else if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update && objMainModel.Id != 0)
                            {
                                objMainModel.GallerymasterId = objModel.GallerymasterId.Value;
                                objMainModel.AlbumRank = galleryService.Get(objModel.GallerymasterId.Value).AlbumRank;
                                objreturn = galleryService.AddOrUpdate(objMainModel, UserModel.Username);
                                objreturn.strMessage = "Record updated Successfully.";
                                objreturn.isError = false;
                                objreturn.type = PopupMessageType.success.ToString();
                                mdlGalleryFrontModel = new GalleryFormModel();
                            }
                            else
                            {
                                objreturn.strMessage = "You Don't have Rights perform this action.";
                                objreturn.isError = true;
                                objreturn.type = PopupMessageType.error.ToString();
                            }
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

        public bool ValidGalleryData(GalleryFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool allow = false;
            try
            {
                if (!ValidControlValue(objModel.PlaceName, ControlInputType.none))
                {
                    if (ValidLength(objModel.PlaceName))
                    {
                        objreturn.strMessage = "Enter valid album name!";
                    }
                    else
                    {
                        objreturn.strMessage = "Enter album name!";
                    }
                }
                else if (mdlGalleryFrontModel.lstEventImagesMasterModels.Count == 0)
                {
                    objreturn.strMessage = "Please choose images!";
                    allow = false;
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
        private bool ValidateMainForm(ref GalleryFormModel objModel, ref JsonResponseModel objreturn)
        {
            bool isError = false;
            if (objModel == null)
            {
                objreturn.strMessage = "Form Input is not valid";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
                return true;
            }
            else if (string.IsNullOrWhiteSpace(objModel.PlaceName))
            {
                objreturn.strMessage = "Enter Event Place Name.";
                objreturn.isError = true;
                objreturn.type = PopupMessageType.error.ToString();
                return true;
            }
            else if (objModel.IsVideo)
            {

                if (objModel.ThumbImage != null)
                {
                    var image = (IFormFile)objModel.ThumbImage;

                    var data = (Functions.SaveFile(image, httpClientFactory, "Gallery", "", FileType.ImageVideoType, true)).Result;

                    if (data != null)
                    {
                        if (!data.isError)
                        {
                            objModel.ThumbImageName = data.result.Filename;
                            objModel.ThumbImagePath = (data.result.FilePath);

                        }
                        else
                        {
                            objreturn.strMessage = data.strMessage;
                            objreturn.isError = data.isError;
                            objreturn.type = PopupMessageType.error.ToString();
                            return true;
                        }
                    }
                    else
                    {
                        objreturn.strMessage = "File Save Error so Please try again.";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                        return true;
                    }
                }
                else if (!String.IsNullOrWhiteSpace(objModel.ThumbImagePath) && !String.IsNullOrWhiteSpace(objModel.ThumbImageName))
                {
                    objModel.ThumbImageName = objModel.ThumbImageName;
                    objModel.ThumbImagePath = (objModel.ThumbImagePath);
                }
                else
                {
                    objreturn.strMessage = "This Album Need Thumbnail.";
                    objreturn.isError = true;
                    objreturn.type = PopupMessageType.error.ToString();
                    return true;
                }
            }
            //if (string.IsNullOrWhiteSpace(objModel.GalleryTargetAudiences))
            //{
            //    objreturn.strMessage = "Please Select At least One TargetAudiences.";
            //    objreturn.isError = true;
            //    objreturn.type = PopupMessageType.error.ToString();
            //    return true;
            //}
            return isError;
        }

        #endregion

        #region Sub Image/Video

        [HttpPost]
        [Route("/Admin/GetGallaryImageData")]
        public JsonResult GetGallaryImageData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();

            try
            {
                GalleryFormModel objData = new GalleryFormModel();

                List<EventImageModel> lstMainData = new List<EventImageModel>();

                if (mdlGalleryFrontModel == null)
                {
                    objData = new GalleryFormModel();
                    mdlGalleryFrontModel = objData;
                }
                if (mdlGalleryFrontModel.lstEventImagesMasterModels == null)
                {
                    objData.lstEventImagesMasterModels = lstMainData;
                    mdlGalleryFrontModel = objData;
                }
                objData = mdlGalleryFrontModel;

                var lsdata = mdlGalleryFrontModel.lstEventImagesMasterModels;

                return Json(new { draw = draw, recordsFiltered = lsdata.Count(), recordsTotal = lsdata.Count(), data = lsdata });
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }

        }

        [Route("/Admin/GetGallaryImageVideoDetails")]
        [HttpPost]
        public JsonResult GetGallaryImageVideoDetails(string id)
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
                    var data = mdlGalleryFrontModel.lstEventImagesMasterModels[(int)lgid - 1];
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

        [Route("/Admin/DeleteGallaryImageData")]
        [HttpPost]
        public JsonResult DeleteGallaryImageData(string id)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Delete)
                    {
                        var maindata = mdlGalleryFrontModel;

                        var data = maindata.lstEventImagesMasterModels[((int)lgid - 1)];

                        maindata.lstEventImagesMasterModels.Remove(data);

                        int i = 1;

                        maindata.lstEventImagesMasterModels.ForEach(x =>
                        {
                            x.RowIndex = i;
                            i++;
                        });

                        mdlGalleryFrontModel = maindata;


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

        [Route("/Admin/SaveGalleryImageData")]
        [DisableRequestSizeLimit]
        [RequestFormLimits(ValueLengthLimit = int.MaxValue, MultipartBodyLengthLimit = long.MaxValue)]
        [HttpPost]
        public async Task<JsonResult> SaveGalleryImageData([FromForm] EventImageModel objModel)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (ModelState.IsValid)
                {
                    List<EventImageModel> lstData = new List<EventImageModel>();
                    if (mdlGalleryFrontModel == null)
                    {
                        mdlGalleryFrontModel = new GalleryFormModel();
                    }
                    if (mdlGalleryFrontModel.lstEventImagesMasterModels == null)
                    {
                        mdlGalleryFrontModel.lstEventImagesMasterModels = new List<EventImageModel>();
                    }
                    else
                    {
                        lstData = mdlGalleryFrontModel.lstEventImagesMasterModels;
                    }
                    EventImageModel objBo = new EventImageModel();
                    if (objModel.Image.Count() != null)
                    {
                        if (objModel.Image.Count() > 0)
                        {
                            string strFileName = ""; int countVIdeo = 0;
                            foreach (IFormFile image in objModel.Image)
                            {
                                {

                                    if (!Functions.ValidateFileExtention(System.IO.Path.GetExtension(image.FileName).Replace(".", "").ToUpper(), FileType.ImageType))
                                    {
                                        strFileName += $" File => {image.FileName} is not a valid image file.";
                                    }
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

                                var data = (await Functions.SaveFile(image, httpClientFactory, "Gallery", "", FileType.ImageType, true));

                                if (data != null)
                                {
                                    if (!data.isError)
                                    {
                                        objModel.ImageName = data.result.Filename;
                                        objModel.ImagePath = (data.result.FilePath);

                                        if (lstData == null)
                                        {
                                            lstData = new List<EventImageModel>();
                                        }
                                        if (objModel.RowIndex.ToString() == "0" && objModel.Command == "0")
                                        {
                                            objBo = new EventImageModel();
                                            objBo.RowIndex = objModel.RowIndex;
                                            objBo.ImagePath = objModel.ImagePath;
                                            objBo.ImageName = objModel.ImageName;
                                        }
                                        else
                                        {
                                            objBo = lstData.Where((i, x) => i.RowIndex == objModel.RowIndex).FirstOrDefault();
                                            objBo.ImagePath = objModel.ImagePath;
                                            objBo.ImageName = objModel.ImageName;
                                        }

                                        bool isInsert = Common.Functions.GetPageRightsCheck(HttpContext.Session).Insert;
                                        bool isUpdate = Common.Functions.GetPageRightsCheck(HttpContext.Session).Update;
                                        if (objModel.RowIndex == 0 && objModel.Command == "0" && isInsert)
                                        {
                                            lstData.Add(objBo);
                                        }
                                        else if (isUpdate && objModel.Command != "0")
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
                                        return Json(data);
                                    }
                                }
                                else
                                {
                                    objreturn.strMessage = "File Save Error so Please try again.";
                                    objreturn.isError = true;
                                    objreturn.type = PopupMessageType.error.ToString();
                                    return Json(objreturn);
                                }
                            }
                        }
                    }
                    else
                    {
                        objreturn.strMessage = "Please Select File.";
                        objreturn.isError = true;
                        objreturn.type = PopupMessageType.error.ToString();
                        return Json(objreturn);

                    }

                    GalleryFormModel tabSubDetails = new GalleryFormModel();
                    tabSubDetails = mdlGalleryFrontModel;
                    tabSubDetails.lstEventImagesMasterModels = lstData;
                    int i = 1;

                    if (tabSubDetails.lstEventImagesMasterModels.Count() > 0)
                    {
                        tabSubDetails.lstEventImagesMasterModels.OrderBy(x => x.RowIndex).ToList().ForEach(x =>
                        {
                            x.RowIndex = i;
                            i++;
                        });
                    }

                    mdlGalleryFrontModel = tabSubDetails;
                    var dataSet = mdlGalleryFrontModel;

                    objreturn.isError = false;
                    objreturn.type = PopupMessageType.success.ToString();

                }
                else
                {
                    objreturn.strMessage = "Form Input is not valid";
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

        [Route("/Admin/UpdateGalleryStatus")]
        [HttpPost]
        public JsonResult UpdateGalleryStatus(string id, int isActive)
        {
            JsonResponseModel objreturn = new JsonResponseModel();
            try
            {
                if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(id), out long lgid))
                {
                    if (Common.Functions.GetPageRightsCheck(HttpContext.Session).Update)
                    {
                        objreturn = galleryService.UpdateStatus(lgid, UserModel.Username, isActive);
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
