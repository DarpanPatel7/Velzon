using Ganss.Xss;
using Velzon.Common;
using Velzon.IService.Service;
using Velzon.IService.System;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Velzon.Services.System;
using Velzon.Webs.Filters;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using System.Data;
using System.Globalization;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;


namespace Velzon.Webs.Common
{
    public class Functions
    {
        public static string regGlobalValidation;
        public static string regName;
        public static string regMobileNo;
        public static string regPincode;
        public static string regNumber;
        public static string regEmail;
        public static string regPassword;
        public static string regURL;
        public static string dateFormat;
        public static bool allowModalOutsideClick;
        public static bool allowKeyboardInputOnDate;
        public static bool allowKeyboardInputOnTime;
        public static bool allowInspectElement;
        protected IHttpClientFactory httpClientFactory { get; set; }
        internal static void GetAllDependencyInjection(IServiceCollection services)
        {
            services.AddAntiforgery(options =>
            {
                // Set Cookie properties using CookieBuilder properties†.
                options.FormFieldName = "AntiforgeryFieldname";
                options.HeaderName = "X-CSRF-TOKEN-HEADERNAME";
                options.Cookie.SameSite = SameSiteMode.Strict;
                options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
                options.Cookie.HttpOnly = true;
                options.SuppressXFrameOptionsHeader = false;
            });

            services.Configure<FormOptions>(options =>
            {
                options.ValueLengthLimit = int.MaxValue;
                options.MultipartBodyLengthLimit = long.MaxValue; // <-- ! long.MaxValue
                options.MultipartBoundaryLengthLimit = int.MaxValue;
                options.MultipartHeadersCountLimit = int.MaxValue;
                options.MultipartHeadersLengthLimit = int.MaxValue;
            });

            services.AddScoped<IAccountService, AccountService>();
            services.AddScoped<IRoleMasterService, RoleMasterService>();
            services.AddScoped<IAdminMenuMasterService, AdminMenuMasterService>();
            services.AddScoped<IMenuResourceMasterService, MenuResourceMasterService>();
            services.AddScoped<IUserMasterService, UserMasterService>();
            services.AddScoped<IMenuRightsMasterService, MenuRightsMasterService>();
            services.AddScoped<ICMSMenuResourceMasterService, CMSMenuResourceMasterService>();
            services.AddScoped<ICMSMenuMasterService, CMSMenuMasterService>();
            services.AddScoped<ICMSTemplateMasterService, CMSTemplateMasterService>();
            services.AddScoped<ISMTPMasterService, SMTPMasterService>();
            services.AddScoped<ICouchDBMasterService, CouchDBMasterService>();
            services.AddScoped<ICssMasterService, CssMasterService>();
            services.AddScoped<IJsMasterService, JsMasterService>();
            services.AddScoped<IBannerService, BannerService>();
            services.AddScoped<IMinisterServices, MinisterMasterService>();
            services.AddScoped<IPopupServices, PopupMasterService>();
            services.AddScoped<INewsMasterService, NewsMasterService>();
            services.AddScoped<IGoiLogoServices, GoiLogoService>();
            services.AddScoped<IDocumentServices, DocumentService>();
            services.AddScoped<IGalleryService, GalleryService>();
            services.AddScoped<IFeedbackServices, FeedbackService>();
            services.AddScoped<IVideoService, VideoService>();
            services.AddScoped<IGlobleSerchService, GlobleSerchService>();
            services.AddScoped<IEcitizenService, EcitizenService>();
            services.AddScoped<IStatisticServices, StatisticService>();
            services.AddScoped<ILanguageService, LanguageService>();
            services.AddScoped<IBranchService, BranchService>();
            services.AddScoped<ICommonService, CommonService>();
            services.AddScoped<IUtilityService, UtilityService>();
            services.AddScoped<IProjectService, ProjectService>();
            services.AddScoped<IServiceRateService, ServiceRateService>();
            services.AddScoped<PageRightsFilter>();
        }
        #region Admin Panel Breadcum

        public static string GetBreadcum(IUrlHelper url, HttpContext httpContext)
        {
            StringBuilder stringBuilder = new StringBuilder();
            string strCurrentPath = httpContext.Request.Path.Value.ToString();

            var UserModel = SessionWrapper.Get<SessionUserModel>(httpContext.Session, "UserDetails");
            if (null == UserModel)
            {
                httpContext.Response.Redirect(url.Content("~/Account/Index"));
            }
            else
            {
                using (IUserMasterService userMasterService = new UserMasterService())
                using (IAdminMenuMasterService adminMenuMasterService = new AdminMenuMasterService())
                using (IMenuResourceMasterService menuResourceMasterService = new MenuResourceMasterService())
                using (IRoleMasterService roleMasterService = new RoleMasterService())
                using (IMenuRightsMasterService menuRightsMasterService = new MenuRightsMasterService())
                {
                    if (UserModel.RoleId == 0)
                    {
                        ErrorLogger.Error(" Functions \n\r CreateMainLayoutMenu \n\r Role " + UserModel.RoleId, "RoleId As 0", "Functions", "CreateMainLayoutMenu", "", true);
                        return "";
                    }
                    else if (string.IsNullOrWhiteSpace(strCurrentPath))
                    {
                        ErrorLogger.Error(" Functions \n\r CreateMainLayoutMenu \n\r Role " + UserModel.RoleId, "CurrentPath As " + strCurrentPath, "Functions", "CreateMainLayoutMenu", "", true);
                        return "";
                    }
                    else
                    {
                        List<MenuRightsMasterModel> lstMenuList = menuRightsMasterService.GetListByRoleId(UserModel.RoleId).OrderBy(x => x.ParentId).ThenBy(n => n.MenuRank).ToList();
                        var mainModel = lstMenuList.FirstOrDefault(x => x.MenuURL == strCurrentPath);

                        stringBuilder.Append("");

                        stringBuilder.Append("<ul class='breadcrumbs'>");

                        if (mainModel != null)
                        {
                            stringBuilder.Append("    <li>");
                            stringBuilder.Append("        <a href='#'>");
                            stringBuilder.Append("            <span class='text'>" + mainModel.Name + "</span>");
                            stringBuilder.Append("        </a>");
                            stringBuilder.Append("    </li>");

                            stringBuilder.Append(CreateSubBreadCum(lstMenuList, mainModel.ParentId));

                        }
                        stringBuilder.Append("    <li>");
                        stringBuilder.Append("        <a href='../Admin/Dashboard'>");
                        stringBuilder.Append("            <span class='icon icon-home'></span>");
                        stringBuilder.Append("        </a>");
                        stringBuilder.Append("    </li>");
                        stringBuilder.Append("</ul>");
                    }
                }

            }
            return stringBuilder.ToString();
        }

