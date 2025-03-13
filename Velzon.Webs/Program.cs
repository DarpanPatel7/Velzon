using Velzon.Common;
using Velzon.Webs.Common;
using Microsoft.AspNetCore.Antiforgery;
using Microsoft.AspNetCore.HttpOverrides;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Rewrite;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using System.Net;

IConfigurationRoot Configuration;
var MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

var builder = WebApplication.CreateBuilder(args);
DapperConnection.isDevlopment = true;
#region Connection string read
var config = new ConfigurationBuilder().AddJsonFile("appsettings.json", optional: false, reloadOnChange: true);
Configuration = config.Build();

DapperConnection.connectionString = Configuration.GetConnectionString("ApplicationContextConnection");

Velzon.Webs.Common.Functions.regGlobalValidation = Configuration.GetSection("RegexPatterns").GetSection("Global").Value;
Velzon.Webs.Common.Functions.regName = Configuration.GetSection("RegexPatterns").GetSection("Name").Value;
Velzon.Webs.Common.Functions.regMobileNo = Configuration.GetSection("RegexPatterns").GetSection("MobileNo").Value;
Velzon.Webs.Common.Functions.regPincode = Configuration.GetSection("RegexPatterns").GetSection("Pincode").Value;
Velzon.Webs.Common.Functions.regNumber = Configuration.GetSection("RegexPatterns").GetSection("Number").Value;
Velzon.Webs.Common.Functions.regEmail = Configuration.GetSection("RegexPatterns").GetSection("Email").Value;
Velzon.Webs.Common.Functions.regPassword = Configuration.GetSection("RegexPatterns").GetSection("Password").Value;
Velzon.Webs.Common.Functions.regURL = Configuration.GetSection("RegexPatterns").GetSection("URL").Value;

builder.Services.AddHealthChecks();

#endregion

// Add services to the container.MinimumSameSitePolicy
builder.Services.AddControllersWithViews(options =>
{
    options.Filters.Add<CustomResultFilterAttribute>();
});

builder.Services.AddHttpContextAccessor();
builder.Services.AddHttpClient();

builder.Services.Configure<IISServerOptions>(options => {
    options.MaxRequestBodySize = long.MaxValue;
});

builder.Services.Configure<KestrelServerOptions>(options =>
{
    options.Limits.MaxRequestBodySize = long.MaxValue;
});

#region Session Property Assign


builder.Services.AddCors(options => {
    options.AddPolicy(MyAllowSpecificOrigins,
                builder => builder.WithOrigins("https://localhost:1001", "https://staging-gil1.gujarat.gov.in")
                    .AllowAnyMethod()
                    .AllowAnyHeader());
});

// Configure application cookie settings for authentication
/*builder.Services.ConfigureApplicationCookie(options =>
{
    options.Cookie.HttpOnly = true;
    options.Cookie.SecurePolicy = CookieSecurePolicy.Always; // Ensure cookies are sent over HTTPS
    options.Cookie.SameSite = SameSiteMode.Strict; // or SameSiteMode.Lax as required
});*/
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(20);
    options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
    //options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
    options.Cookie.SameSite = SameSiteMode.Strict;
    options.Cookie.HttpOnly = true;
});

builder.Services.AddResponseCaching();

builder.Services.AddControllers(options =>
{
    options.CacheProfiles.Add("Default",
        new Microsoft.AspNetCore.Mvc.CacheProfile()
        {
            Duration = 0,
            Location = Microsoft.AspNetCore.Mvc.ResponseCacheLocation.None,
            NoStore = true
        });
});

builder.Services.Configure<MvcViewOptions>(options =>
{
    // Disable hidden checkboxes
    //options.HtmlHelperOptions.CheckBoxHiddenInputRenderMode = CheckBoxHiddenInputRenderMode.None;
});


#endregion

#region Dependency Injection
builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
Velzon.Webs.Common.Functions.GetAllDependencyInjection(builder.Services);
#endregion

//builder.WebHost.UseKestrel(option => option.AddServerHeader = false);

var app = builder.Build();


#region AntiForgery

var antiforgery = app.Services.GetRequiredService<IAntiforgery>();

