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


    public JsonResponseModel SwapSequance(long rank, string dir, string username)
    {
        JsonResponseModel jsonResponseModel = new JsonResponseModel();

        using (var transactionScope = new TransactionScope())
        {
            try
            {
                var getDetails = GetList();

                ProjectModel masterModel = getDetails.Where(x => x.ProjectRank == rank).FirstOrDefault();

                var cuurentLevelList = getDetails.OrderBy(x => x.ProjectRank).ToList();

                long minValue = cuurentLevelList.Min(x => x.ProjectRank);
                long maxValue = cuurentLevelList.Max(x => x.ProjectRank);

                long updateRank = 0;

                if (dir == "up" && (rank - 1) < minValue)
                {
                    jsonResponseModel.strMessage = "This Menu already have min rank!";
                    jsonResponseModel.isError = true;
                    jsonResponseModel.type = PopupMessageType.error.ToString();
                }
                else if (dir == "down" && (rank + 1) > maxValue)
                {
                    jsonResponseModel.strMessage = "This Menu already have max rank!";
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
                        if (dir == "up" && cuurentLevel.item.ProjectRank == rank)
                        {
                            updateRank = indexList.Where(x => x.index == (cuurentLevel.index - 1)).FirstOrDefault().item.ProjectRank;
                            break;
                        }
                        else if (dir == "down" && cuurentLevel.item.ProjectRank == rank)
                        {
                            updateRank = indexList.Where(x => x.index == (cuurentLevel.index + 1)).FirstOrDefault().item.ProjectRank;
                            break;
                        }
                    }


                    ProjectModel masterupdateRankModel = getDetails.Where(x => x.ProjectRank == updateRank).FirstOrDefault();

                    if (masterModel != null && masterupdateRankModel != null)
                    {
                        masterModel.ProjectRank = updateRank;
                        masterupdateRankModel.ProjectRank = rank;
                        jsonResponseModel = AddOrUpdate(masterModel);
                        jsonResponseModel = AddOrUpdate(masterupdateRankModel);

                        jsonResponseModel.strMessage = "Data Swap Successfully";

                        transactionScope.Complete();
                    }
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into SwapSequance", ex.ToString(), "CMSMenuMasterService", "SwapSequance");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
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