using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class CMSEcitizenGridModel
    {
        public long? EcitizenTypeId { get; set; }
    }
    public class BranchModel
    {
        public long Id { get; set; }
        public long BranchId { get; set; }
        public long LanguageId { get; set; }
        public string? BranchName { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string? UpdatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
        public string? DeleteBy { get; set; }
        public DateTime DeletedDate { get; set; }
        public string? Username { get; set; }
    }
}