app.Use(async (context, next) =>
{
    {
        context.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
        context.Response.Headers.Add("X-Frame-Options", "DENY");
        context.Response.Headers.Add("Referrer-Policy", "no-referrer");
        //context.Response.Headers.Add("Permissions-Policy", "geolocation=self");
        context.Response.Headers.Add("Cache-Control", "nosniff");
        context.Response.Headers.Add("X-YOURSITE-CSRF-PROTECTION", "1");
        //context.Response.Headers.Add("Access-Control-Allow-Origin", "https://staging-gil1.gujarat.gov.in/velzon/");
        //context.Response.Headers.Add("Access-Control-Allow-Origin", "https://localhost:1001/");
        context.Response.Headers.Add("Access-Control-Allow-Credentials", "true");
        context.Response.Headers.Add("Access-Control-Allow-Methods", "POST, GET");
        context.Response.Headers.Add("Access-Control-Allow-Headers", "Content-Type, x-requested-with");
        context.Response.Headers.Add("X-Permitted-Cross-Domain-Policies", "none");
        context.Response.Headers.Add("Expect-CT", "\"max-age=0, enforce, report-uri=\\\"https://example.report-uri.com/r/d/ct/enforce\\\"\"");
        context.Response.Headers.Add("Feature-Policy", "accelerometer 'none'; camera 'none'; geolocation 'none'; gyroscope 'none'; magnetometer 'none'; microphone 'none'; payment 'none'; usb 'none'");
        //context.Response.Headers.Add("Content-Type", "text/html; charset=utf-8");
        context.Response.Headers.Add("X-Content-Type-Options", "nosniff");
        //context.Response.Headers.Add("Content-Security-Policy", "https://staging-gil1.gujarat.gov.in/velzon/ 'self';");
        //context.Response.Headers.Add("Content-Security-Policy", "https://localhost:1001/ 'self';");
        //context.Response.Headers.Add("Cross-Origin-Embedder-Policy", "unsafe-none");
        //context.Response.Headers.Add("Cross-Origin-Opener-Policy", "unsafe-none");
        //context.Response.Headers.Add("Cross-Origin-Resource-Policy", "same-origin");
        context.Response.Headers.Remove("Server");
        context.Response.Headers.Add("Strict-Transport-Security", "max-age=31536000; includeSubDomains");

        var requestPath = context.Request.Path.Value;

        if (string.Equals(requestPath, "/", StringComparison.OrdinalIgnoreCase)
            || string.Equals(requestPath, "/index.html", StringComparison.OrdinalIgnoreCase))
        {
            var tokenSet = antiforgery.GetAndStoreTokens(context);
            context.Response.Cookies.Append("XSRF-TOKEN", tokenSet.RequestToken!,
                new CookieOptions { HttpOnly = true, Secure = true, SameSite = SameSiteMode.Strict });
        }

        await next(context);
    }
});

#endregion


//app.UseHealthChecks("/Account/DBStatus");

app.UseResponseCaching();

app.UseStatusCodePages();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    DapperConnection.isDevlopment = false;
    app.UseExceptionHandler("/Home/Error");
    app.UseHttpsRedirection();
    app.UseHsts();
}

app.UseSession();

app.UseForwardedHeaders(new ForwardedHeadersOptions { ForwardedHeaders = ForwardedHeaders.XForwardedFor | ForwardedHeaders.XForwardedProto });

app.UsePathBase("/velzon");


app.UseStaticFiles(new StaticFileOptions()

{
    OnPrepareResponse = x =>
    {

        if (!x.File.Exists) return;

        var requested = x.Context.Request.Path.Value;

        if (string.IsNullOrEmpty(requested)) return;


        var onDisk = x.File.PhysicalPath.Replace("\\", "/");

        if (!onDisk.EndsWith(requested))
        {
            /*throw new Exception("The requested file has incorrect casing and will fail on Linux servers." +

            Environment.NewLine + "Requested:" + requested + Environment.NewLine +

            "On disk: ");*/
        }
    }
});

app.UseRouting();

app.UseAuthorization();

app.UseCors(MyAllowSpecificOrigins);

#region Route Details Syntax

//app.UseMiddleware<MyMiddleware>();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers()
            .RequireCors(MyAllowSpecificOrigins);

    endpoints.MapControllerRoute(
      name: "areas",
      pattern: "{area:exists}/{controller=Home}/{action=Dashboard}/{id?}"
    );
});

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=HomePage}/{id?}");

#endregion


app.UseAuthorization();

app.Run();
