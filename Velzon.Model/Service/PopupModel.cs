using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class PopupModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public string popupDescription { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public string LastUpdateBy { get; set; }
        public string CreatedBy { get; set; }
    }
}
