using Velzon.Common;
using Velzon.Model.Service;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Data;

namespace Velzon.Webs.Filters
{
    public class PageRightsFilter : IActionFilter
    {
        /// <summary>
        /// Executes before the action method is invoked.
        /// </summary>
        /// <param name="context"></param>
        public void OnActionExecuting(ActionExecutingContext context)
        {
            var httpContext = context.HttpContext;
            try
            {
                // Retrieve UserModel from the session
                var userModel = SessionWrapper.Get<SessionUserModel>(httpContext.Session, "UserDetails");

                if (userModel == null)
                {
                    RedirectToLogin(context);
                    return;
                }

                // Check if user is locked
                if (IsUserLocked(userModel))
                {
                    ClearSessionAndRedirect(httpContext, context);
                    return;
                }

                // Check user page rights
                var pageRight = Common.Functions.GetViewPageRights(userModel.RoleId, httpContext);
                if (pageRight?.View == false)
                {
                    context.Result = new RedirectToActionResult("AccessDenied", "Error", new { area = "Admin" });
                }
            }
            catch (Exception ex)
            {
                ErrorLogger.Error("An error occurred while executing the PageRightsFilter.", ex.ToString(), "PageRightsFilter", "OnActionExecuting");
                RedirectToLogin(context);
            }
        }

        /// <summary>
        /// Executes after the action method has been invoked.
        /// </summary>
        /// <param name="context"></param>
        public void OnActionExecuted(ActionExecutedContext context)
        {
            // No action needed after the method executes
        }

        /// <summary>
        /// Helper method to redirect the user to the login page.
        /// </summary>
        /// <param name="context"></param>
        private void RedirectToLogin(ActionExecutingContext context)
        {
            context.Result = new RedirectToActionResult("Index", "Account", null);
        }

        /// <summary>
        /// Clears the session and redirects the user to the login page.
        /// </summary>
        /// <param name="httpContext"></param>
        /// <param name="context"></param>
        private void ClearSessionAndRedirect(HttpContext httpContext, ActionExecutingContext context)
        {
            httpContext.Response.Cookies.Delete("LoginCookie");
            httpContext.Session.Remove("UserDetails");
            httpContext.Session.Clear();
            context.Result = new RedirectToActionResult("Index", "Account", new { area = "" });
        }

        /// <summary>
        /// Checks if the user is locked.
        /// </summary>
        /// <param name="userModel"></param>
        /// <returns>True if the user is locked, otherwise false.</returns>
        private bool IsUserLocked(SessionUserModel userModel)
        {
            DapperConnection dapperConnection = new DapperConnection();

            var parameters = new Dictionary<string, object>
            {
                { "pUserName", userModel.Username },
                { "pipAddress", null }
            };

            var userData = dapperConnection.GetListResult<AttmptOrLockModel>("cmsGetWrongAttemptCount", CommandType.StoredProcedure, parameters).FirstOrDefault();

            return userData?.IsLocked > 0;
        }
    }
}
