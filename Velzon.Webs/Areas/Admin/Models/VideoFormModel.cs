using Velzon.Common;

namespace Velzon.Webs.Areas.Admin.Models
{
    /// Represents the model used for video forms in the admin area.
    public class VideoFormModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public long? VideoId { get; set; }
        public string VideoTitle { get; set; }
        public bool IsActive { get; set; }
        public bool IsDelete { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string Updatedby { get; set; }
        public DateTime UpdatedDate { get; set; }
        public string DeletedBy { get; set; }
        public DateTime DeletedDate { get; set; }
        public bool IsUpload { get; set; }
        public string? Username { get; set; }
        /// Gets or sets the list of video models associated with the form.
        public List<VideoNameModelform>? lstEventVideoMasterModels { get; set; }
        /// Gets the list of validation rules for the main video form.
        public List<Velzon.Common.ValidationType>? validationMainForm
        {
            get
            {
                var lstModelList = new List<Velzon.Common.ValidationType>();

                #region Validation

                lstModelList.AddRange(GetValidationTabWise());

                #endregion

                return lstModelList;
            }
        }
        /// Defines validation rules for the video form.
        private List<Velzon.Common.ValidationType> GetValidationTabWise()
        {
            var lstModelList = new List<Velzon.Common.ValidationType>();

            lstModelList.Add(
                new Velzon.Common.ValidationType
                {
                    FieldName = "VideoTitle",
                    IsRequired = true,
                    StrMessage = "Enter Title",
                    RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.LettersWithWhiteSpace),
                    StrRegExMessage = "Enter Character Only for Video Title",
                    CharacterMinLength = 5,
                    CharacterMaxLength = 100,
                    IsFormClickTab = false,
                    StrTypeMessage = "Video title length should be between 5 to 100."
                });       
            
            return lstModelList;
        }
    }

    /// Represents the model for video names in the form.
    public class VideoNameModelform
    {
        public string VideoName { get; set; }
        public string ThumbImage { get; set; }
        public string VideoUrl { get; set; }
        public int urllink { get; set; }
        public long RowIndex { get; set; }
        public List<IFormFile> ThumbFile { get; set; }
        public string? ThumbFileName { get; set; }
        public string? ThumbFilePath { get; set; }
        public List<IFormFile> Image { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
   

        // Gets the list of validation rules for the video name model.
        public List<Velzon.Common.ValidationType>? validationMainFormv
        {
            get
            {
                var lstModelList = new List<Velzon.Common.ValidationType>();

                #region Validation

                lstModelList.AddRange(getvideovalidations());

                #endregion

                return lstModelList;
            }
        }

        // Defines validation rules for the video name model.
        private List<Velzon.Common.ValidationType>? getvideovalidations()
        {
            var lstModelList = new List<Velzon.Common.ValidationType>();

            lstModelList.Add(
                new Velzon.Common.ValidationType
                {
                    FieldName = "VideoName",
                    IsRequired = true,
                    StrMessage = "Enter Title",
                    RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.LettersWithWhiteSpace),
                    StrRegExMessage = "Enter Character Only for Video Name",
                    CharacterMinLength = 5,
                    CharacterMaxLength = 100,
                    IsFormClickTab = false,
                    StrTypeMessage = "Video title length should be between 5 to 100."
                });
            lstModelList.Add(
                new Velzon.Common.ValidationType
                {
                    FieldName = "ThumbImage",
                    IsRequired = true,
                    StrMessage = "Enter Thumb Image Url",
                    RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.Url),
                    StrRegExMessage = "Enter proper thumbImage url.",
                    CharacterMinLength = 5,
                    CharacterMaxLength = 350,
                    IsFormClickTab = false,
                    StrTypeMessage = "Enter Thumb Image Url."
                });
            lstModelList.Add(
               new Velzon.Common.ValidationType
               {
                   FieldName = "VideoUrl",
                   IsRequired = true,
                   StrMessage = "Enter Video Url",
                   RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.Url),
                   StrRegExMessage = "Enter proper video url.",
                   CharacterMinLength = 5,
                   CharacterMaxLength = 350,
                   IsFormClickTab = false,
                   StrTypeMessage = "Enter Video Url."
               });
            return lstModelList;
        }
    }
}
