using Microsoft.AspNetCore.Antiforgery;
using Microsoft.Extensions.Options;
using Velzon.Webs.Models;

namespace Velzon.Webs.Extensions
{
    public class SecurityHeadersMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IAntiforgery _antiforgery;
        private readonly IWebHostEnvironment _env;
        private readonly string _basePath;
        private readonly SecuritySettings _settings;

        public SecurityHeadersMiddleware(
            RequestDelegate next,
            IAntiforgery antiforgery,
            IWebHostEnvironment env,
            string basePath,
            IOptions<SecuritySettings> options)
        {
            _next = next;
            _antiforgery = antiforgery;
            _env = env;
            _basePath = basePath;
            _settings = options.Value;
        }

        public async Task Invoke(HttpContext context)
        {
            var headers = context.Response.Headers;

            var allowedOrigins = string.Join(" ", _settings.CspOrigins);
            
            headers["X-Content-Type-Options"] = "nosniff";
            headers["X-Frame-Options"] = "DENY";
            headers["X-XSS-Protection"] = "1; mode=block";
            //headers["Referrer-Policy"] = "no-referrer";
            if (context.Request.Path.StartsWithSegments("/VideoGallery") || context.Request.Path.StartsWithSegments("/GetVideo"))
            {
                headers["Referrer-Policy"] = "strict-origin-when-cross-origin";
            }
            else
            {
                headers["Referrer-Policy"] = "no-referrer";
            }
            headers["X-Permitted-Cross-Domain-Policies"] = "none";
            headers["Cross-Origin-Opener-Policy"] = "same-origin";
            headers["Cross-Origin-Embedder-Policy"] = "unsafe-none";
            headers["Cross-Origin-Resource-Policy"] = "same-origin";
            headers["Permissions-Policy"] = "geolocation=self";
            headers["Cache-Control"] = "nosniff";
            headers["X-YOURSITE-CSRF-PROTECTION"] = "1";
            headers["Access-Control-Allow-Origin"] = $"{allowedOrigins}";
            headers["Access-Control-Allow-Credentials"] = "true";
            headers["Access-Control-Allow-Methods"] = "POST, GET";
            headers["Access-Control-Allow-Headers"] = "Content-Type, x-requested-with";
            headers["Expect-CT"] = "\"max-age=0, enforce, report-uri=\\\"https://example.report-uri.com/r/d/ct/enforce\\\"\"";
            headers["Feature-Policy"] = "accelerometer 'none'; camera 'none'; geolocation 'none'; gyroscope 'none'; magnetometer 'none'; microphone 'none'; payment 'none'; usb 'none'";
            headers["Content-Security-Policy"] = $"{allowedOrigins} 'self';";
            // for audit
            /*headers["Content-Security-Policy"] =
            $"default-src 'self'; " +
            $"script-src 'self' {allowedOrigins} https://cdn.datatables.net https://cdn.jsdelivr.net https://translate.googleapis.com 'unsafe-inline'; " +
            $"style-src 'self' {allowedOrigins} https://stackpath.bootstrapcdn.com https://translate.googleapis.com https://fonts.googleapis.com 'unsafe-inline'; " +
            $"img-src 'self' data: blob:; " +
            $"media-src 'self' blob: {allowedOrigins}; " +
            $"font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com https://pixinvent.com data:; " +
            //$"connect-src 'self' {allowedOrigins}:* ws:{allowedOrigins}:* wss:{allowedOrigins}:*; " +
            $"connect-src 'self'; " +
            $"object-src 'none'; " +
            $"frame-ancestors 'none'; " +
            $"base-uri 'self'; " +
            $"form-action 'self';";*/
            context.Response.Headers.Remove("Server");

            if (!_env.IsDevelopment())
            {
                headers["Strict-Transport-Security"] =
                    "max-age=31536000; includeSubDomains";
            }

            var requestPath = context.Request.Path.Value;

            if (requestPath == "/" ||
                requestPath?.Equals("/index.html",
                StringComparison.OrdinalIgnoreCase) == true)
            {
                var tokens = _antiforgery.GetAndStoreTokens(context);

                context.Response.Cookies.Append("XSRF-TOKEN",
                    tokens.RequestToken!,
                    new CookieOptions
                    {
                        HttpOnly = true,
                        Secure = true,
                        SameSite = SameSiteMode.Strict,
                        Path = string.IsNullOrWhiteSpace(_basePath) ? "/" : _basePath
                    });
            }

            await _next(context);
        }
    }
}
