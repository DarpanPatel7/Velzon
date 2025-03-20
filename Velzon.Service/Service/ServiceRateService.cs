using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using System.Data;
using System.Transactions;

namespace Velzon.Services.Service;

public class ServiceRateService : IServiceRateService
{
    #region Constants
    public static DapperConnection dapperConnection;
    #endregion

    #region Constructor

    public ServiceRateService()
    {
        dapperConnection = new DapperConnection();
    }

    #endregion

    public ServiceRateModel Get(long id, long lgLangId = 1)
    {
        try
        {
            //throw new NotImplementedException();
            return GetList(lgLangId).Where(x => x.Id == id).FirstOrDefault();
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into cmsGetAllServiceRateMaster", ex.ToString(), "ServiceRateService", "Get");
            return null;
        }
    }

    public List<ServiceRateModel> GetList(long lgLangId = 1)
    {
        try
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("LangId", lgLangId);
            var data = dapperConnection.GetListResult<ServiceRateModel>("cmsGetAllServiceRateMaster", CommandType.StoredProcedure, dictionary).ToList();
            data.ForEach(x => {
                x.Id = (long)x.ServiceRateId;
            });
            return data;
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into cmsGetAllServiceRateMaster", ex.ToString(), "ServiceRateService", "GetList");
            return null;
        }
    }
    public List<ServiceRateModel> GetListFront(long lgLangId = 1)
    {
        try
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("LangId", lgLangId);
            var data = dapperConnection.GetListResult<ServiceRateModel>("frontGetAllServiceRateMaster", CommandType.StoredProcedure, dictionary).ToList();
            data.ForEach(x => {
                x.Id = (long)x.ServiceRateId;
            });
            return data;
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into frontGetAllServiceRateMaster", ex.ToString(), "ServiceRateService", "GetList");
            return null;
        }
    }

    public JsonResponseModel AddOrUpdate(ServiceRateModel model, string username)
    {
        JsonResponseModel jsonResponseModel = new JsonResponseModel();
        try
        {
            
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("pId", model.Id);
            dictionary.Add("pLanguageId", model.LanguageId);
            dictionary.Add("pServiceName", model.ServiceName);
            dictionary.Add("pShortDescription", model.ShortDescription);
            dictionary.Add("pServiceDescription", model.ServiceDescription);
            dictionary.Add("ImageName", model.ImageName);
            dictionary.Add("ImagePath", model.ImagePath);
            dictionary.Add("pIcon", model.Icon);
            dictionary.Add("pIsActive", model.IsActive);
            dictionary.Add("Username", username);
            dictionary.Add("pServiceRank", model.ServiceRank);
 

            var data = dapperConnection.GetListResult<long>("cmsInsertOrUpdateServiceRateMaster", CommandType.StoredProcedure, dictionary).FirstOrDefault();

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
            ErrorLogger.Error("Error Into cmsInsertOrUpdateServiceRateMaster", ex.ToString(), "ServiceRateService", "AddOrUpdate");
            jsonResponseModel.strMessage = ex.Message;
            jsonResponseModel.isError = true;
            jsonResponseModel.type = PopupMessageType.error.ToString();
        }
        return jsonResponseModel;
    }

    public JsonResponseModel Delete(long id, string username)
    {
        JsonResponseModel jsonResponseModel = new JsonResponseModel();
        try
        {
            Dictionary<string, object> dictionary = new Dictionary<string, object>();
            dictionary.Add("Id", id);
            dictionary.Add("Username", username);
            dapperConnection.GetListResult<AdminMenuMasterModel>("cmsRemoveServiceRateMaster", CommandType.StoredProcedure, dictionary).ToList();

            jsonResponseModel.strMessage = "Record removed successfully!";
            jsonResponseModel.isError = false;
            jsonResponseModel.type = PopupMessageType.success.ToString();
        }
        catch (Exception ex)
        {
            ErrorLogger.Error("Error Into cmsRemoveServiceRateMaster", ex.ToString(), "ServiceRateService", "Delete");
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

                ServiceRateModel masterModel = getDetails.Where(x => x.ServiceRank == rank).FirstOrDefault();

                var cuurentLevelList = getDetails.OrderBy(x => x.ServiceRank).ToList();

                long minValue = cuurentLevelList.Min(x => x.ServiceRank);
                long maxValue = cuurentLevelList.Max(x => x.ServiceRank);

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
                        if (dir == "up" && cuurentLevel.item.ServiceRank == rank)
                        {
                            updateRank = indexList.Where(x => x.index == (cuurentLevel.index - 1)).FirstOrDefault().item.ServiceRank;
                            break;
                        }
                        else if (dir == "down" && cuurentLevel.item.ServiceRank == rank)
                        {
                            updateRank = indexList.Where(x => x.index == (cuurentLevel.index + 1)).FirstOrDefault().item.ServiceRank;
                            break;
                        }
                    }


                    ServiceRateModel masterupdateRankModel = getDetails.Where(x => x.ServiceRank == updateRank).FirstOrDefault();

                    if (masterModel != null && masterupdateRankModel != null)
                    {
                        masterModel.ServiceRank = updateRank;
                        masterupdateRankModel.ServiceRank = rank;
                        jsonResponseModel = AddOrUpdate(masterModel, masterModel.CreatedBy);
                        jsonResponseModel = AddOrUpdate(masterupdateRankModel, masterModel.CreatedBy);

                        jsonResponseModel.strMessage = "Data Swap Successfully";

                        transactionScope.Complete();
                    }
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error("Error Into SwapSequance", ex.ToString(), "ServiceRateService", "SwapSequance");
                jsonResponseModel.strMessage = ex.Message;
                jsonResponseModel.isError = true;
                jsonResponseModel.type = PopupMessageType.error.ToString();
            }
        }
        return jsonResponseModel;
    }

    #region Disposing Method(s)

    private bool disposed;

    /// <summary>
    /// Destructor
    /// </summary>
    ~ServiceRateService()
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
