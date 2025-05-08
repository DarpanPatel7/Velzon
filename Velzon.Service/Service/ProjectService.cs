using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using System.Data;
using System.Transactions;

namespace Velzon.Services.Service;

public class ProjectService : IProjectService
{
    public static DapperConnection dapperConnection;


    public ProjectService()
    {
        dapperConnection = new DapperConnection();
    }
    public JsonResponseModel AddOrUpdate(ProjectModel model)
    {
        JsonResponseModel jsonResponseModel = new JsonResponseModel();

        {
            try
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();
                dictionary.Add("pId", model.Id);
                dictionary.Add("pLanguageId", model.LanguageId);
                dictionary.Add("pProjectName", model.ProjectName);
                dictionary.Add("pDescription", model.Description);
                dictionary.Add("pProjectBy", model.ProjectBy);
                dictionary.Add("pProjectDate", model.ProjectDate);
                dictionary.Add("pIsActive", model.IsActive);
                dictionary.Add("pCreatedBy", model.CreatedBy);
                dictionary.Add("pUpdatedBy", model.UpdatedBy);
                dictionary.Add("pLocation", model.Location);
                dictionary.Add("pMetaTitle", model.MetaTitle);
                dictionary.Add("pMetaDescription", model.MetaDescription);

                dictionary.Add("FileName", model.FileUpload);
                dictionary.Add("FilePath", model.FilePath);

                var data = dapperConnection.GetListResult<int>("InsertOrUpdateProjectMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();
                if (model.Id == 0)
                {
                    jsonResponseModel.strMessage = "Record added successfully";
                    jsonResponseModel.isError = false;
                    jsonResponseModel.type = PopupMessageType.success.ToString();
                }
                else
                {
                    jsonResponseModel.strMessage = "Record updated successfully";
                    jsonResponseModel.isError = false;
                    jsonResponseModel.type = PopupMessageType.success.ToString();
                }
                model.Id = (int)data;



            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into InsertOrUpdateProjectMaster", ex.ToString(), "projectService", "AddOrUpdate");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
        }
        return jsonResponseModel;
    }

    public List<ProjectModel> GetList(long lgLangId = 1)
    {
        try
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("LangId", lgLangId);
            var data = dapperConnection.GetListResult<ProjectModel>("GetAllProjectMasterLanguageId", CommandType.StoredProcedure, dictionary).ToList();
            data.ForEach(x =>
            {
                x.Id = (long)x.ProjectMasterId;
            });
            return data;
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into GetAllProjectMasterLanguageId", ex.ToString(), "ProjectService", "GetList");
            return null;
        }
    }

    public ProjectModel Get(long id, long lgLangId = 1)
    {
        try
        {

            return GetList(lgLangId).Where(x => x.Id == id).FirstOrDefault();
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into GetAllProjectMasterLanguageId", ex.ToString(), "ProjectService", "Get");
            return null;
        }
    }

    public JsonResponseModel Delete(long id, string username)
    {
        JsonResponseModel jsonResponseModel = new JsonResponseModel();
        try
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("P_Id", id);
            dictionary.Add("Username", username);
            dapperConnection.GetListResult<AdminMenuMasterModel>("RemoveProjectMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

            jsonResponseModel.strMessage = "Record deleted successfully";
            jsonResponseModel.isError = false;
            jsonResponseModel.type = PopupMessageType.success.ToString();
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into RemoveProjectMaster", ex.ToString(), "ProjectService", "Delete");
            jsonResponseModel.strMessage = ex.Message;
            jsonResponseModel.isError = true;
            jsonResponseModel.type = PopupMessageType.error.ToString();
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
            dapperConnection.GetListResult<UserMasterModel>("cmsUpdateStatusProjectMaster", CommandType.StoredProcedure, dictionary).ToList();

            jsonResponseModel.strMessage = "Record updated successfully!";
            jsonResponseModel.isError = false;
            jsonResponseModel.type = PopupMessageType.success.ToString();
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into cmsUpdateStatusProjectMaster", ex.ToString(), "ProjectService", "UpdateStatus");
            jsonResponseModel.strMessage = ex.Message;
            jsonResponseModel.isError = true;
            jsonResponseModel.type = PopupMessageType.error.ToString();
        }
        return jsonResponseModel;
    }

    #region Disposing Method(s)
    private bool disposed;
    ~ProjectService()
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