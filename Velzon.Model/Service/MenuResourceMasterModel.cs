using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class MenuResourceMasterModel
    {
        public long Id { get; set; }
        public string MenuName { get; set; }
        public string MenuURL { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public string CreatedBy { get; set; }
    }
}
