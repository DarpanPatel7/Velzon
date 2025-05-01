using System.Data;
using System.Transactions;
using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;

namespace Velzon.Services.Service
{
    public class VideoService : IVideoService
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor
        // Initializes a new instance of the VideoServices class.
        public VideoService()
        {
            dapperConnection = new DapperConnection();
        }
        #endregion

        #region Public Method(s)
        // Retrieves a list of video models based on language IDs.
        public VideoModel Get(long id, long lgLangId)
        {
            try
            {
                var dataModel = GetList(lgLangId).Where(x => x.VideoId == id).FirstOrDefault();
                if (dataModel != null)
                {
                    Dictionary<string, object> dictionary = new Dictionary<string, object>();
                    dictionary.Add("pVideoMasterId", dataModel.VideoId);
                    var datalst = dapperConnection.GetListResult<VideoNameModel>("cmsGetAllVideoMasterUrls", CommandType.StoredProcedure, dictionary).ToList();
                    if (datalst != null)
                    {
                        dataModel.lstVideoModels = datalst;
                    }
                }
                return dataModel;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(" Error Into cmsGetAllVideoMaster, cmsGetAllVideoMasterUrls", ex.ToString(), "VideoMasterServices", "Get");
                return null;
            }
        }
        // Retrieves a list of video models for the front category based on language IDs.
        public List<VideoModel> GetList(long lgLangId)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pLangid", lgLangId);
                var data = dapperConnection.GetListResult<VideoModel>("cmsGetAllVideoMaster", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x =>
                {
                    x.Id = (long)x.VideoId;
                });
                return data;
            }

            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllVideoMaster", ex.ToString(), "VideoMasterServices", "GetList");
                return null;
            }
        }

        // Retrieves a list of video models for the front category based on domain and language IDs.
        public List<VideoModel> GetListFront(long lgLangId)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pLangId", lgLangId);
                var data = dapperConnection.GetListResult<VideoModel>("frontGetAllVideoMaster", CommandType.StoredProcedure, dictionary).ToList();

                return data;
            }

            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into frontGetAllVideoMaster", ex.ToString(), "VideoMasterServices", "GetListFront");
                return null;
            }
        }

        // Retrieves a list of video models for the front category based on domain and language IDs.
        public List<VideoModel> GetFrontcategory(long languageID)
        {
            try
            {

                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("planguageID", languageID);
                var data = dapperConnection.GetListResult<VideoModel>("FrontGetAllVideoFirstData", CommandType.StoredProcedure, dictionary).ToList();

                return data;
            }

            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into FrontGetAllVideoFirstData", ex.ToString(), "VideoMasterServices", "GetListFront");
                return null;
            }
        }


        // Retrieves a list of video models for the front category with detailed information.
        public List<VideoModel> GetFrontcategoryDetails(long id, long languageid)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("p_id", id);
                dictionary.Add("planguageid", languageid);
                var data = dapperConnection.GetListResult<VideoModel>("FrontGetAllAlbumvideos", CommandType.StoredProcedure, dictionary).ToList();
                return data;
            }

            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into FrontGetAllAlbumvideos", ex.ToString(), "VideoMasterServices", "GetListFront");
                return null;
            }
        }

        // Deletes a video model by its unique identifier and returns the result.
        public JsonResponseModel Delete(long id, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", id);
                dictionary.Add("pUsername", username);
                dapperConnection.GetListResult<VideoModel>("cmsRemoveVideoMaster", CommandType.StoredProcedure, dictionary).ToList();
                jsonResponseModel.strMessage = "Record deleted successfully.";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveVideoMaster", ex.ToString(), "VideoMasterServices", "Delete");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }
        // Adds or updates a video model based on the provided model.
        public JsonResponseModel AddOrUpdate(VideoModel model)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            using (var transactionScope = new TransactionScope())
            {
                try
                {
                    Dictionary<string, object> dictionary = new Dictionary<string, object>();
                    dictionary.Add("pId", model.Id);
                    dictionary.Add("pLanguageId", model.LanguageId);
                    dictionary.Add("pVideoId", model.VideoId);
                    dictionary.Add("pVideoTitle", model.VideoTitle);
                    dictionary.Add("pIsActive", model.IsActive);
                    dictionary.Add("pUsername", model.Username);

                    var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateVideoMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();
                    if (model.Id == 0)
                    {
                        jsonResponseModel.strMessage = "Record created successfully.";
                        jsonResponseModel.isError = false;
                        jsonResponseModel.type = PopupMessageType.success.ToString();
                    }
                    else
                    {
                        jsonResponseModel.strMessage = "Record updated successfully.";
                        jsonResponseModel.isError = false;
                        jsonResponseModel.type = PopupMessageType.success.ToString();
                    }
                    model.VideoId = (int)data;

                    if (model.lstVideoModels != null)
                    {

                        Dictionary<string, object> dictionaryRemove = new Dictionary<string, object>();
                        dictionaryRemove.Add("pVideoMasterId", model.VideoId);
                        dapperConnection.GetListResult<long>("cmsDeleteVideoMasterUrls", CommandType.StoredProcedure, dictionaryRemove).FirstOrDefault();

                        foreach (var item in model.lstVideoModels.ToList())
                        {
                            Dictionary<string, object> dictionarySub = new Dictionary<string, object>();
                            dictionarySub.Add("pVideoMasterId", model.VideoId);
                            dictionarySub.Add("pVideoName", item.VideoName);
                            dictionarySub.Add("pThumbImage", item.ThumbImage);
                            dictionarySub.Add("pVideoUrl", item.VideoUrl);
                            dictionarySub.Add("pislinkvideo", item.urllink);
                            dapperConnection.GetListResult<long>("cmsInsertVideoMasterUrls", CommandType.StoredProcedure, dictionarySub).FirstOrDefault();
                        }
                    }
                    transactionScope.Complete();
                }
                catch (Exception ex)
                {
                    ErrorLogger.Error("Error Into cmsInsertOrUpdateVideoMaster, cmsDeleteVideoMasterUrls, cmsInsertVideoMasterUrls", ex.ToString(), "VideoMasterServices", "AddOrUpdate");
                    jsonResponseModel.strMessage = ex.Message;
                    jsonResponseModel.isError = true;
                    jsonResponseModel.type = PopupMessageType.error.ToString();
                }
            }
            return jsonResponseModel;
        }

        public JsonResponseModel UpdateStatus(long id, string username, int isActive)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", id);
                dictionary.Add("pIsActive", isActive);
                dictionary.Add("pUsername", username);
                dapperConnection.GetListResult<UserMasterModel>("cmsUpdateStatusVideoMaster", CommandType.StoredProcedure, dictionary).ToList();

                jsonResponseModel.strMessage = "Record updated successfully!";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsUpdateStatusVideoMaster", ex.ToString(), "VideoMasterServices", "UpdateStatus");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        #endregion

        #region Disposing Method(s)
        private bool disposed;
        ~VideoService()
        {
            this.Dispose(false);
        }
        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                }
            }
            disposed = true;
        }
        #endregion

    }

}
