using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class SessionUserModel
    {
        public long Id { get; set; }

        public long RoleId { get; set; }

        public string FirstName { get; set; }

        public string MiddleName { get; set; }

        public string LastName { get; set; }

        public string Email { get; set; }

        public string Username { get; set; }

        public string PhoneNo { get; set; }

        public string Address { get; set; }

        public string UserPassword { get; set; }

        public string? ProfilePic { get; set; }

        public bool IsActive { get; set; }

        public bool IsPasswordReset { get; set; }

        public bool IsLockUser { get; set; }

        public bool IsRoleActive { get; set; }

        public bool IsChangeProfile { get; set; }

        public string? LandingPage { get; set; }

        public string? ApplicantPhotoPath { get; set; }

        public DateTime? UpdateDate { get; set; }

        public string? Designation { get; set; }

        public string? SessionVersion { get; set; }
    }
}
