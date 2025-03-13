namespace Velzon.Webs.Areas.Admin.Models
{
     public class JsFormSessionModel
     {
         public JsMasterFormModel objfrmmodel { get; set; }
     }

    public class JsMasterFormModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Jsfile { get; set; }
        public bool IsActive { get; set; }

    }
}
