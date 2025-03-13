namespace Velzon.Webs.Areas.Admin.Models
{
    public class BannerFormModel
    {
        public long Id { get; set; }
        public long BannerId { get; set; }
        public long LanguageId { get; set; }
        public string? Title { get; set; }
        public string? URL { get; set; }
        public IFormFile? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public string? Description { get; set; }
        public bool IsActive { get; set; }
        public bool IsStoreDB { get; set; } = false;
    }
}
