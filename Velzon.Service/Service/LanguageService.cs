using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using System.Data;

namespace Velzon.Services.Service
{
    public class LanguageService : ILanguageService
    {
        #region Constants
        public static DapperConnection dapperConnection;
        #endregion

        #region Constructor
        public LanguageService()
        {
            dapperConnection = new DapperConnection();
        }
        #endregion

        #region Methods
        public LanguageMasterModel Get(long id)
        {
            try
            {
                //throw new NotImplementedException();
                return GetList().Where(x => x.Id == id).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllLanguage", ex.ToString(), "LanguageService", "Get");
                return null;
            }
        }
        public List<LanguageMasterModel> GetList()
        {
            try
            {
                var data = dapperConnection.GetListResult<LanguageMasterModel>("cmsGetAllLanguage", CommandType.StoredProcedure).ToList();
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetAllLanguage", ex.ToString(), "LanguageService", "GetList");
                return null;
            }
        }
        public List<LanguageMasterModel> GetListById(long id)
        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pid", id);
                var data = dapperConnection.GetListResult<LanguageMasterModel>("cmsGetLanguageById", CommandType.StoredProcedure, dictionary).ToList();
                data.ForEach(x =>
                {
                    x.Id = (long)x.Id;
                });
                return data;
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsGetLanguageById", ex.ToString(), "LanguageService", "GetList");
                return null;
            }
        }
        public JsonResponseModel AddorUpdate(LanguageMasterModel model, long userid)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {

                if (model.Id != 0)
                {
                    var dataModel = Get(model.Id);

                }
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pid", model.Id);
                dictionary.Add("pname", model.Name);
                dictionary.Add("puserid", userid);
                dictionary.Add("pisvisible", model.IsVisible);

                var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateLanguageMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

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
                ErrorLogger.Error("Error Into cmsInsertOrUpdateLanguageMaster", ex.ToString(), "LanguageService", "AddorUpdate");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }


        public JsonResponseModel Delete(long id, long userid)
        {
            JsonResponseModel jsonResponseModel = new JsonResponseModel();
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pid", id);
                dictionary.Add("pUserid", userid);
                JsonResponseModel resultList = dapperConnection.GetListResult<JsonResponseModel>("cmsRemoveLanguageMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

                if (resultList.isError != true)
                {
                    jsonResponseModel.strMessage = "Record removed successfully";
                    jsonResponseModel.isError = false;
                    jsonResponseModel.type = PopupMessageType.success.ToString();
                }
                else
                {
                    jsonResponseModel.strMessage = resultList.strMessage;
                    jsonResponseModel.isError = true;
                    jsonResponseModel.type = PopupMessageType.error.ToString();
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into cmsRemoveLanguageMaster", ex.ToString(), "LanguageService", "Delete");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
            return jsonResponseModel;
        }
#endregion

#region Disposing Method(s)

private bool disposed;

/// <summary>
/// Destructor
/// </summary>
~LanguageService()
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
