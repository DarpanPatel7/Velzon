namespace Velzon.Model.Service
{
    public class CMSMenuMasterModel
    {
        public long Id { get; set; }
        public long MenuResId { get; set; }
        public string MenuName { get; set; }
        public string MenuType { get; set; }
        public string PageType { get; set; }
        public long? ParentId { get; set; }
        public string ParentName { get; set; }
        public string PageDescription { get; set; }
        public long MenuRank { get; set; }
        public string MenuURL { get; set; }
        public bool IsActive { get; set; }
        public bool IsFullScreen { get; set; }
        public bool IsHomePage { get; set; }
        public bool IsDelete { get; set; }
        public string CreatedBy { get; set; }
        public string? BannerImagePath { get; set; }
        public string? IconImagePath { get; set; }
    }
}
