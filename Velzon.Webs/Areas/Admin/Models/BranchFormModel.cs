using Velzon.Common;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class BranchFormModel
    {
        public long Id { get; set; }
        public long BranchId { get; set; }
        public long LanguageId { get; set; }
        public string? BranchName { get; set; }
        public bool IsActive { get; set; }

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
        private List<Velzon.Common.ValidationType> GetValidationTabWise()
        {
            var lstModelList = new List<Velzon.Common.ValidationType>();

            lstModelList.Add(
            new Velzon.Common.ValidationType
            {
                FieldName = "BranchName",
                IsRequired = true,
                StrMessage = "Enter BranchName",
                RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.AlphanumericSpace),
                StrRegExMessage = "Enter Character Only.",
                CharacterMaxLength = 100,
                IsFormClickTab = false,
                StrTypeMessage = "Enter BranchName."
            });

            return lstModelList;
        }
    }
}
