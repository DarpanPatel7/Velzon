using Velzon.Common;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class UtilityFormModel
    {
        public long Id { get; set; }

        public long UserId { get; set; }

        public long FormUserId { get; set; }

        public string? UserName { get; set; }

        public string? Details { get; set; }

        public string? IpAddress { get; set; }

        public bool WrongAttempt { get; set; }

        public bool IsActive { get; set; }

        public bool IsStoreDB { get; set; } = false;

        public int plock { get; set; }
    }
}
