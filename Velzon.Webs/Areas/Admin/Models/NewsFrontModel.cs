namespace Velzon.Webs.Areas.Admin.Models
{
    public class NewsFrontModel
    {
        public long Id { get; set; }
        public long? NewsId { get; set; }
        public long LanguageId { get; set; }
        public string NewsTypeId { get; set; }
        public string? NewsTitle { get; set; }
        public string? ShortDescription { get; set; }
        public string NewsDesc { get; set; }
        public string? NewsBy { get; set; }
        public string? PublicDate { get; set; }
        public string? ArchiveDate { get; set; }
        public IFormFile? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public string? Location { get; set; }
        public bool IsActive { get; set; }
        public bool IsLink { get; set; }
        public string? MetaTitle { get; set; }
        public string? MetaDescription { get; set; }
    }
}
