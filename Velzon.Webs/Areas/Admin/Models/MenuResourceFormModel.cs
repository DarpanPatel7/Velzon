namespace Velzon.Webs.Areas.Admin.Models
{
    public class MenuResourceFormModel
    {
        public long Id { get; set; }
        public string MenuName { get; set; }
        public string MenuURL { get; set; }
        public bool IsActive { get; set; }
    }
}