        private static string CreateSubBreadCum(List<MenuRightsMasterModel> lstMenuList, long parentId)
        {
            StringBuilder stringBuilder = new StringBuilder();
            var mainModel = lstMenuList.FirstOrDefault(x => x.Id == parentId);
            if (mainModel != null && parentId > 0)
            {
                if (mainModel.ParentId > 0)
                {
                    stringBuilder.Append(CreateSubBreadCum(lstMenuList, mainModel.ParentId));
                }
                else
                {
                    stringBuilder.Append("    <li>");
                    stringBuilder.Append("        <a href='#'>");
                    stringBuilder.Append("            <span class='text'>" + mainModel.Name + "</span>");
                    stringBuilder.Append("        </a>");
                    stringBuilder.Append("    </li>");
                }
            }
            else
            {
                return "";
            }
            return stringBuilder.ToString();
        }

        #endregion

        #region Public Breadcum
        public static string[] getHtmlSplitted(String text)
        {
            var list = new List<string>();
            var pattern = "(<code>|</code>)";
            var isInTag = false;
            var inTagValue = String.Empty;

            foreach (var subStr in Regex.Split(text, pattern))
            {
                if (subStr.Equals("<code>"))
                {
                    isInTag = true;
                    continue;
                }
                else if (subStr.Equals("</code>"))
                {
                    isInTag = false;
                    list.Add(String.Format("<code>{0}</code>", inTagValue));
                    continue;
                }

                if (isInTag)
                {
                    inTagValue = subStr;
                    continue;
                }

                list.Add(subStr);

            }
            return list.ToArray();
        }
        public static string CKEditerSanitizer(string CkHtml)
        {
            string strUPdateHTml;
            Dictionary<string, string> keyValuePairs = new Dictionary<string, string>();
            var sanitizer = new HtmlSanitizer();
            if (CkHtml != null)
            {
                sanitizer.AllowedAttributes.Add("class");
                sanitizer.AllowedAttributes.Add("style");
                sanitizer.AllowedAttributes.Add("target");

                List<string> sas = getHtmlSplitted(CkHtml).ToList();
                List<string> sasUPdate = new List<string>();
                foreach (string sasd in sas)
                {
                    string strALocalVar = "";
                    string strALocalUPdateVar = "";
                    if (sasd.StartsWith("<code>"))
                    {
                        strALocalVar = HttpUtility.HtmlDecode(sasd);
                        strALocalUPdateVar = sanitizer.Sanitize(strALocalVar);
                    }
                    else
                    {
                        strALocalUPdateVar = (strALocalVar) = sasd;
                    }
                    sasUPdate.Add(strALocalUPdateVar);

                }
                CkHtml = string.Join(" ", sasUPdate);
            }
            else
            {
                CkHtml = "";
            }
            return sanitizer.Sanitize(CkHtml);
        }
        public class StringHelper
        {
            public static string BreadcrumbFrontValue(string value)
            {
                if (string.IsNullOrEmpty(value))
                {
                    return string.Empty;
                }

                // Define the key and IV based on your JavaScript code
                byte[] key = Encoding.UTF8.GetBytes("4090909090909020");
                byte[] iv = Encoding.UTF8.GetBytes("4090909090909020");

                // Encrypt the value using AES encryption
                string encryptedValue = BreadcrumbEncryptString(value, key, iv);

                // Replace '=' with '♬', '&' with '✦', '/' with '✤', '+' with '✿'
                string modifiedEncryptedValue = encryptedValue.Replace("=", "♬")
                                                              .Replace("&", "✦")
                                                              .Replace("/", "✤")
                                                              .Replace("+", "✿");

                return modifiedEncryptedValue;
            }

            private static string BreadcrumbEncryptString(string plainText, byte[] key, byte[] iv)
            {
                using (Aes aesAlg = Aes.Create())
                {
                    aesAlg.Key = key;
                    aesAlg.IV = iv;
                    aesAlg.Mode = CipherMode.CBC;
                    aesAlg.Padding = PaddingMode.PKCS7;

                    ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                    using (System.IO.MemoryStream msEncrypt = new System.IO.MemoryStream())
                    {
                        using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                        {
                            using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                            {
                                swEncrypt.Write(plainText);
                            }
                            return Convert.ToBase64String(msEncrypt.ToArray());
                        }
                    }
                }
            }

            public static string GreateHashString(string strHash)
            {
                if (string.IsNullOrEmpty(strHash))
                {
                    return string.Empty;
                }

                // Convert to string and replace spaces with underscores
                string newStr = strHash.Replace(" ", "_");

                // Apply FrontValue transformation
                string newStrPart0 = BreadcrumbFrontValue(newStr);

                // Replace '/' with 'HASH__HASH' and '+' with 'HASH_HASH'
                string newStrPart1 = newStrPart0.Replace("/", "HASH__HASH").Replace("+", "HASH_HASH");

                // Return the transformed string
                return newStrPart1;
            }
        }
        //public static string GetPublicBreadcum(IUrlHelper url, HttpContext httpContext, long lgid)
        //{
        //    StringBuilder stringBuilder = new StringBuilder();
        //    string strCurrentPath = httpContext.Request.Path.Value.ToString().Replace("/Home/", "");

