using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.Extensions.Options;
using Velzon.Webs.Common;
using Velzon.Webs.Models;

namespace Velzon.Webs.Extensions
{
    public static class ApplicationExtensions
    {
        private const string CorsPolicy = "_myAllowSpecificOrigins";

        public static WebApplication UseApplication(this WebApplication app)
        {
            var env = app.Environment;

            var baseSettings = app.Services
                .GetRequiredService<IOptions<AppBaseSettings>>().Value;

            var basePath = env.IsDevelopment()
                ? baseSettings.DevelopmentPath
                : baseSettings.ProductionPath;

            if (!string.IsNullOrWhiteSpace(basePath) && basePath != "/")
                app.UsePathBase(basePath);

            var sessionKeySettings = app.Services
                .GetRequiredService<IOptions<SessionKeySettings>>().Value;

            SessionKeys.Initialize(sessionKeySettings, basePath);

            if (!env.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }

            app.UseHttpsRedirection();

            app.UseForwardedHeaders(new ForwardedHeadersOptions
            {
                ForwardedHeaders =
                    ForwardedHeaders.XForwardedFor |
                    ForwardedHeaders.XForwardedProto
            });

            app.UseResponseCaching();
            app.UseStatusCodePages(async context =>
            {
                var requestPath = context.HttpContext.Request.Path;
                var response = context.HttpContext.Response;

                if (response.StatusCode == 404)
                {
                    if (requestPath.StartsWithSegments("/Admin", StringComparison.OrdinalIgnoreCase))
                    {
                        response.Redirect("/Admin/Error/404");
                    }
                    else
                    {
                        response.Redirect("/Error/404");
                    }
                }
            });

            app.UseStaticFiles(new StaticFileOptions
            {
                OnPrepareResponse = context =>
                {
                    var requested = context.Context.Request.Path.Value;
                    var onDisk = context.File.PhysicalPath.Replace("\\", "/");

                    if (!string.IsNullOrEmpty(requested) &&
                        !onDisk.EndsWith(requested))
                    {
                        throw new Exception(
                            $"Incorrect casing detected.\nRequested: {requested}\nOn disk: {onDisk}");
                    }
                }
            });

            app.UseMiddleware<SecurityHeadersMiddleware>(basePath);

            app.UseRouting();
            app.UseCors(CorsPolicy);
            app.UseSession();
            app.UseAuthorization();

            return app;
        }

        public static WebApplication MapApplication(this WebApplication app)
        {
            app.MapControllers().RequireCors(CorsPolicy);

            app.MapControllerRoute(
                name: "areas",
                pattern: "{area:exists}/{controller=Home}/{action=Dashboard}/{id?}");

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=HomePage}/{id?}");

            return app;
        }
    }
}
