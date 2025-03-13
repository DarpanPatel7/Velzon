using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
  
    public class UtilityModel
    {
        public long Id { get; set; }

        public long UserId { get; set; }

        public long FormUserId { get; set; }

        public string? UserName { get; set; }

        public string? Details { get; set; }

        public string? IpAddress { get; set; }

        public bool WrongAttempt { get; set; }

        public int plock { get; set; }

        public bool IsLock { get; set; }

        public string? LockStatus { get; set; }
    }
}