        //    {
        //        using (ICMSMenuResourceMasterService userMasterService = new CMSMenuResourceMasterService())
        //        {
        //            {
        //                List<CMSMenuResourceModel> lstMenuList = userMasterService.GetListFront(lgid).OrderByDescending(x => x.col_parent_id).ThenByDescending(n => n.MenuRank).ToList();
        //                var mainModel = lstMenuList.FirstOrDefault(x => x.MenuURL == strCurrentPath);
        //                if (mainModel == null && !string.IsNullOrEmpty(strCurrentPath))
        //                {
        //                    // Check if a slash is present and filter if it is
        //                    var slashIndex = strCurrentPath.IndexOf('/');

        //                    if (slashIndex != -1)
        //                    {
        //                        // Filter the strCurrentPath to remove anything after the first slash
        //                        var strCurrentPathFiltered = strCurrentPath.Substring(0, slashIndex);

        //                        // Try to find the mainModel again with the filtered path
        //                        mainModel = lstMenuList.FirstOrDefault(x => x.MenuURL == strCurrentPathFiltered);
        //                    }
        //                }

        //                // Start breadcrumb-wrap div
        //                if (mainModel != null && !string.IsNullOrEmpty(mainModel.BannerImagePath))
        //                {
        //                    string hashedFileName = StringHelper.GreateHashString(mainModel.BannerImagePath);
        //                    stringBuilder.AppendLine("<div class=\"breadcrumb-wrap\" style=\"background: url('../ViewFile?fileName=" + HttpUtility.UrlEncode(hashedFileName) + "');\">");
        //                }
        //                else
        //                {
        //                    stringBuilder.AppendLine("<div class=\"breadcrumb-wrap breadcrumb-no-image\">");
        //                }
        //                stringBuilder.AppendLine("    <div class=\"overlay op-8 bg-racing-green\"></div>");
        //                stringBuilder.AppendLine("    <div class=\"container\">");
        //                if (mainModel != null && !string.IsNullOrEmpty(mainModel.IconImagePath))
        //                {
        //                    stringBuilder.AppendLine("        <div class=\"row align-items-end breadcrumb-row-icon-min-height\">");
        //                }
        //                else if (mainModel != null && !string.IsNullOrEmpty(mainModel.BannerImagePath))
        //                {
        //                    stringBuilder.AppendLine("        <div class=\"row align-items-end breadcrumb-row-banner-min-height\">");
        //                }
        //                else
        //                {
        //                    stringBuilder.AppendLine("        <div class=\"row align-items-end breadcrumb-row-default-min-height\">");
        //                }
        //                stringBuilder.AppendLine("            <div class=\"col-md-7 col-sm-8\">");
        //                stringBuilder.AppendLine("                <div class=\"breadcrumb-title\">");
        //                if (mainModel != null)
        //                {
        //                    stringBuilder.AppendLine("                    <h2>" + mainModel.MenuName + "</h2>");
        //                }
        //                stringBuilder.AppendLine("                    <ul class=\"breadcrumb-menu list-style\">");
        //                if (lgid == 2)
        //                {
        //                    stringBuilder.AppendLine("                        <li><a title=\"Homepage\" href=\"" + url.Content("~/Index") + "\">હોમ</a></li>");
        //                }
        //                else
        //                {
        //                    stringBuilder.AppendLine("                        <li><a title=\"Homepage\" href=\"" + url.Content("~/Index") + "\">Home</a></li>");
        //                }
        //                if (mainModel != null)
        //                {
        //                    stringBuilder.AppendLine("                        " + CreatePublicSubBreadCum(lstMenuList, mainModel.col_parent_id));
        //                    stringBuilder.AppendLine("                        <span></span><li>" + mainModel.MenuName + "</li>");
        //                }
        //                stringBuilder.AppendLine("                </div>");
        //                stringBuilder.AppendLine("            </div>"); 
        //                // End first column
        //                stringBuilder.AppendLine("            <div class=\"col-md-5 col-sm-4\">");
        //                stringBuilder.AppendLine("                <div class=\"breadcrumb-img\">");
        //                if (mainModel != null && !string.IsNullOrEmpty(mainModel.IconImagePath))
        //                {
        //                    string hashedFileName = StringHelper.GreateHashString(mainModel.IconImagePath);
        //                    stringBuilder.AppendLine("<img src=\"/ViewFile?fileName=" + HttpUtility.UrlEncode(hashedFileName) + ");\">");
        //                }
        //                // Close breadcrumb-img and column divs
        //                stringBuilder.AppendLine("                </div>");
        //                stringBuilder.AppendLine("            </div>"); // End second column
        //                // Close row, container, and breadcrumb-wrap divs
        //                stringBuilder.AppendLine("        </div>"); 
        //                stringBuilder.AppendLine("    </div>"); 
        //                stringBuilder.AppendLine("</div>"); // End breadcrumb-wrap
        //            }
        //        }

        //    }
        //    return stringBuilder.ToString();
        //}

