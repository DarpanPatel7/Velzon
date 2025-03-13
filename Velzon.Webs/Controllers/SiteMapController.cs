using Velzon.Common;
using Velzon.IService.Service;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;
using Velzon.Model.System;
using System.Text;

namespace Velzon.Webs.Controllers
{
    public class SiteMapController : Controller
    {
        #region Controller Variable

        protected readonly ICMSMenuResourceMasterService objMenuResourceMasterService;

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

        #endregion

        #region Controller Constructor

        public SiteMapController(IHttpClientFactory _httpClientFactory, ICMSMenuResourceMasterService _CMSMenuResourceMasterService)
        {
            objMenuResourceMasterService = _CMSMenuResourceMasterService;
        }

        #endregion

        #region Controller Methods
        [HttpPost]
        [Route("/BindSiteMap")]
        public JsonResult BindSiteMap(int lgLanguageId)
        {
            StringBuilder stringBuilder = new StringBuilder();
            StringBuilder innerPageBuilder = new StringBuilder(); // Separate builder for InnerPage
            innerPageBuilder.Append("<div class=\"col-lg-4 col-md-6 col-sm-12 col-12 mb-30 sitemapDiv OtherSiteMap\">");
            innerPageBuilder.Append("<h5 class=\"sitemapTitle\"><a href=\"#\">Other SiteMap</a></h5>");
            innerPageBuilder.Append("<ul class=\"custome\">");
            bool hasInnerPage = false; // Flag to check if any InnerPage items exist
            List<CMSMenuResourceModel> cmsMenuMasterModels = new List<CMSMenuResourceModel>();
            try
            {
                var lsdata = objMenuResourceMasterService.GetList(lgLanguageId).ToList();
                if (lsdata != null)
                {

                    lsdata.ForEach(x =>
                    {
                        var mainMenu = Enum.GetValues(typeof(CMSMenuType)).Cast<CMSMenuType>().Select(d => new ListItem { Text = d.ToString(), Value = ((int)d).ToString() }).Where(y => y.Value == x.col_menu_type).FirstOrDefault();
                        x.col_menu_type = mainMenu.Text;
                    });
                    var parentList = lsdata.Where(x => x.col_parent_id == 0).OrderBy(x => x.col_parent_id).ThenBy(n => n.MenuRank).OrderByDescending(x => x.col_menu_type).ToList();
                    if (parentList.Count() > 0)
                    {
                        foreach (var item in parentList.ToList())
                        {
                            if (item.MenuName != "Home")
                            {
                                if (item.col_menu_type != "InnerPage")
                                {
                                    stringBuilder.Append("<div class=\"col-lg-4 col-md-6 col-sm-12 col-12 mb-30 sitemapDiv parent" + item.MenuRank + "\">");
                                    stringBuilder.Append("<h5 class=\"sitemapTitle\"><a href=\"javascript:;\">" + item.MenuName + "</a></h5>");
                                    stringBuilder.Append("<ul class=\"custome\">");
                                    stringBuilder.Append(GenerateListHtml(item, lsdata));
                                    stringBuilder.Append("</ul>");
                                    stringBuilder.Append("</div>");
                                }
                                else
                                {
                                    // Append InnerPage menus to a separate builder to show later
                                    innerPageBuilder.Append("<li class=\"inner" + item.MenuRank + "\"><a href=\"" + item.MenuURL + "\">" + item.MenuName + "</a></li>");
                                    hasInnerPage = true; // Set the flag to true if any InnerPage items exist
                                }
                            }
                        }
                    }
                }
                // Append InnerPage sections after the regular menus
                innerPageBuilder.Append("</ul>");
                innerPageBuilder.Append("</div>");
                // Append InnerPage sections only if InnerPage records exist
                if (hasInnerPage)
                {
                    stringBuilder.Append(innerPageBuilder.ToString());
                }
                return Json(stringBuilder.ToString());
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(ex.Message, ex.ToString(), ControllerContext.ActionDescriptor.ControllerName, ControllerContext.ActionDescriptor.ActionName, ControllerContext.HttpContext.Request.Method);

                return Json("");
            }
        }

        private string GenerateListHtml(CMSMenuResourceModel item, List<CMSMenuResourceModel> lsdata, bool isSubMenu = false)
        {
            StringBuilder stringBuilder = new StringBuilder();

            // Find sub-menus for the current menu item
            var subMenus = lsdata.Where(x => x.col_parent_id == item.Id).OrderBy(x => x.MenuRank).ToList();

            // Only add <ul> for sub-menus
            if (subMenus.Count > 0)
            {
                if (isSubMenu)
                {
                    stringBuilder.Append("<ul class=\"mt-3\">"); // For sub-menus
                }

                foreach (var subItem in subMenus)
                {
                    string strPath = "";

                    if (subItem.MenuURL.StartsWith("/"))
                    {
                        strPath = subItem.MenuURL.ToString();
                    }
                    else if (subItem.IsRedirect == true)
                    {
                        strPath = subItem.MenuURL;
                    }
                    else
                    {
                        if (subItem.col_parent_id == 0)
                        {
                            strPath = "/Home/" + subItem.MenuURL;
                        }
                        else
                        {
                            strPath = "/Home/" + subItem.MenuURL;
                        }
                    }

                    // Start list item for the sub-menu
                    stringBuilder.Append("<li>");

                    // Generate the link for the sub-menu item using the calculated strPath
                    stringBuilder.Append("<a href=\"" + strPath + "\">" + subItem.MenuName + "</a>");

                    // Recursively call GenerateListHtml to generate HTML for sub-menus of the sub-item (child of child)
                    stringBuilder.Append(GenerateListHtml(subItem, lsdata, true));

                    // Close the list item
                    stringBuilder.Append("</li>");
                }

                // Close the <ul> list only for sub-menus
                if (isSubMenu)
                {
                    stringBuilder.Append("</ul>");
                }
            }

            return stringBuilder.ToString();
        }

        private IEnumerable<CMSMenuResourceModel> GenerateList(CMSMenuResourceModel item, List<CMSMenuResourceModel> lsdata)
        {
            List<CMSMenuResourceModel> adminMenuMasterModels = new List<CMSMenuResourceModel>();
            CMSMenuResourceModel mainModel = lsdata.Where(x => x.Id == item.Id).FirstOrDefault();
            if (mainModel != null)
            {
                adminMenuMasterModels.Add(mainModel);
            }
            List<CMSMenuResourceModel> lstSubList = lsdata.Where(x => x.col_parent_id == item.Id).OrderBy(x => x.MenuRank).ToList();
            if (lstSubList.Count() > 0)
            {
                foreach (var subList in lstSubList.ToList())
                {
                    adminMenuMasterModels.AddRange(GenerateList(subList, lsdata));
                }
            }
            return adminMenuMasterModels;
        }
        #endregion

        #region View
        [Route("/SiteMap")]
        public IActionResult SiteMap()
        {
            return View();
        }
        #endregion
    }
}
