using Microsoft.AspNetCore.Http;
using System.Text.Json.Serialization;

namespace Velzon.Model.CouchDB
{
    public class SaveCouchDBAttachment
    {
        [JsonIgnore]
        public string Id { get; set; }
        [JsonIgnore]
        public string Rev { get; set; }
        [JsonIgnore]
        public IFormFile File { get; set; }
        public string FileName { get; set; }
        public string FileExtension { get; set; }
        [JsonIgnore]
        public byte[] AttachmentData { get; set; }
    }
}
