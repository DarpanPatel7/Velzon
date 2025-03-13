namespace Velzon.Model.Service
{
    public class UserMasterModel
    {
        public long Id { get; set; }
        public long RoleId { get; set; }
        public string RoleName { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string PhoneNo { get; set; }
        public string? UserPassword { get; set; }
        public bool IsActive { get; set; }
        public bool IsPasswordReset { get; set; }
        public int IsDelete { get; set; }
        public string CreatedBy { get; set; }
        public string? ApplicantPhoto { get; set; }
        public DateTime? UpdateDate { get; set; }
    }

    /*public class ChangePasswordModel
    {
        public int Id { get; set; }
        public string UserPassword { get; set; }
        public string CreateBy { get; set; }

    }*/
    public class AttmptOrLockModel
    {
        public int AttemptsLogin { get; set; }

        public int IsLocked { get; set; }
    }
}
