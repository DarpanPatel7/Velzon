namespace Velzon.Model.Service
{
    public class CMSTemplateModel
    {
        public long Id { get; set; }
        public long? TemplateId { get; set; }
        public long LanguageId { get; set; }
        public string TemplateName { get; set; }
        public string? Content { get; set; }
        public string TemplateType { get; set; }
        public bool IsActive { get; set; }
    }
}
