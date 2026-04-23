using Velzon.Webs.Models;

namespace Velzon.Webs.Common
{
    public static class SessionKeys
    {
        public static string LoginCookie { get; private set; } = string.Empty;
        public static string UserId { get; private set; } = string.Empty;
        public static string UserName { get; private set; } = string.Empty;

        public static string CookiePath { get; private set; } = "/";

        public static void Initialize(SessionKeySettings settings, string basePath)
        {
            LoginCookie = settings.LoginCookie;
            UserId = settings.UserId;
            UserName = settings.UserName;

            CookiePath = string.IsNullOrWhiteSpace(basePath)
                ? "/"
                : basePath;
        }
    }

}