        public static string GetPublicBreadcum(IUrlHelper url, HttpContext httpContext, long lgid)
        {
            StringBuilder stringBuilder = new StringBuilder();
            string strCurrentPath = httpContext.Request.Path.Value.ToString().Replace("/Home/", "");

            {
                using (ICMSMenuResourceMasterService userMasterService = new CMSMenuResourceMasterService())
                {
                    {
                        List<CMSMenuResourceModel> lstMenuList = userMasterService.GetListFront(lgid).OrderByDescending(x => x.col_parent_id).ThenByDescending(n => n.MenuRank).ToList();
                        var mainModel = lstMenuList.FirstOrDefault(x => x.MenuURL == strCurrentPath);
                       
                        stringBuilder.Append("");
                        stringBuilder.Append("<div class=\"pbmit-tbar\">");
                        stringBuilder.Append("<div class=\"pbmit-tbar-inner\">");
                        if(mainModel != null)
                        {
                            stringBuilder.Append("<h1 class=\"pbmit-tbar-title\">" + mainModel.MenuName + "</h1>");
                        }
                        
                        stringBuilder.Append("</div>");
                        stringBuilder.Append("</div>");

                        stringBuilder.Append("<div class=\"pbmit-breadcrumb\">");
                        stringBuilder.Append("<div class= \"pbmit-breadcrumb-inner\"");
                        if (lgid == 2)
                        {
         
                            stringBuilder.Append("<span><a title=\"\" href=\"" + url.Content("~/Index") + "\" class=\"home\"> <span>હોમ</a></span>");
                        }
                        else
                        {

                            stringBuilder.Append("<span><a title=\"\" href=\""+ url.Content("~/Index") + "\" class=\"home\"> <span>Home</a></span>");
                        }

                        if (mainModel != null)
                        {
                            if(mainModel.col_parent_id !=0)
                            {
                                stringBuilder.Append("<span class=\"sep\"><i class=\"pbmit-base-icon-angle-double-right\"></i></span>");
                            }
                            
                            stringBuilder.Append(CreatePublicSubBreadCum(lstMenuList, mainModel.col_parent_id));
                            stringBuilder.Append("<span class=\"sep\"><i class=\"pbmit-base-icon-angle-double-right\"></i></span>");

                            stringBuilder.Append("<span class=\"post-root post post-post current-item\">" + mainModel.MenuName + "</span>");
                            

                        }
                        stringBuilder.Append("</div>");
                        stringBuilder.Append("</div>");

                    }
                }

            }
            return stringBuilder.ToString();
        }

