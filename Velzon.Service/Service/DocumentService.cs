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

namespace Velzon.Services.Service
{
    public class DocumentService: IDocumentServices
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor

        public DocumentService()
        {
            dapperConnection = new DapperConnection();
        }


        #endregion

        public DocumentModel Get(long Id, long lgLangId = 1)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList(lgLangId).Where(x => x.Doc_Id == Id).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllDocumentMaster", ex.ToString(), "DocumentService", "Get");
                return null;
            }
        }

        public List<DocumentModel> GetList(long lgLangId = 1)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pLanguageId", lgLangId);
                var data = dapperConnection.GetListResult<DocumentModel>("cmsGetAllDocumentMaster", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x => {
                    x.Doc_Id = (long)x.Doc_Id;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllDocumentMaster", ex.ToString(), "DocumentService", "GetList");
                return null;
            }
        }

        public List<DocumentModel> GetFeesDoc(long lgLangId = 1)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pLanguageId", lgLangId);
                var data = dapperConnection.GetListResult<DocumentModel>("cmsGetFeesDocument", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x => {
                    x.Doc_Id = (long)x.Doc_Id;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetFeesDocument", ex.ToString(), "DocumentService", "GetFeesDoc");
                return null;
            }
        }

        public JsonResponseModel Delete(long Doc_Id, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pDoc_Id", Doc_Id);
                dictionary.Add("pUsername", username);
                dapperConnection.GetListResult<AdminMenuMasterModel>("cmsRemoveDocumentMaster", CommandType.StoredProcedure, dictionary).ToList();

                jsonResponseModel.strMessage = "Record removed successfully";
                jsonResponseModel.isError = false;
                jsonResponseModel.type = PopupMessageType.success.ToString();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveDocumentMaster", ex.ToString(), "DocumentService", "Delete");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        public JsonResponseModel AddOrUpdate(DocumentModel model, string username)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                if (model.Doc_Id != 0)
                {
                    var dataModel = Get(model.Doc_Id);
                }
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pDoc_Id", model.Doc_Id);               
                dictionary.Add("pDoc_Name", model.Doc_Name);
                dictionary.Add("pFile_Name", model.File_Name);
                dictionary.Add("pDoc_Path", model.Doc_Path);
                dictionary.Add("pLanguageId", model.LanguageId);  
                dictionary.Add("pIsActive", model.IsActive);
                dictionary.Add("pUsername", username);

                var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateDocumentMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (model.Doc_Id == 0)
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
                model.Doc_Id = (long)data;

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsInsertOrUpdateDocumentMaster", ex.ToString(), "DocumentService", "AddOrUpdate");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }

        #region Disposing Method(s)

        private bool disposed;

        /// <summary>
        /// Destructor
        /// </summary>
        ~DocumentService()
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

