namespace Velzon.Model.Service
{
    public class MenuRightsMasterModel
    {
        public long Id { get; set; }
        public long MenuRank { get; set; }
        public long MenuResourceId { get; set; }
        public string MenuResourceName { get; set; }
        public string Name { get; set; }
        public string MenuType { get; set; }
        public long ParentId { get; set; }
        public string ParentName { get; set; }
        public string MenuURL { get; set; }
        public bool Insert { get; set; }
        public bool Update { get; set; }
        public bool Delete { get; set; }
        public bool View { get; set; }
        public string LastUpdateBy { get; set; }

    }
}
