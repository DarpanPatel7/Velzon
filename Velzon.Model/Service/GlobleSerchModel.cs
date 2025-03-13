using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class GlobleSerchModel
    {
        public int Id { get; set; }
        public string pagepath { get; set; }
        public string pathdata { get; set; }
        public int LanguageId { get; set; }
        public string MetaTitle { get; set; }
        public string MetaDescription { get; set; }
    }
}
