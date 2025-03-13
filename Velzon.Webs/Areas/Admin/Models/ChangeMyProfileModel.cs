using System.ComponentModel;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class ChangeMyProfileModel
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Email { get; set; }

        [ReadOnly(true)]
        public string UserName { get; set; }

        public string PhoneNo { get; set; }

        public bool IsActive { get; set; }
    }
}