        public static string GetAdminBreadcum(IUrlHelper url, HttpContext httpContext)
        {
            StringBuilder stringBuilder = new StringBuilder();
            string strCurrentPath = httpContext.Request.Path.Value.Replace("/Home/", ""); // Remove redundant ToString()

            using (IAdminMenuMasterService adminMenuMasterService = new AdminMenuMasterService())
            {
                List<AdminMenuMasterModel> lstMenuList = adminMenuMasterService.GetList();
                var mainModel = lstMenuList.FirstOrDefault(x => x.MenuURL == strCurrentPath);

                // Set default values in case mainModel is null
                string pageTitle = mainModel?.Name ?? "Dashboard";
                string parentTitle = mainModel?.ParentName ?? "Dashboard";

                stringBuilder.Append($@"
                <h4 class='mb-sm-0'>{pageTitle}</h4>
                <div class='page-title-right'>
                    <ol class='breadcrumb m-0'>
                        <li class='breadcrumb-item'><a href='javascript:void(0);'>{parentTitle}</a></li>
                        <li class='breadcrumb-item active'>{pageTitle}</li>
                    </ol>
                </div>");
            }

            return stringBuilder.ToString();
        }


        private static string CreatePublicSubBreadCum(List<CMSMenuResourceModel> lstMenuList, long parentId)
        {
            StringBuilder stringBuilder = new StringBuilder();
            var mainModel = lstMenuList.FirstOrDefault(x => x.Id == parentId);
            if (mainModel != null && parentId > 0)
            {
               stringBuilder.Append(CreatePublicSubBreadCum(lstMenuList, mainModel.col_parent_id));
               stringBuilder.Append("<span><a title=\"\" href=\"#\" class=\"home\"> <span>" + mainModel.MenuName + "</a></span>");
            }
            else
            {
                return "";
            }
            return stringBuilder.ToString();
        }

        public string GreateHashString(string input)
        {
            if (string.IsNullOrEmpty(input))
            {
                return string.Empty;
            }

            // Example hashing logic using SHA256
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(input));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
        #endregion
        #region Public Quick Link


        public static string GetQuickLink(IUrlHelper url, HttpContext httpContext, long lgid)
        {

            StringBuilder stringBuilder = new StringBuilder();
            string strCurrentPath = httpContext.Request.Path.Value.ToString();

            {
                using (ICMSMenuResourceMasterService userMasterService = new CMSMenuResourceMasterService())
                {
                    if (strCurrentPath != "SiteMap")
                    {
                        List<CMSMenuResourceModel> lstMenuList = userMasterService.GetListFront(lgid).OrderBy(x => x.col_parent_id).ThenBy(n => n.MenuRank).ToList();

                        lstMenuList.ForEach(mainMenu =>
                        {
                            if (mainMenu.ResourceType == "0")
                            {
                                mainMenu.MenuURL = "/Home/" + mainMenu.MenuURL.Replace(@"\\", "\\");
                            }
                            else if (mainMenu.MenuURL.ToLower().StartsWith("http"))
                            {
                                mainMenu.MenuURL = mainMenu.MenuURL;
                            }
                            else
                            {
                                mainMenu.MenuURL = ("/" + mainMenu.MenuURL).Replace(@"//", "/");
                            }
                        });
                        var mainModel = lstMenuList.FirstOrDefault(x => strCurrentPath.StartsWith(x.MenuURL));

                        if (mainModel != null)
                        {
                            stringBuilder.Append("");
                            stringBuilder.Append("<h2>" + mainModel.ParentName + "</h2>");
							stringBuilder.Append("<div class=\"all-post-list pbmit-bg-color-global\">");
                            stringBuilder.Append("<ul>");

                            if (mainModel != null)
                            {
                                if (mainModel.col_menu_type != "2")
                                {
                                    var suubMenuList = lstMenuList.Where(x => x.col_parent_id != 0 || x.Id == mainModel.Id).ToList().Where(z => z.col_menu_type != "2" && z.col_menu_type != "3").Where(x => x.col_parent_id == mainModel.col_parent_id).ToList();

                                    foreach (var subMenu in suubMenuList)
                                    {
                                        string strPath = (string.IsNullOrWhiteSpace(subMenu.MenuURL) || subMenu.MenuURL == "#" ? "#" : (subMenu.MenuURL.ToLower().StartsWith("http") ? subMenu.MenuURL : url.Content("~" + subMenu.MenuURL))).Replace(@"\\", "\\");
                                        stringBuilder.Append("<li><a " + (subMenu.IsRedirect ? " target=\"_blank\"" : "") + " href='" + strPath + "' " + (strCurrentPath.StartsWith(subMenu.MenuURL) ? " class=\"active\"" : "") + ">" + subMenu.MenuName + "</a></li>");
                                    }
                                }
                                
                            }
							stringBuilder.Append("</ul>");
							stringBuilder.Append("</div>");
						}
                    }
                    else
                    {
                        stringBuilder.Append("");
                    }
                }
            }
            return stringBuilder.ToString();
        }

        #endregion
        internal static string GetPathFrom(string strPath)
        {
            string strCurrentPath = "";
            using (ICMSMenuMasterService cMSMenuMasterService = new CMSMenuMasterService())
            {
                var data = cMSMenuMasterService.GetList().Where(x => x.MenuURL == strPath).FirstOrDefault();

                if (data != null)
                {
                    if (data.PageType == "1")
                    {
                        strCurrentPath = "/" + (data.MenuURL.ToString()) + "/d";
                    }
                    else
                    {
                        strCurrentPath = strPath;
                    }
                }
                else
                {
                    strCurrentPath = strPath;
                }
            }

            return strCurrentPath;
        }

        internal static string ValidateHomePage(string strPath)
        {
            string strCurrentPath = "";
            using (ICMSMenuMasterService cMSMenuMasterService = new CMSMenuMasterService())
            {
                var data = cMSMenuMasterService.GetList().Where(x => x.MenuURL == strPath).FirstOrDefault();

                if (data != null)
                {
                    if (data.PageType == "1")
                    {
                        strCurrentPath = "/" + (data.MenuURL.ToString()) + "/d";
                    }
                    else
                    {
                        strCurrentPath = strPath;
                    }
                }
                else
                {
                    strCurrentPath = strPath;
                }
            }

            return strCurrentPath;
        }

        internal static string GetHomePage(IUrlHelper url)
        {
            string strCurrentPath = "";
            using (ICMSMenuMasterService cMSMenuMasterService = new CMSMenuMasterService())
            {
                var data = cMSMenuMasterService.GetList().Where(x => x.IsHomePage).FirstOrDefault();

                if (data != null)
                {
                    if (data.PageType == "1")
                    {
                        strCurrentPath = (url.Content("~/Home/" + data.MenuURL.ToString()));
                        //strCurrentPath = "/" + (data.MenuURL.ToString()) + "/Index";
                    }
                    //else if(data.PageType=="0")
                    //{
                    //    strCurrentPath = (url.Content("~/" + data.MenuURL.ToString()));
                    //}
                }
                else
                {
                    strCurrentPath = url.Content("~/Account/Index");
                }
            }

            return strCurrentPath;
        }
        private static string GetParentIdString(IUrlHelper urlHelper, MenuRightsMasterModel mainMenu, List<MenuRightsMasterModel> lstList, string strCurrentPath)
        {
            bool isActive = mainMenu.MenuURL?.ToLower() == strCurrentPath.ToLower();

            // Get child items (submenus)
            List<MenuRightsMasterModel> lstSubList = lstList
                .Where(x => x.ParentId == mainMenu.Id)
                .OrderBy(x => x.MenuRank)
                .ToList();

            // Determine if any child item is active
            bool hasActiveChild = lstSubList.Any(subMenu => subMenu.MenuURL?.ToLower() == strCurrentPath.ToLower());

            // If this menu has active child, mark parent as active and expanded
            string parentActiveClass = hasActiveChild ? " active" : "";
            string parentExpandedClass = hasActiveChild ? " show" : "";

            StringBuilder strMenu = new StringBuilder();

            if (lstSubList.Count > 0) // If has submenus
            {
                strMenu.Append($@"
                <li class='nav-item'>
                    <a class='nav-link menu-link{parentActiveClass}' href='#sidebar-{mainMenu.Id}' data-bs-toggle='collapse' role='button' aria-expanded='{(hasActiveChild ? "true" : "false")}' aria-controls='sidebar-{mainMenu.Id}'>
                        <i class='ri-dashboard-2-line'></i> <span data-key='t-{mainMenu.Name.ToLower()}'>{mainMenu.Name}</span>
                    </a>
                    <div class='collapse menu-dropdown{parentExpandedClass}' id='sidebar-{mainMenu.Id}'>
                        <ul class='nav nav-sm flex-column'>");

                // Loop through submenus
                foreach (var subMenu in lstSubList)
                {
                    strMenu.Append(GetParentIdString(urlHelper, subMenu, lstList, strCurrentPath));
                }

                strMenu.Append("</ul></div></li>");
            }
            else // Direct link (no submenu)
            {
                string strPath = mainMenu.MenuURL;
                string activeClass = isActive ? " active" : "";
                string href = string.IsNullOrWhiteSpace(strPath) || strPath == "#" ? "#" : urlHelper.Content("~" + strPath);

                strMenu.Append($@"
                <li class='nav-item'>
                    <a href='{href}' class='nav-link{activeClass}'>
                        <span data-key='t-{mainMenu.Name.ToLower()}'>{mainMenu.Name}</span>
                    </a>
                </li>");
            }

            return strMenu.ToString();
        }

        public static void GetPageRights(long lgRoleId, HttpContext httpContext)
        {
            using (IMenuRightsMasterService menuRightsMasterService = new MenuRightsMasterService())
            {
                PageRightsModel pageRightsModel = new PageRightsModel();
                var menuList = menuRightsMasterService.GetListByRoleId(lgRoleId).Where(x => x.MenuURL == httpContext.Request.Path.Value).FirstOrDefault();
                if (menuList != null)
                {
                    pageRightsModel.Insert = menuList.Insert;
                    pageRightsModel.Update = menuList.Update;
                    pageRightsModel.Delete = menuList.Delete;
                    pageRightsModel.View = menuList.View;
                    SessionWrapper.Set<PageRightsModel>(httpContext.Session, "PageRights", pageRightsModel);
                }
            }
        }
        
        public static PageRightsModel GetViewPageRights(long lgRoleId, HttpContext httpContext)
        {
            using (IMenuRightsMasterService menuRightsMasterService = new MenuRightsMasterService())
            {
                PageRightsModel pageRightsModel = new PageRightsModel();
                var menuList = menuRightsMasterService.GetListByRoleId(lgRoleId).FirstOrDefault(x => x.MenuURL == httpContext.Request.Path.Value);
                if (menuList != null)
                {
                    pageRightsModel.Insert = menuList.Insert;
                    pageRightsModel.Update = menuList.Update;
                    pageRightsModel.Delete = menuList.Delete;
                    pageRightsModel.View = menuList.View;
                }

                return pageRightsModel;
            }
        }

        public static PageRightsModel GetPageRightsCheck(ISession httpContext)
        {
            return SessionWrapper.Get<PageRightsModel>(httpContext, "PageRights");
        }

        public static string CreateMainLayoutMenu(IUrlHelper urlHelper, long lgRoleId, string strCurrentPath)
        {
            try
            {
                StringBuilder stringBuilder = new StringBuilder();
                string strMainMenu = "";
                using (IUserMasterService userMasterService = new UserMasterService())
                using (IAdminMenuMasterService adminMenuMasterService = new AdminMenuMasterService())
                using (IMenuResourceMasterService menuResourceMasterService = new MenuResourceMasterService())
                using (IRoleMasterService roleMasterService = new RoleMasterService())
                using (IMenuRightsMasterService menuRightsMasterService = new MenuRightsMasterService())
                {

                    if (lgRoleId == 0)
                    {
                        ErrorLogger.Error(" Functions \n\r CreateMainLayoutMenu \n\r Role " + lgRoleId, "RoleId As 0", "Functions", "CreateMainLayoutMenu", "", true);
                        return "";
                    }
                    else if (string.IsNullOrWhiteSpace(strCurrentPath))
                    {
                        ErrorLogger.Error(" Functions \n\r CreateMainLayoutMenu \n\r Role " + lgRoleId, "CurrentPath As " + strCurrentPath, "Functions", "CreateMainLayoutMenu", "", true);
                        return "";
                    }
                    else
                    {
                        List<MenuRightsMasterModel> lstMenuList = menuRightsMasterService.GetListByRoleId(lgRoleId).OrderBy(x => x.ParentId).ThenBy(n => n.MenuRank).ToList();

                        foreach (MenuRightsMasterModel menu in lstMenuList.Where(x => x.ParentId == 0).OrderBy(x => x.ParentId).ThenBy(n => n.MenuRank).ToList())
                        {
                            stringBuilder.Append(GetParentIdString(urlHelper, menu, lstMenuList, strCurrentPath));
                        }
                    }
                    strMainMenu = stringBuilder.ToString();
                    return strMainMenu;
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error(" Functions \n\r CreateMainLayoutMenu \n\r Role " + lgRoleId, "RoleId As " + lgRoleId, "Functions", "CreateMainLayoutMenu", "", true);
                DapperConnection.ErrorLogEntry(ex.ToString(), "Functions", "CreateMainLayoutMenu", "Web", "");
            }
            return "";
        }

        public static string FirstCharToUpper(string input)
        {
            switch (input)
            {
                case null: throw new ArgumentNullException(nameof(input));
                case "": throw new ArgumentException($"{nameof(input)} cannot be empty", nameof(input));
                default: return input[0].ToString().ToUpper() + input.Substring(1);
            }
        }

        public static string CreateMainUserLayoutMenu(IUrlHelper urlHelper, string strCurrentPath, long lgid)
        {
            try
            {

                StringBuilder stringBuilder = new StringBuilder();
                string strMainMenu = "";
                if (lgid == 0)
                {
                    lgid = 1;
                }
                using (ICMSMenuResourceMasterService cMSMenuResourceMasterService = new CMSMenuResourceMasterService())
                {
                    if (lgid == 1)
                    {
                        stringBuilder.Append("<li class=\"\">\r\n<a href=\"\\Index\" class=\"\">Home</a>\r\n</li>");
                    }
                    else { 
                        stringBuilder.Append("<li class=\"\">\r\n<a href=\"\\Index\" class=\"\">હોમ</a>\r\n</li>");
                    }
                    List<CMSMenuResourceModel> lstMenuList = cMSMenuResourceMasterService.GetListFront(lgid).Where(z => z.col_menu_type != "2" && z.col_menu_type != "3").OrderBy(x => x.col_parent_id).ThenBy(n => n.MenuRank).ToList();

                    foreach (CMSMenuResourceModel menu in lstMenuList.Where(x => x.col_parent_id == 0).OrderBy(x => x.col_parent_id).ThenBy(n => n.MenuRank).ToList())
                    {
                        stringBuilder.Append(GetUserParentIdString(urlHelper, menu, lstMenuList, strCurrentPath));
                    }

                    strMainMenu = stringBuilder.ToString();
                    return strMainMenu;
                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        private static string GetUserParentIdString(IUrlHelper urlHelper, CMSMenuResourceModel mainMenu, List<CMSMenuResourceModel> lstList, string strCurrentPath)
        {
            string strPath = mainMenu.MenuURL;
            if (mainMenu.MenuURL != "#")
            {

                if (mainMenu.ResourceType == "0")
                {
                    mainMenu.MenuURL = "/Home/" + mainMenu.MenuURL.Replace(@"\\", "\\");
                }
                else if (mainMenu.MenuURL.ToLower().StartsWith("http"))
                {
                    mainMenu.MenuURL = mainMenu.MenuURL;
                }
                else
                {

                    mainMenu.MenuURL = ("/" + mainMenu.MenuURL).Replace(@"//", "/");
                }

                if (mainMenu.MenuURL.StartsWith("/"))
                {
                    strPath = mainMenu.MenuURL.ToString();
                }

            }
            bool isActive = false;
            if (mainMenu.MenuURL.ToString().ToLower() == strCurrentPath.ToLower())
            {
                isActive = true;
            }
            StringBuilder strMenu = new StringBuilder();
            List<CMSMenuResourceModel> lstSubList = lstList.Where(x => x.col_parent_id == mainMenu.Id).OrderBy(x => x.col_parent_id).ToList();
            if (lstSubList.Count() > 0)
            {

                strMenu.Append("<li class=\"dropdown\"><a href='" + (string.IsNullOrWhiteSpace(strPath) || strPath == "#" ? "#" : (mainMenu.MenuURL.ToLower().StartsWith("http") ? strPath : urlHelper.Content("~" + strPath))) + "' class=\"\">" + mainMenu.MenuName + "<i class=\"ri-arrow-down-s-fill\"></i></a> </a><ul class=''>");
                foreach (var mainMenus in lstSubList)
                {
                    if (lstSubList.Count() > 0)
                    {
                        strMenu.Append(GetUserParentIdString(urlHelper, mainMenus, lstList, strCurrentPath));
                    }
                    else
                    {
                        strMenu.Append("<li class=\"dropdown\"><a " + (mainMenu.IsRedirect ? " target=\"_blank\"" : "") + " href='" + (string.IsNullOrWhiteSpace(strPath) || strPath == "#" ? "#" : (mainMenu.MenuURL.ToLower().StartsWith("http") ? strPath : urlHelper.Content("~" + strPath))) + "' "+ (isActive ? " class=\" active\"" : " class=\"\"") + ">" + mainMenu.MenuName + "</a></li>");
                    }

                }
                strMenu.Append("</ul></li>");
            }
            else
            {
                strMenu.Append("<li class=\"dropdown\" ><a " + (mainMenu.IsRedirect ? " target=\"_blank\"" : "") + " href='" + (string.IsNullOrWhiteSpace(strPath) || strPath == "#" ? "#" : (mainMenu.MenuURL.ToLower().StartsWith("http") ? strPath : urlHelper.Content("~" + strPath))) + "' "+ (isActive ? " class=\" active\"" : " class=\"\"") + ">" + mainMenu.MenuName + "</a></li>");
            }

            return strMenu.ToString();
        }


        public static string GetAllNewsByType(IUrlHelper urlHelper, long LangId, string strCurrentPath, string Newstype)
        {
            try
            {
                string strnews = "";
                if (LangId == 0)
                {
                    LangId = 1;
                }
                using (INewsMasterService NewsMasterService = new NewsMasterService())
                {
                    List<NewsModel> lstNewsList = NewsMasterService.GetList(LangId).Where(x => x.NewsTypeId == Newstype).ToList();

                    if (lstNewsList.Count() <= 0)
                    {
                        lstNewsList = NewsMasterService.GetList(1).Where(x => x.NewsTypeId == Newstype).ToList();
                    }

                    strnews = lstNewsList[0].NewsDesc.ToString();
                }

                return strnews;

            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static string UpdateDate(long lgLangId = 1)
        {
            try
            {
                StringBuilder stringBuilder = new StringBuilder();
                string str_Date = "";

                using (ICommonService CommonService = new CommonService())
                {
                    var data = CommonService.UpdateSiteDate();
                    string updatedText = lgLangId == 1 ? "Last Updated : " : "છેલ્લા સુધારાની તારીખ : ";
                    str_Date = $"<span> {updatedText}{(data?.pUpdatedDate ?? "")}</span>";
                    stringBuilder = stringBuilder.Append(str_Date);

                }
                str_Date = stringBuilder.ToString();

                return str_Date;
            }
            catch (Exception ex)
            {
                throw;
            }

        }

        public static bool ValidControlValue(dynamic controlValue, ControlInputType type = ControlInputType.none)
        {
            bool allow = false;
            try
            {
                Regex regexGlobalValidation = new Regex(regGlobalValidation);
                Regex regexName = new Regex(regName);
                Regex regexMobileNo = new Regex(regMobileNo);
                Regex regexPincode = new Regex(regPincode);
                Regex regexNumber = new Regex(regNumber);
                Regex regexEmail = new Regex(@regEmail.Replace(@"\\", @"\"));
                Regex regexPassword = new Regex(@regPassword.Replace(@"\\", @"\"));
                Regex regexURL = new Regex(regURL);
                string strControlValue = controlValue != null ? controlValue.ToString().Trim() : "";

                if (!string.IsNullOrEmpty(strControlValue) && regexGlobalValidation.IsMatch(strControlValue))
                {
                    if (type == ControlInputType.text)
                    {
                        if (regexName.IsMatch(strControlValue))
                        {
                            allow = true;
                        }
                    }
                    else if (type == ControlInputType.email)
                    {
                        if (regexEmail.IsMatch(strControlValue))
                        {
                            allow = true;
                        }
                    }
                    else if (type == ControlInputType.mobileno)
                    {
                        if (regexMobileNo.IsMatch(strControlValue))
                        {
                            allow = true;
                        }
                    }
                    else if (type == ControlInputType.password)
                    {
                        if (regexPassword.IsMatch(strControlValue))
                        {
                            allow = true;
                        }
                    }
                    else if (type == ControlInputType.pincode)
                    {
                        if (regexPincode.IsMatch(strControlValue))
                        {
                            allow = true;
                        }
                    }
                    else if (type == ControlInputType.url)
                    {
                        if (regexURL.IsMatch(strControlValue))
                        {
                            allow = true;
                        }
                    }
                    else if (type == ControlInputType.dropdown)
                    {
                        long dropdownValue = 0;
                        long.TryParse(strControlValue, out dropdownValue);
                        if (dropdownValue > 0)
                        {
                            allow = true;
                        }
                    }
                    else if (type == ControlInputType.date)
                    {
                        try
                        {
                            DateTime dt = DateTime.ParseExact(strControlValue, dateFormat, CultureInfo.InvariantCulture);
                            allow = true;
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                    else if (type == ControlInputType.time)
                    {
                        try
                        {
                            DateTime dt = DateTime.ParseExact(strControlValue, "hh:mm tt", CultureInfo.InvariantCulture);
                            allow = true;
                        }
                        catch (Exception ex)
                        {

                        }
                    }
                    else
                    {
                        allow = true;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return allow;
        }

        public static bool ValidLength(dynamic controlValue)
        {
            bool allow = false;
            try
            {
                if (controlValue != null && controlValue.Length > 0)
                {
                    allow = true;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return allow;
        }

        public static string Search(IUrlHelper url, string search, string lngId)
        {
            try
            {
                StringBuilder stringMainBuilder = new StringBuilder();
                string strserch_R = "";

                using (IGlobleSerchService SerchServices = new GlobleSerchService())
                {
                    List<GlobleSerchModel> lstGbList = SerchServices.GetList(search, Convert.ToInt64(lngId));

                    ListtoDataTableConverter converter = new ListtoDataTableConverter();
                    DataTable dt = converter.ToDataTable(lstGbList);
                    if (dt.Rows.Count > 0)
                    {
                        stringMainBuilder.Append("");
                        foreach (DataRow row in dt.Rows)
                        {
                            string pagename = row["PageName"].ToString() + "/" /*+ row["Id"].ToString()*/;
                            stringMainBuilder.Append("<div class='col-md-3'>");
                            stringMainBuilder.Append("    <div class='card '>");
                            stringMainBuilder.Append("        <div class='card-body'>");
                            stringMainBuilder.Append("            <h5 class='card-title'> <a href='" + url.Content("~/" + pagename) + "'> " + row["PageName"] + "</a></h5>");
                            stringMainBuilder.Append("            <p>");
                            stringMainBuilder.Append("               " + row["MetaDescription"].ToString());
                            stringMainBuilder.Append("            </p>");
                            stringMainBuilder.Append("        </div>");
                            stringMainBuilder.Append("    </div>");
                            stringMainBuilder.Append("</div>");
                        }
                    }
                    else
                    {
                        stringMainBuilder.Append("");
                        stringMainBuilder.Append("<div class='col-md-3'>");
                        stringMainBuilder.Append("    <div class='card '>");
                        stringMainBuilder.Append("        <div class='card-body'>");
                        stringMainBuilder.Append("            <h6 class='card-title'> <a href=''> Record not found !</a></h6>");
                        stringMainBuilder.Append("            <p>");
                        stringMainBuilder.Append("               ");
                        stringMainBuilder.Append("            </p>");
                        stringMainBuilder.Append("        </div>");
                        stringMainBuilder.Append("    </div>");
                        stringMainBuilder.Append("</div>");
                    }
                }
                strserch_R = stringMainBuilder.ToString();
                return strserch_R;
            }
            catch (Exception ex)
            {
                throw;
            }
            return "";
        }

        public class ListtoDataTableConverter
        {
            public DataTable ToDataTable<T>(List<T> items)
            {
                DataTable dataTable = new DataTable(typeof(T).Name);
                //Get all the properties
                PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
                foreach (PropertyInfo prop in Props)
                {
                    //Setting column names as Property names
                    dataTable.Columns.Add(prop.Name);
                }
                foreach (T item in items)
                {
                    var values = new object[Props.Length];
                    for (int i = 0; i < Props.Length; i++)
                    {
                        //inserting property values to datatable rows
                        values[i] = Props[i].GetValue(item, null);
                    }
                    dataTable.Rows.Add(values);
                }
                //put a breakpoint here and check datatable
                return dataTable;
            }
        }

        // Generates a string containing HTML link tags for each CSS file 
        // based on the data retrieved from CSSMasterSiteData.
        public static string CSSMasterDomain(IUrlHelper url)
        {
            try
            {
                StringBuilder stringBuilder = new StringBuilder();
                string CSSCODE = "";
                using (ICssMasterService CSSMasterService = new CssMasterService())
                {
                    var data = CSSMasterService.CSSMasterSiteData();
                    foreach (var item in data)
                    {
                        string strPath = url.Content("~/CSSCustom/" + item.Title + ".css");
                        stringBuilder.Append("\r\n <link rel=\"stylesheet\" type=\"text/css\" href=" + strPath + ">");
                    }
                    stringBuilder = stringBuilder.Append(CSSCODE);
                }
                CSSCODE = stringBuilder.ToString();

                return CSSCODE;
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error while generating Css Master Domain content.", ex);
            }
        }

        // Generates a string containing JavaScript script tags for each JavaScript file 
        // based on the data retrieved from JSMasterSiteData.
        public static string JSMasterDomain(IUrlHelper url)
        {
            try
            {
                StringBuilder stringBuilder = new StringBuilder();
                using (IJsMasterService JSMasterService = new JsMasterService())
                {
                    var data = JSMasterService.JSMasterSiteData();
                    foreach (var item in data)
                    {
                        // Dynamically append each JS file's path
                        string strPath = url.Content($"~/JSCustom/{item.Title}.js");
                        stringBuilder.AppendLine($"<script type=\"text/javascript\" src=\"{strPath}\"></script>");
                    }
                }
                return stringBuilder.ToString(); // Return the final JS content
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error while generating JS Master Domain content.", ex);
            }
        }
    }
}
