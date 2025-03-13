namespace Velzon.Model.Service
{
    public class CMSStatisticGridModel
    {
        public long? StatisticTypeId { get; set; }
    }

    public class StatisticModel
    {
        public long Id { get; set; }
        public long? StatisticDataId { get; set; }
        public long LanguageId { get; set; }
        public long? StatisticTypeId { get; set; }
        public string? StatisticTypeName { get; set; }
        public string? Title { get; set; }       
        public string? Count { get; set; }       
        public string? Url { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public bool IsActive { get; set; }   
    }

    public class StatisticType
    {
        public long? Id { get; set; }
        public string? Name { get; set; }
        public string? Validate { get; set; }
    }
}
