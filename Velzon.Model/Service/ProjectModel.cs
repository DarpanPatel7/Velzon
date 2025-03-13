namespace Velzon.Model.Service;

public class ProjectModel
{
    public long Id { get; set; }
    public long? ProjectMasterId { get; set; }
    public long? LanguageId { get; set; }
    public string? ProjectName { get; set; }
    public string? Description { get; set; }
    public string? ProjectBy { get; set; }
    public DateTime? ProjectDate { get; set; }
    public string? FileUpload { get; set; }
    public string? File { get; set; }

    public string? FilePath { get; set; }
    public bool IsActive { get; set; }
    public bool IsDelete { get; set; }
    public string? CreatedBy { get; set; }
    public string? UpdatedBy { get; set; }

    //public DateTime CreatedDate{ get;set;}
    public string? Location { get; set; }
    public string? MetaTitle { get; set; }
    public string? MetaDescription { get; set; }
    public long ProjectRank { get; set; }
}