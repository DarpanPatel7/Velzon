namespace Velzon.Webs.Areas.Admin.Models
{
    public class AdminMenuFromModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public long MenuId { get; set; }
        public string? MenuType { get; set; }
        public string? MenuIcon { get; set; }
        public long? ParentId { get; set; }
        public bool IsActive { get; set; }
    }
}
