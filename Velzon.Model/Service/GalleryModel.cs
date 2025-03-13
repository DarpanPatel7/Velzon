namespace Velzon.Model.Service
{
    public class GalleryImagesModel
    {
        public long Id { get; set; }
        public long gallerymasterId { get; set; }
        public string ImageName { get; set; }
        public string ImagePath { get; set; }
        public string PlaceName { get; set; }
    }

    public class GalleryModel
    {
        public long Id { get; set; }
        public long GallerymasterId { get; set; }
        public int LanguageId { get; set; }
        public string PlaceName { get; set; }

        public string? ThumbImageName { get; set; }
        public string? ThumbImagePath { get; set; }
        public string? FirstImagePath { get; set; }

        public bool IsActive { get; set; }
        public bool IsVideo { get; set; }
        public long AlbumRank { get; set; }
        public string CreateBy { get; set; }

        public List<GalleryImagesModel> lstGalleryImagesModels { get; set; }
    }

    public class EventTypeModel
    {
        public long Id { get; set; }
        public string PlaceName { get; set; }
    }

    public class AlbumModel
    {
        public long Id { get; set; }
        public long GallerymasterId { get; set; }
        public string PlaceName { get; set; }
        public string FirstImagePath { get; set; }

    }
}