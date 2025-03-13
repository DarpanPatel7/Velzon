namespace Velzon.Webs.Areas.Admin.Models
{
    public class GalleryFormModel
    {
        public long? Id { get; set; }
        public long? GallerymasterId { get; set; }
        public int LanguageId { get; set; }
        public string PlaceName { get; set; }

        public IFormFile? ThumbImage { get; set; }

        public string? ThumbImageName { get; set; }
        public string? ThumbImagePath { get; set; }
        public string? FirstImagePath { get; set; }
        public bool IsActive { get; set; }
        public bool IsVideo { get; set; }
        public long AlbumRank { get; set; }

        public List<EventImageModel>? lstEventImagesMasterModels { get; set; }
    }


    public class EventImageModel
    {
        public long RowIndex { get; set; }
        public bool IsVideoGallery { get; set; }
        public string Command { get; set; }
        public List<IFormFile> Image { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }


    }
}
