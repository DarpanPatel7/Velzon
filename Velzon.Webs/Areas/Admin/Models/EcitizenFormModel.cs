using Velzon.Common;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Velzon.Webs.Areas.Admin.Models;
using Newtonsoft.Json;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class EcitizenFormModel
    {
        public long Id { get; set; }
        public long LanguageId { get; set; }
        public long? EcitizenTypeId { get; set; }
        public string? Date { get; set; }
        public string? Number { get; set; }
        public string? Subject { get; set; }
        public bool IsStoreDB { get; set; } = false;
        public IFormFile? ImageName { get; set; }
        public string? ImagePath { get; set; }
        public bool IsActive { get; set; }
        public string? BranchId { get; set; }
        
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

            // Retrieve validation rules from the database
            EcitizenService objValidate = new EcitizenService();
            var validationRules = objValidate.GetEcitizenType().Where(x => x.Id == EcitizenTypeId).Select(x => x.Validate).FirstOrDefault();

            lstModelList.Add(
            new Velzon.Common.ValidationType
            {
                FieldName = "EcitizenTypeId",
                IsRequired = true,
                StrMessage = "Select Type!",
                RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.NumberOnly),
                CharacterMinLength = 1,
                CharacterMaxLength = 3,
                IsFormClickTab = false,
                StrTypeMessage = "Select Type!"
            });

            if (!string.IsNullOrEmpty(validationRules))
            {
                var fieldsToValidate = validationRules.Split(',').Select(f => f.Trim('\'')).ToList();

                foreach (var field in fieldsToValidate)
                {
                    switch (field)
                    {
                        case "EcitizenStartDate":
                            lstModelList.Add(
                            new Velzon.Common.ValidationType
                            {
                                FieldName = "Date",
                                IsRequired = true,
                                StrMessage = "Enter Date!",
                                IsFormClickTab = false,
                                StrTypeMessage = "Enter Date!"
                            });
                            break;
                        case "Number":
                            lstModelList.Add(
                            new Velzon.Common.ValidationType
                            {
                                FieldName = "Number",
                                IsRequired = true,
                                StrMessage = "Enter Number!",
                                RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.TitleString),
                                StrRegExMessage = "Enter Valid Number!",
                                IsFormClickTab = false,
                                StrTypeMessage = "Enter Number!"
                            });
                            break;
                        case "EcitizenDesc":
                            lstModelList.Add(
                            new Velzon.Common.ValidationType
                            {
                                FieldName = "Subject",
                                IsRequired = true,
                                StrMessage = "Enter Subject / Details / Title!",
                                IsFormClickTab = false,
                                StrTypeMessage = "Enter Subject / Details / Title!"

                            });
                            break;
                        case "ImageName":
                            // Dynamic validation based on Id and ImageName
                            if (Id == 0)
                            {
                                lstModelList.Add(
                                new Velzon.Common.ValidationType
                                {
                                    FieldName = "ImageName",
                                    IsRequired = true,
                                    StrMessage = "Upload Document!",
                                    RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.AlphanumericOnly),
                                    IsFormClickTab = false,
                                    StrTypeMessage = "Upload Document!"
                                });
                            }
                            else
                            {
                                if (ImagePath == null)
                                {
                                    lstModelList.Add(
                                    new Velzon.Common.ValidationType
                                    {
                                        FieldName = "ImagePath",
                                        IsRequired = true,
                                        StrMessage = "Upload Document!",
                                        RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.AlphanumericOnly),
                                        IsFormClickTab = false,
                                        StrTypeMessage = "Upload Document!"
                                    });
                                }
                            }
                            break;
                        // Handle additional fields as needed
                        default:
                            // Handle other fields if necessary
                            break;
                    }
                }
            }

            return lstModelList;
        }
    }
}
