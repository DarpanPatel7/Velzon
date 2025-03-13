using System.ComponentModel.DataAnnotations;

namespace Velzon.Webs.Models
{
    public class LoginViewModel
    {
        [Required]
        public string Username { get; set; }

        public string Password { get; set; }

        public string Captcha { get; set; }
        public string? hfCaptcha { get; set; }

        //public string Password { get; set; }

    }
}
