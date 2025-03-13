using Velzon.Model.System;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class CMSMenuResourceFromModel
    {
        public long Id { get; set; }
        public long CMSMenuResId { get; set; }
        public List<ListItem> lstLanguage { get; set; }
        public long LanguageId { get; set; }
        public string MenuName { get; set; }
        public string MenuURL { get; set; }
        public string Tooltip { get; set; }
        public List<ListItem> lstResourceType { get; set; }
        public long ResourceType { get; set; }
        public List<ListItem> lstTemplate { get; set; }
        public int TemplateId { get; set; }
        public bool IsActive { get; set; }
    }
}

