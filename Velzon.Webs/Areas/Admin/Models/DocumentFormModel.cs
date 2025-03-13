namespace Velzon.Webs.Areas.Admin.Models
{
    public class DocumentFormModel
    {
        public long Doc_Id { get; set; }
        public string? Doc_Name { get; set; }
        public string? File_Name { get; set; }
        public string? Doc_Path { get; set; }
        public IFormFile? CouchFile { get; set; }
        public long LanguageId { get; set; }
        public bool IsActive { get; set; }
    }
}
