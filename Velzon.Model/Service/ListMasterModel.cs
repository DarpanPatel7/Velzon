namespace Velzon.Model.Service
{
    #region Ecitizen Section
    public class GovernmentResolutionListMasterModel
    {
        public List<EcitizenModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class NotificationCircularListMasterModel
    {
        public List<EcitizenModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class TenderListMasterModel
    {
        public List<EcitizenModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class NewsListMasterModel
    {
        public List<NewsModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class RightToInformationListMasterModel
    {
        public List<EcitizenModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class ActAndRuleListMasterModel
    {
        public List<EcitizenModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class DownloadListMasterModel
    {
        public List<EcitizenModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class OtherListMasterModel
    {
        public List<EcitizenModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }
    #endregion

    #region Gallery Section
    public class PhotoGalleryListMasterModel
    {
        public List<AlbumModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class PhotoGalleryDetailListMasterModel
    {
        public List<GalleryImagesModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class VideoGalleryListMasterModel
    {
        public List<VideoModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class VideoGalleryDetailListMasterModel
    {
        public List<VideoModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    public class ProjectListMasterModel
    {
        public List<ProjectModel> ResultList { get; set; }
        public int PageCount { get; set; }
        public int CurrentPageList { get; set; }
        public int PerPage { get; set; }
    }

    #endregion
}
