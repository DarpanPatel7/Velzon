namespace Velzon.Webs.Areas.Admin.Models
{
    public class CssFormSessionModel
    {
        public CssMasterFormModel objfrmmodel { get; set; }
    }

    public class CssMasterFormModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Cssfile { get; set; }
        public bool IsActive { get; set; }

    }
}
