namespace Velzon.Model.Service
{
    public class VideoModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public long VideoId { get; set; }
        public string VideoTitle { get; set; }
        public string ThumbImage { get; set; }
        public string VideoName { get; set; }
        public string VideoUrl { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string Updatedby { get; set; }
        public DateTime UpdatedDate { get; set; }
        public string DeletedBy { get; set; }
        public DateTime DeletedDate { get; set; }
        public string? Username { get; set; }
        public long? islinkvideo { get; set; }
        public List<VideoNameModel>? lstVideoModels { get; set; }
    }

    public class VideoNameModel
    {
        public string VideoName { get; set; }
        public string ThumbImage { get; set; }
        public string VideoUrl { get; set; }
        public string ImageName { get; set; }
        public string ImagePath { get; set; }
        public string? ThumbFileName { get; set; }
        public string? ThumbFilePath { get; set; }
        public int urllink { get; set; }
        public long RowIndex { get; set; }

    }

    public class VideoTypeModel
    {
        public long Id { get; set; }
        public string VideoTitle { get; set; }
    }
}
