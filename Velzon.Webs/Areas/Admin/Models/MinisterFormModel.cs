using Microsoft.AspNetCore.Http;

namespace Velzon.Webs.Areas.Admin.Models

{
    public class MinisterFormModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public string MinisterName { get; set; }
        public string MinisterDescription { get; set; }
        public bool IsStoreDB { get; set; } = false;
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public IFormFile? MinisterImage { get; set; }
        public bool IsActive { get; set; }
        public long MinisterRank { get; set; }
        public string? MetaTitle { get; set; }
        public string? MetaDescription { get; set; }
        //  public long MinisterSection { get; set; }
        // public string? SectionNameENG { get; set; }
        // public string? SectionNameGuj { get; set; }
    }
}
