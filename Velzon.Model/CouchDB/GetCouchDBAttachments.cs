using Newtonsoft.Json;

namespace Velzon.Model.CouchDB
{
    public class GetCouchDBAttachments
    {
        [JsonProperty("Docs")]
        public List<AttachmentInfo> Docs { get; set; }
    }
    public class AttachmentInfo
    {
        [JsonProperty("_id")]
        public string Id { get; set; }
        [JsonProperty("_rev")]
        public string Rev { get; set; }
        public string FileExtension { get; set; }
        public string FileName { get; set; }
    }
}
