using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service
{
    public class NewsModel
    {
        public long Id { get; set; }
        public long NewsId { get; set; }
        public long LanguageId { get; set; }
        public string NewsTypeId { get; set; }
        public string? NewsTitle { get; set; }
        public string? ShortDescription { get; set; }
        public string NewsDesc { get; set; }
        public string? NewsBy { get; set; }
        public DateTime? PublicDate { get; set; }
        public DateTime? ArchiveDate { get; set; }
        public DateTime CreatedDate { get; set; }
        public string? NewsDate { get; set; }
        public string? DateDisplay { get; set; }
        public string? IndexFrontDateDisplay { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public string? Location { get; set; }
        public string? NewsTypeText { get; set; }
        public string? NewsTypeName { get; set; }
        public bool IsActive { get; set; }
        public bool IsLink { get; set; }
        public string? MetaTitle { get; set; }
        public string? MetaDescription { get; set; }
    }

    public class NewsType
    {
        public long? Id { get; set; }
        public string? Name { get; set; }
        public string? Validate { get; set; }
    }
}
