using Velzon.Common;
using Velzon.Webs.Controllers;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Mvc;
using Velzon.Webs.Areas.Admin.Models;
using Velzon.IService.System;
using Velzon.Model.System;

namespace Velzon.Webs.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class SiteController : BaseController<SiteController>
    {
        #region Controller Variable

        private IHttpClientFactory httpClientFactory { get; set; }
        private ISiteService siteService { get; set; }

        #endregion

        #region Controller Constructor

        public SiteController(ISiteService _siteService, IHttpClientFactory _httpClientFactory)
        {
            this.httpClientFactory = _httpClientFactory;
            this.siteService = _siteService;
        }

        #endregion

        #region Public Methods

        [ServiceFilter(typeof(PageRightsFilter))]
        [Route("/Admin/SiteSettings")]
        public IActionResult SiteSettings()
        {
            SiteFormModel objSiteModel = new SiteFormModel();
            try
            {
                if (UserModel == null)
                {
                    return RedirectToAction("Logout", "Account");
                }
                else if (UserModel.Id <= 0)
                {
                    return RedirectToAction("Logout", "Account");
                }

                var siteModel = siteService.Get();
                if (siteModel != null)
                {
                    objSiteModel.SiteName = siteModel.SiteName;
                    objSiteModel.SiteFaviconWhite = siteModel.SiteFaviconWhite;
                    objSiteModel.SiteFaviconDark = siteModel.SiteFaviconDark;
                    objSiteModel.SiteLogoWhite = siteModel.SiteLogoWhite;
                    objSiteModel.SiteLogoDark = siteModel.SiteLogoDark;
                }

            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return RedirectToAction("Logout", "Account");
            }
            return View(objSiteModel);
        }

        [HttpPost]
        [Route("/Admin/ChangeSite")]
        public IActionResult ChangeSite(SiteFormModel objSiteModel)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    string strError = "";
                    if (ValidateSite(objSiteModel, out strError))
                    {
                        var siteModel = new SiteModel();
                        siteModel.SiteName = objSiteModel.SiteName;
                        siteModel.SiteFaviconWhite = objSiteModel.SiteFaviconWhite;
                        siteModel.SiteFaviconDark = objSiteModel.SiteFaviconDark;
                        siteModel.SiteLogoWhite = objSiteModel.SiteLogoWhite;
                        siteModel.SiteLogoDark = objSiteModel.SiteLogoDark;

                        if (siteService.InsertOrUpdate(siteModel, out strError))
                        {

                            var getSiteModel = siteService.Get();
                            if (siteModel != null)
                            {

                                objSiteModel.SiteName = getSiteModel.SiteName;
                                objSiteModel.SiteFaviconWhite = getSiteModel.SiteFaviconWhite;
                                objSiteModel.SiteFaviconDark = getSiteModel.SiteFaviconDark;
                                objSiteModel.SiteLogoWhite = getSiteModel.SiteLogoWhite;
                                objSiteModel.SiteLogoDark = getSiteModel.SiteLogoDark;

                            }

                            Functions.MessagePopup(this, "Site Setting Updated Successfully..", PopupMessageType.success);
                            return View(objSiteModel);
                        }
                        else
                        {
                            Functions.MessagePopup(this, strError, PopupMessageType.error);
                        }
                    }
                    else
                    {
                        Functions.MessagePopup(this, strError, PopupMessageType.error);
                        return View(objSiteModel);
                    }
                }
                else
                {
                    Functions.MessagePopup(this, "Form Details Are Not Valid.", PopupMessageType.error);
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), this.ControllerContext.ActionDescriptor.ControllerName, this.ControllerContext.ActionDescriptor.ActionName);
                return RedirectToAction("Logout", "Account");
            }
            return RedirectToAction("ChangeSite", "Home", new { area = "Admin" });
        }

        private bool ValidateSite(SiteFormModel objSiteModel, out string strError)
        {
            bool isError = true;
            strError = "";

            if (string.IsNullOrWhiteSpace(objSiteModel.SiteName))
            {
                strError = "Please enter site name";
                return false;
            }
            else
            {
                if (!ValidControlValue(objSiteModel.SiteName, ControlInputType.none))
                {
                    strError = "Invalid site name";
                    return false;
                }
            }

            /*if (string.IsNullOrWhiteSpace(objSiteModel.CouchDBDbName))
            {
                strError = "Please Enter CouchDB Name";
                return false;
            }
            else
            {
                if (!ValidControlValue(objSiteModel.CouchDBDbName, ControlInputType.text))
                {
                    strError = "Invalid CouchDB Name";
                    return false;
                }
            }

            if (string.IsNullOrWhiteSpace(objSiteModel.CouchDBUser))
            {
                strError = "Please Enter CouchDB User";
                return false;
            }
            else
            {
                if (!ValidControlValue(objSiteModel.CouchDBUser, ControlInputType.none))
                {
                    strError = "Invalid CouchDB User";
                    return false;
                }
            }*/

            return isError;
        }

        #endregion
    }
}
