using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Velzon.Services.Service
{
    public class CMSMenuResourceMasterService : ICMSMenuResourceMasterService
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public CMSMenuResourceMasterService()
        {
            dapperConnection = new DapperConnection();
        }

        #endregion

        #region Public Method(s)

        public CMSMenuResourceModel Get(long id, long lgLangId = 1)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList(lgLangId).Where(x => x.Id == id).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllCMSMenuResourceMaster", ex.ToString(), "CMSMenuResourceMasterService", "Get");
                return null;
            }
        }

        public CMSMenuResourceModel GetMenuRes(long menuResid, long lgLangId = 1)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList(lgLangId).Where(x => x.CMSMenuResId == menuResid).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllCMSMenuResourceMaster", ex.ToString(), "CMSMenuResourceMasterService", "Get");
                return null;
            }
        }

        public List<CMSMenuResourceModel> GetList(long lgLangId = 1)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("LangId", lgLangId);
                var data = dapperConnection.GetListResult<CMSMenuResourceModel>("cmsGetAllCMSMenuResourceMaster", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x => {
                    x.Id = (long)x.Id;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllCMSMenuResourceMaster", ex.ToString(), "CMSMenuResourceMasterService", "GetList");
                return null;
            }
        }

        public List<CMSMenuResourceModel> GetListFront(long lgLangId = 1)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("LangId", lgLangId);
                var data = dapperConnection.GetListResult<CMSMenuResourceModel>("frontGetAllCMSMenuResourceMaster", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x => {
                    x.Id = (long)x.Id;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into frontGetAllCMSMenuResourceMaster", ex.ToString(), "CMSMenuResourceMasterService", "GetListFront");
                return null;
            }
        }

        public List<CMSMenuResourceModel> GetListMaster()
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                //dictionary.Add("LangId", lgLangId);
                var data = dapperConnection.GetListResult<CMSMenuResourceModel>("cmsGetAllCMSMenuResourceMasterRank", CommandType.StoredProcedure, dictionary).ToList();
                /*data.ForEach(x => {
                    x.Id = (long)x.Id;
                });*/
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllCMSMenuResourceMasterRank", ex.ToString(), "CMSMenuResourceMasterService", "GetListMaster");
                return null;
            }
        }

        public List<CMSMenuResourceModel> GetParentList(long? lgLangId = 1)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("p_Languageid", lgLangId);
                var data = dapperConnection.GetListResult<CMSMenuResourceModel>("cmstbl_Menu_SelectAll", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x => {
                    x.Id = (long)x.Id;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmstbl_Menu_SelectAll", ex.ToString(), "CMSMenuResourceMasterService", "GetList");
                return null;
            }
        }

        public JsonResponseModel Delete(long id, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", id);
                dictionary.Add("Username", username);
                dapperConnection.GetListResult<CMSMenuResourceModel>("cmsRemoveCMSMenuResourceMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                jsonResponseModel.strMessage = "Record removed successfully";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveCMSMenuResourceMaster", ex.ToString(), "CMSMenuResourceMasterService", "Delete");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel SwapSequance(long rank, string dir, string username, string type, long parentid)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();

            using (var transactionScope = new TransactionScope())
            {
                try
                {
                    var getDetails = GetListMaster();
                    CMSMenuResourceModel masterModel = getDetails.Where(x => x.MenuRank == rank).FirstOrDefault();
                    var cuurentLevelList = getDetails.OrderBy(x => x.MenuRank);
                    if (type == "ParentMenu")
                    {
                        cuurentLevelList = getDetails.Where(x => x.col_parent_id == 0).Where(x => x.col_menu_type == "0").Where(x => x.DeletedDate is null).OrderBy(x => x.MenuRank);
                    }
                    else
                    {
                        cuurentLevelList = getDetails.Where(x => x.col_parent_id == parentid).Where(x => x.DeletedDate is null).OrderBy(x => x.MenuRank);
                    }
                    long minValue = cuurentLevelList.Min(x => x.MenuRank);
                    long maxValue = cuurentLevelList.Max(x => x.MenuRank);

                    long updateRank = 0;

                    if (dir == "up" && (rank - 1) < minValue)
                    {
                        if (type == "ParentMenu")
                        {
                            jsonResponseModel.strMessage = "This Parent Menu already have min rank!";
                        }
                        else if (type == "ChildMenu")
                        {
                            jsonResponseModel.strMessage = "This Child Menu already have min rank!";
                        }
                        else
                        {
                            jsonResponseModel.strMessage = "This Menu already have min rank!";
                        }
                        jsonResponseModel.isError = true;
                        jsonResponseModel.type = PopupMessageType.error.ToString();
                    }
                    else if (dir == "down" && (rank + 1) > maxValue)
                    {
                        if (type == "ParentMenu")
                        {
                            jsonResponseModel.strMessage = "This Parent Menu already have max rank!";
                        }
                        else if (type == "ChildMenu")
                        {
                            jsonResponseModel.strMessage = "This Child Menu already have max rank!";
                        }
                        else
                        {
                            jsonResponseModel.strMessage = "This Menu already have max rank!";
                        }
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
                            if (dir == "up" && cuurentLevel.item.MenuRank == rank)
                            {
                                updateRank = indexList.Where(x => x.index == (cuurentLevel.index - 1)).FirstOrDefault().item.MenuRank;
                                break;
                            }
                            else if (dir == "down" && cuurentLevel.item.MenuRank == rank)
                            {
                                updateRank = indexList.Where(x => x.index == (cuurentLevel.index + 1)).FirstOrDefault().item.MenuRank;
                                break;
                            }
                        }

                        CMSMenuResourceModel masterupdateRankModel = getDetails.Where(x => x.MenuRank == updateRank).FirstOrDefault();

                        if (masterModel != null && masterupdateRankModel != null)
                        {
                            masterModel.MenuRank = updateRank;
                            masterupdateRankModel.MenuRank = rank;
                            jsonResponseModel = UpdateSwap(masterModel, masterModel.CreatedBy);
                            jsonResponseModel = UpdateSwap(masterupdateRankModel, masterModel.CreatedBy);

                            jsonResponseModel.strMessage = "Data Swap Successfully";

                            transactionScope.Complete();
                        }
                    }

                }
                catch (Exception ex)
                {
                    ErrorLogger.Error("Error Into SwapSequance", ex.ToString(), "CMSMenuResourceMasterService", "SwapSequance");
                    jsonResponseModel.strMessage = ex.Message;
                    jsonResponseModel.isError = true;
                    jsonResponseModel.type = PopupMessageType.error.ToString();
                }
            }
            return jsonResponseModel;
        }

        public JsonResponseModel UpdateSwap(CMSMenuResourceModel model, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {

                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("Id", model.Id);
                dictionary.Add("MenuRank", model.MenuRank);
                dictionary.Add("username", username);

                var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateCMSMenuResourceMasterSwap", CommandType.StoredProcedure, dictionary).FirstOrDefault();


                jsonResponseModel.strMessage = "Record updated successfully";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();


                model.Id = (long)data;

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsInsertOrUpdateCMSMenuResourceMasterSwap", ex.ToString(), "CMSMenuResourceMasterService", "UpdateSwap");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel AddOrUpdate(CMSMenuResourceModel model, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                if (string.IsNullOrWhiteSpace(model.BannerImagePath))
                {
                    model.BannerImagePath = "";
                }
                if (model.Id != 0)
                {
                    var dataModel = Get(model.Id);
                    if (dataModel != null)
                    {
                        if (string.IsNullOrWhiteSpace(model.BannerImagePath))
                        {
                            model.BannerImagePath = dataModel.BannerImagePath;
                        }
                    }
                }
                if (string.IsNullOrWhiteSpace(model.IconImagePath))
                {
                    model.IconImagePath = "";
                }
                if (model.Id != 0)
                {
                    var dataModel = Get(model.Id);
                    if (dataModel != null)
                    {
                        if (string.IsNullOrWhiteSpace(model.IconImagePath))
                        {
                            model.IconImagePath = dataModel.IconImagePath;
                        }
                    }
                }
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("P_Id", model.Id);
                dictionary.Add("pLanguageId", model.LanguageId);
                dictionary.Add("pMenuName", model.MenuName);
                dictionary.Add("pMenuURL", model.MenuURL);
                dictionary.Add("pTooltip", model.Tooltip);
                dictionary.Add("pResourceType", model.ResourceType);
                dictionary.Add("pPageDescription", model.PageDescription);
                dictionary.Add("pTemplateId", model.TemplateId);
                dictionary.Add("pIsActive", model.IsActive);
                dictionary.Add("pIsRedirect", model.IsRedirect);
                dictionary.Add("pIsFullScreen", model.IsFullScreen);
                dictionary.Add("pcol_menu_type", model.col_menu_type);
                dictionary.Add("pcol_parent_id", model.col_parent_id);
                dictionary.Add("MenuRank", model.MenuRank);
                dictionary.Add("pMetaTitle", model.MetaTitle);
                dictionary.Add("pMetaDescription", model.MetaDescription);
                dictionary.Add("pUsername", username);
                dictionary.Add("pBannerImagePath", model.BannerImagePath);
                dictionary.Add("pIconImagePath", model.IconImagePath);

                var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateCMSMenuResourceMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (model.Id == 0)
                {
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

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsInsertOrUpdateCMSMenuResourceMaster", ex.ToString(), "CMSMenuResourceMasterService", "AddOrUpdate");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public CMSMenuResourceModel PageDeails(long Id)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("p_pageid", Id);
                var data = dapperConnection.GetListResult<CMSMenuResourceModel>("cmsGetPageDataFromPageName", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                return data;

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetPageDataFromPageName", ex.ToString(), "CMSMenuResourceMasterService", "PageDeails");
                return null;
            }
        }
        #endregion

        #region Disposing Method(s)

        private bool disposed;

        /// <summary>
        /// Destructor
        /// </summary>
        ~CMSMenuResourceMasterService()
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

