
using Velzon.Model.System;
using System.ComponentModel.DataAnnotations;


namespace Velzon.Webs.Areas.Admin.Models
{

    public class MenuRightsFilterModel
    {

        public long SelectedRoleId { get; set; }

        public List<ListItem> RoleList { get; set; }


        public long SelectedMenuId { get; set; }

        public List<ListItem> ParentMenuList { get; set; }

        public string? SubmitDisable { get; set; }
        public string? StrTable { get; set; }
    }

    public class MenuRightsFilterMainModel
    {
        public long SelectedRoleId { get; set; }

        public long? SelectedMenuId { get; set; }


    }
}
