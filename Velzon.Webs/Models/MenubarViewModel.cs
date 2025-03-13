using Velzon.Model.Service;

namespace Velzon.Webs.Models
{
    public class MenubarViewModel
    {
        public List<CMSMenuMasterModel> ParentMenus {get; set;}
        public List<CMSMenuMasterModel> ChildMenus {get; set;}
         
    }
}
