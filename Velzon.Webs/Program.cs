using Velzon.Webs.Extensions;

var builder = WebApplication.CreateBuilder(args);

// Custom configuration (Moved to Extension)
builder.ConfigureCustomSettings();

// Services (Moved to Extension)
builder.Services.AddAppServices(builder.Configuration, builder.Environment);

builder.WebHost.UseKestrel(o => o.AddServerHeader = false);

var app = builder.Build();

// All Pipelines (Moved to Extension)
app.UseApplication();

// Endpoints (Moved to Extension)
app.MapApplication();

app.Run();
