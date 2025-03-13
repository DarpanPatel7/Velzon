using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class MinisterModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public long MinisterID { get; set; }
        public string MinisterName { get; set; }
        public string MinisterDescription { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public string MinisterPhoto { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public string LastUpdateBy { get; set; }
        public string CreatedBy { get; set; }
        public long MinisterRank { get; set; }
        //  public long MinisterSection { get; set; }
        // public string SectionName { get; set; }
        public string? MetaTitle { get; set; }
        public string? MetaDescription { get; set; }




    }
}
