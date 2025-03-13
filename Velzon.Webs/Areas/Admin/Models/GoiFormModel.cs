namespace Velzon.Webs.Areas.Admin.Models
{
    public class GoiFormModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public string? LogoName { get; set; }
        public IFormFile? LogoImage { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public string? Url { get; set; }
        public bool IsActive { get; set; }
    }
}
