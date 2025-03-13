namespace Velzon.Webs.Areas.Admin.Models
{
    public class PopupFormModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public string popupDescription { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public string LastUpdateBy { get; set; }
        public string CreatedBy { get; set; }
    }
}
