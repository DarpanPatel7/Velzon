using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Velzon.Model.System;
using Microsoft.AspNetCore.Mvc;

namespace Velzon.Webs.Controllers;

public class ServiceRateController : Controller
{
    protected readonly IServiceRateService serviceRateService;
    public long LanguageId
    {
        get
        {
            long Lang = 1;
            if (SessionWrapper.Get<long>(this.HttpContext.Session, "LanguageId") == null || SessionWrapper.Get<long>(this.HttpContext.Session, "LanguageId") == 0)
            {
                SessionWrapper.Set<long>(this.HttpContext.Session, "LanguageId", 1);
                Lang = 1;
            }
            else
            {
                Lang = SessionWrapper.Get<long>(this.HttpContext.Session, "LanguageId");
            }
            return Lang;
        }
        set { SessionWrapper.Set<long>(this.HttpContext.Session, "LanguageId", value); }
    }
    public IActionResult Index()
    {
        return View();
    }

    public ServiceRateController(IServiceRateService serviceRateService)
    {
        this.serviceRateService = serviceRateService;


    }

    [Route("GetServiceRateList")]
    public async Task<JsonResult> GetServiceRateList()
    {
        JsonResponseModel objreturn = new JsonResponseModel();
        try
        {
            List<ServiceRateModel> serviceRateModels = serviceRateService.GetList(LanguageId).ToList();

            if (serviceRateModels.Count() == 0)
            {
                serviceRateModels = serviceRateService.GetList(1).ToList();
            }
            if (serviceRateModels.Count() > 0)
            {
                objreturn.result = serviceRateModels.Where(x => x.IsActive == true);
                objreturn.isError = false;
            }

            else
            {
                objreturn.isError = false;
               
            }
        }
        catch (Exception ex)
        {
            ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);
            objreturn.strMessage = "Record not Found, Try again";
            objreturn.isError = true;
            objreturn.type = PopupMessageType.error.ToString();
        }

        return Json(objreturn);
    }

    [Route("/GetServiceDetailById")]
    public JsonResult GetAllServiceImagesById(string serviceMasterId)
    {
        JsonResponseModel objreturn = new JsonResponseModel();
        try
        {
            if (long.TryParse(Velzon.Common.Functions.FrontDecrypt(serviceMasterId), out long lgid))
            {

                List<ServiceRateModel> serviceRateModels = serviceRateService.GetList(LanguageId).ToList();

                if (serviceRateModels.Count() == 0)
                {
                    serviceRateModels = serviceRateService.GetList(1).ToList();
                }
                if (serviceRateModels.Count() > 0)
                {
                    objreturn.result = serviceRateModels.Where(x => x.IsActive == true && x.ServiceRateId == lgid);
                    objreturn.isError = false;
                }
                else
                {
                    objreturn.isError = false;
                }
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

}