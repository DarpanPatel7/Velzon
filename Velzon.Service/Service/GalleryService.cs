using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using System.Data;
using System.Transactions;

namespace Velzon.Services.Service
{
    public class GalleryService : IGalleryService
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public GalleryService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public GalleryModel Get(long id, long lgLangId)
        {
            try
            {
                var dataModel = GetList(lgLangId).Where(x => x.GallerymasterId == id).FirstOrDefault();
                if (dataModel != null)
                {
                    Dictionary<string, object> dictionary = new Dictionary<string, object>();
                    dictionary.Add("pGalleryMasterId", id);
                    var datalst = dapperConnection.GetListResult<GalleryImagesModel>("cmsGetAllGalleryImages", CommandType.StoredProcedure, dictionary).ToList();
                    if (datalst != null)
                    {
                        dataModel.lstGalleryImagesModels = datalst;
                    }
                }
                return dataModel;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllGalleryMaster,cmsGetAllGalleryImages", ex.ToString(), "GalleryService", "Get");
                return null;
            }
        }

        public List<GalleryModel> GetList(long lgLangId = 1)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("LangId", lgLangId);
                var data = dapperConnection.GetListResult<GalleryModel>("cmsGetAllGalleryMaster", CommandType.StoredProcedure, dictionary).ToList();

                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllGalleryMaster", ex.ToString(), "GalleryService", "GetList");
                return null;
            }
        }

        public GalleryModel GetMenuRes(long id, long lgLangId)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList(lgLangId).Where(x => x.GallerymasterId == id).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllGalleryMaster", ex.ToString(), "GalleryService", "Get");
                return null;
            }
        }

        public List<AlbumModel> GetAlbum(long langid)
        {
            try
            {
                List<AlbumModel> dataMain = new List<AlbumModel>();
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("LangId", langid);
                var data = dapperConnection.GetListResult<AlbumModel>("cmsGetAllAlbumFirstData", CommandType.StoredProcedure, dictionary).ToList();
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllAlbumFirstData", ex.ToString(), "GalleryService", "GetAlbum");
                return null;
            }
        }

        public List<GalleryImagesModel> GetAlbumImages(long id, long languageid)
        {
            try
            {
                List<GalleryImagesModel> dataMain = new List<GalleryImagesModel>();
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("p_id", id);
                dictionary.Add("planguageid", languageid);
                var data = dapperConnection.GetListResult<GalleryImagesModel>("cmsGetAllAlbumImages", CommandType.StoredProcedure, dictionary).ToList();
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllAlbumImages", ex.ToString(), "GalleryService", "GetAlbumImages");
                return null;
            }
        }

        public JsonResponseModel AddOrUpdate(GalleryModel model, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            using (var transactionScope = new TransactionScope())
            {
                try
                {
                    Dictionary<string, object> dictionary = new Dictionary<string, object>();
                    dictionary.Add("pId", model.Id);
                    dictionary.Add("pGallerymasterId", model.GallerymasterId);
                    dictionary.Add("pLanguageId", model.LanguageId);
                    dictionary.Add("pPlaceName", model.PlaceName);
                    dictionary.Add("pThumbImageName", model.ThumbImageName);
                    dictionary.Add("pThumbImagePath", model.ThumbImagePath);
                    dictionary.Add("pIsVideo", model.IsVideo);
                    dictionary.Add("pIsActive", model.IsActive);
                    dictionary.Add("pUsername", username);
                    dictionary.Add("pAlbumRank", model.AlbumRank);

                    var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateGalleryMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                    if (model.Id == 0)
                    {
                        model.GallerymasterId = (long)data;
                        jsonResponseModel.strMessage = "Record inserted successfully";
                        jsonResponseModel.isError = false;
                        jsonResponseModel.type = PopupMessageType.success.ToString();
                    }
                    else
                    {
                        jsonResponseModel.strMessage = "Record updated successfully";
                        jsonResponseModel.isError = false;
                        jsonResponseModel.type = PopupMessageType.success.ToString();
                    }
                    model.Id = (long)data;

                    if (model.lstGalleryImagesModels != null)
                    {

                        Dictionary<string, object> dictionaryRemove = new Dictionary<string, object>();
                        dictionaryRemove.Add("pGalleryMasterId", model.GallerymasterId);
                        dapperConnection.GetListResult<long>("cmsRemoveGalleryImages", CommandType.StoredProcedure, dictionaryRemove).FirstOrDefault();

                        foreach (var item in model.lstGalleryImagesModels.ToList())
                        {
                            Dictionary<string, object> dictionarySub = new Dictionary<string, object>();
                            dictionarySub.Add("pGalleryMasterId", model.GallerymasterId);
                            dictionarySub.Add("pImageName", item.ImageName);
                            dictionarySub.Add("pImagePath", item.ImagePath);

                            dapperConnection.GetListResult<long>("cmsInsertGalleryImages", CommandType.StoredProcedure, dictionarySub).FirstOrDefault();
                        }
                    }

                    transactionScope.Complete();
                }
                catch (Exception ex)
                {
                    ErrorLogger.Error("Error Into cmsInsertOrUpdateGalleryMaster,cmsRemoveGalleryImages,cmsInsertGalleryImages", ex.ToString(), "GalleryService", "AddOrUpdate");
                    jsonResponseModel.strMessage = ex.Message;
                    jsonResponseModel.isError = true;
                    jsonResponseModel.type = PopupMessageType.error.ToString();
                }
            }
            return jsonResponseModel;
        }

        public JsonResponseModel Delete(long id, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", id);
                dictionary.Add("pUsername", username);
                dapperConnection.GetListResult<AdminMenuMasterModel>("cmsRemoveGalleryMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                jsonResponseModel.strMessage = "Record removed successfully";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveGalleryMaster", ex.ToString(), "GalleryService", "Delete");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel SwapSequance(long rank, string dir, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();

            using (var transactionScope = new TransactionScope())
            {
                try
                {
                    var getDetails = GetList();

                    GalleryModel masterModel = getDetails.Where(x => x.AlbumRank == rank).FirstOrDefault();

                    var cuurentLevelList = getDetails.OrderBy(x => x.AlbumRank).ToList();

                    long minValue = cuurentLevelList.Min(x => x.AlbumRank);
                    long maxValue = cuurentLevelList.Max(x => x.AlbumRank);

                    long updateRank = 0;

                    if (dir == "up" && (rank - 1) < minValue)
                    {
                        jsonResponseModel.strMessage = "This  already have min rank!";
                        jsonResponseModel.isError = true;
                        jsonResponseModel.type = PopupMessageType.error.ToString();
                    }
                    else if (dir == "down" && (rank + 1) > maxValue)
                    {
                        jsonResponseModel.strMessage = "This  already have max rank!";
                        jsonResponseModel.isError = true;
                        jsonResponseModel.type = PopupMessageType.error.ToString();
                    }
                    else
                    {
                        var indexList = cuurentLevelList.Select((x, i) => new
                        {
                            item = x,
                            index = i
                        }).ToList();

                        foreach (var cuurentLevel in indexList)
                        {
                            if (dir == "up" && cuurentLevel.item.AlbumRank == rank)
                            {
                                updateRank = indexList.Where(x => x.index == (cuurentLevel.index - 1)).FirstOrDefault().item.AlbumRank;
                                break;
                            }
                            else if (dir == "down" && cuurentLevel.item.AlbumRank == rank)
                            {
                                updateRank = indexList.Where(x => x.index == (cuurentLevel.index + 1)).FirstOrDefault().item.AlbumRank;
                                break;
                            }
                        }


                        GalleryModel masterupdateRankModel = getDetails.Where(x => x.AlbumRank == updateRank).FirstOrDefault();

                        if (masterModel != null && masterupdateRankModel != null)
                        {
                            masterModel.AlbumRank = updateRank;
                            masterupdateRankModel.AlbumRank = rank;
                            jsonResponseModel = AddOrUpdate(masterModel, masterModel.CreateBy);
                            jsonResponseModel = AddOrUpdate(masterupdateRankModel, masterModel.CreateBy);

                            jsonResponseModel.strMessage = "Data Swap Successfully";

                            transactionScope.Complete();
                        }
                    }

                }
                catch (Exception ex)
                {
                    ErrorLogger.Error("Error Into SwapSequance", ex.ToString(), "GalleryService", "SwapSequance");
                    jsonResponseModel.strMessage = ex.Message;
                    jsonResponseModel.isError = true;
                    jsonResponseModel.type = PopupMessageType.error.ToString();
                }
            }
            return jsonResponseModel;
        }

        #endregion

        #region Disposing Method(s)

        private bool disposed;

        /// <summary>
        /// Destructor
        /// </summary>
        ~GalleryService()
        {
            this.Dispose(false);
        }

        /// <summary>
        /// The dispose method that implements IDisposable.
        /// </summary>
        public void Dispose()
        {
            this.Dispose(true);
            GC.SuppressFinalize(this);
        }

        /// <summary>
        /// The virtual dispose method that allows
        /// classes inherithed from this one to dispose their resources.
        /// </summary>
        /// <param name="disposing"></param>
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    // Dispose managed resources here.
                }

                // Dispose unmanaged resources here.
            }

            disposed = true;
        }

        #endregion
    }
}

