namespace Velzon.Webs.Areas.Admin.Models;

public class ProjectMasterModel
{
    public long Id { get; set; }
    public long? ProjectMasterId { get; set; }

    public long? LanguageId { get; set; }
    public string? ProjectName { get; set; }
    public string? Description { get; set; }
    public string? ProjectBy { get; set; }
    public string? ProjectDate { get; set; }
    public string? FileUpload { get; set; }
    public IFormFile? File { get; set; }
    public string? FilePath { get; set; }
    public bool IsActive { get; set; }
    public bool IsDelete { get; set; }
    public DateTime? CreatedBy { get; set; }
    public DateTime? UpdatedBy { get; set; }

    //public DateTime CreatedDate{ get;set;}
    public string? Location { get; set; }
    public string? MetaTitle { get; set; }
    public string? MetaDescription { get; set; }
}