using Microsoft.AspNetCore.Http;

namespace Velzon.Model.Service;

public class ServiceRateModel
{
    public long Id { get; set; }
    public long LanguageId { get; set; }
    public long ServiceRateId { get; set; }
    public string ServiceName { get; set; }
    public string? ShortDescription { get; set; }    
    public string ServiceDescription { get; set; }
    public bool IsStoreDB { get; set; } = false;
    public string? ImageName { get; set; }
    public string? ImagePath { get; set; }
    public IFormFile? ServiceImage { get; set; }
    public bool IsActive { get; set; }
    public long ServiceRank { get; set; }
    public string? MetaTitle { get; set; }
    public string? MetaDescription { get; set; }
    public string? Icon { get; set; }
    public string? CreatedBy  { get; set; }
}
