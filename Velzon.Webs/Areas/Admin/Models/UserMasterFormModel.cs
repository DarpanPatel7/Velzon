using Velzon.Model.System;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class UserMasterFormModel
    {
        public long Id { get; set; }
        public long RoleId { get; set; }
        public List<ListItem>? RoleList { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string PhoneNo { get; set; }
        public string UserPassword { get; set; }
        public bool IsActive { get; set; }
        public bool IsPasswordReset { get; set; }
        public string CreatedBy { get; set; }
    }
}
