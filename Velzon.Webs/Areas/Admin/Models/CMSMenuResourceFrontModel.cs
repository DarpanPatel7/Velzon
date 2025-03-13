namespace Velzon.Webs.Areas.Admin.Models
{
    public class CMSMenuResourceFrontModel
    {
        public long Id { get; set; }
        public long? CMSMenuResId { get; set; }
        public long? LanguageId { get; set; }
        public string MenuName { get; set; }
        public string MenuURL { get; set; }
        public string? Tooltip { get; set; }
        public string? PageDescription { get; set; }
        public string? ResourceType { get; set; }
        public string? TemplateId { get; set; }
        public bool IsActive { get; set; }
        public bool IsRedirect { get; set; }
        public bool IsFullScreen { get; set; }
        public string? col_menu_type { get; set; }
        public long? col_parent_id { get; set; }
        public long Rank { get; set; }
        public string? MetaTitle { get; set; }
        public string? MetaDescription { get; set; }
        public IFormFile? BannerImage { get; set; }
        public IFormFile? IconImage { get; set; }
        public string? BannerImagePath { get; set; }
        public string? IconImagePath { get; set; }

    }
}