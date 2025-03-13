namespace Velzon.Model.Service
{
    public class RoleMasterModel
    {
        public long Id { get; set; } = 0;
        public string RoleName { get; set; }
        public bool IsActive { get; set; }
        public int IsDelete { get; set; } = 0;
        public string CreatedBy { get; set; }
    }
}
