namespace Velzon.Webs.Areas.Admin.Models
{
    public class ChangeCouchDBModel
    {
        public string CouchDBURL { get; set; }
        public string CouchDBDbName { get; set; }
        public string CouchDBUser { get; set; }
        public bool AllowCouchDBStore { get; set; }
    }
}
