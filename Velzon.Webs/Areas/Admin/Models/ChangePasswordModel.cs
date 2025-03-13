using System.ComponentModel.DataAnnotations;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class ChangePasswordModelOld
    {

        //[Required]
        //public string OldPassword { get; set; }

        //[Required]
        ////[RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,30}$", ErrorMessage = "Minimum eight and maximum 10 characters, at least one uppercase letter, one lowercase letter, one number and one special character.")]
        //public string NewPassword { get; set; }

        //[Required]
        //[Compare(nameof(NewPassword), ErrorMessage = "New Password and Confirm Password are mismatch")]
        //public string ConfirmPassword { get; set; }
        public int Id { get; set; }
        public string UserPassword { get; set; }
        public string CreateBy { get; set; }

    }
}
