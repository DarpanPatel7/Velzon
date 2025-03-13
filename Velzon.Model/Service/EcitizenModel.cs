using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class CMSBranchGridModel
    {
        public long? lgLangId { get; set; }
    }

    public class EcitizenModel
    {
        public long? Id { get; set; }
        public long? LanguageId { get; set; }
        public long? EcitizenId { get; set; }
        public DateTime? Date { get; set; }
        public string? Number { get; set; }
        public long? EcitizenTypeId { get; set; }
        public string? Subject { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public string? EcitizenPhoto { get; set; }
        public string? EcitizenDateDisplay { get; set; }
        public string? IndexFrontDateDisplay { get; set; }
        public string? Rownum { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public DateTime CreatedDate { get; set; }
        public string LastUpdateBy { get; set; }
        public string CreatedBy { get; set; }
        public string EcitizenTypeName { get; set; }
        public string? BranchId { get; set; }
        public string? BranchName { get; set; }
    }

    public class EcitizenType
    {
        public long? Id { get; set; }
        public string? Name { get; set; }
        public string? Validate { get; set; }
    }
}
