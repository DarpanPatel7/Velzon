using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Velzon.Common;
using Velzon.Webs.Common;
using Velzon.Webs.Models;

namespace Velzon.Webs.Extensions
{
    public static class BuilderExtensions
    {
        public static void ConfigureCustomSettings(this WebApplicationBuilder builder)
        {
            // Automatically loads:
            // appsettings.json
            // appsettings.{Environment}.json
            // Environment variables
            var configuration = builder.Configuration;

            DapperConnection.isDevlopment = builder.Environment.IsDevelopment();
            DapperConnection.connectionString =
                configuration.GetConnectionString("ApplicationContextConnection");

            Velzon.Webs.Common.Functions.regGlobalValidation = configuration["RegexPatterns:Global"];
            Velzon.Webs.Common.Functions.regName = configuration["RegexPatterns:Name"];
            Velzon.Webs.Common.Functions.regMobileNo = configuration["RegexPatterns:MobileNo"];
            Velzon.Webs.Common.Functions.regPincode = configuration["RegexPatterns:Pincode"];
            Velzon.Webs.Common.Functions.regNumber = configuration["RegexPatterns:Number"];
            Velzon.Webs.Common.Functions.regEmail = configuration["RegexPatterns:Email"];
            Velzon.Webs.Common.Functions.regPassword = configuration["RegexPatterns:Password"];
            Velzon.Webs.Common.Functions.regURL = configuration["RegexPatterns:URL"];
        }

        public static IServiceCollection AddAppServices(
            this IServiceCollection services,
            IConfiguration configuration,
            IWebHostEnvironment environment)
        {
            services.AddHealthChecks();

            services.AddControllersWithViews(options =>
            {
                options.Filters.Add<CustomResultFilterAttribute>();
            });

            services.AddHttpContextAccessor();
            services.AddHttpClient();

            services.Configure<IISServerOptions>(o =>
                o.MaxRequestBodySize = long.MaxValue);

            services.Configure<KestrelServerOptions>(o =>
                o.Limits.MaxRequestBodySize = long.MaxValue);

            services.AddResponseCaching();

            services.AddControllers(options =>
            {
                options.CacheProfiles.Add("Default", new CacheProfile
                {
                    Duration = 0,
                    Location = ResponseCacheLocation.None,
                    NoStore = true
                });
            });

            var securitySettings = configuration
                .GetSection("SecuritySettings")
                .Get<SecuritySettings>();

            services.AddCors(options =>
            {
                options.AddPolicy("_myAllowSpecificOrigins", policy =>
                {
                    policy.WithOrigins(securitySettings.CorsOrigins)
                        .AllowAnyHeader()
                        .AllowAnyMethod()
                        .AllowCredentials();
                });
            });

            services.Configure<SessionKeySettings>(
                configuration.GetSection("SessionKeys"));

            services.Configure<AppBaseSettings>(
                configuration.GetSection("AppBaseSettings"));

            services.Configure<SecuritySettings>(
                configuration.GetSection("SecuritySettings"));


            // 🔥 Dynamic Cookie Path Based On Environment
            var baseSettings = configuration
                .GetSection("AppBaseSettings")
                .Get<AppBaseSettings>();

            var cookiePath = environment.IsDevelopment()
                ? baseSettings?.DevelopmentPath
                : baseSettings?.ProductionPath;

            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(20);
                options.Cookie.Name = configuration["SessionSettings:CookieName"];
                options.Cookie.Path = string.IsNullOrWhiteSpace(cookiePath) ? "/" : cookiePath;
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true;
                options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
                options.Cookie.SameSite = SameSiteMode.Strict;
            });

            services.AddAntiforgery(options =>
            {
                options.Cookie.HttpOnly = true;
                options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
                options.Cookie.SameSite = SameSiteMode.Strict;
            });

            Velzon.Webs.Common.Functions.GetAllDependencyInjection(services);

            return services;
        }
    }
}
