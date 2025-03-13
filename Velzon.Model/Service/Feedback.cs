using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class Feedback
    {
        public long Id { get; set; }

        public string FName { get; set; }
        public string LName { get; set; }
        public string Email { get; set; }
        public string MobileNo { get; set; }
        public string? Zip { get; set; }
        public string Subject { get; set; }
        public string? Country { get; set; }
        public string? State { get; set; }
        public string City { get; set; }
        public string? Address { get; set; }
        public string FeedbackDetails { get; set; }
        public string? IP { get; set; }
        public DateTime CreatedDate { get; set; }
        public string Captcha { get; set; }
        public string? hfCaptcha { get; set; }
        public string? hfEmail { get; set; }
    }
}

