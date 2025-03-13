using Velzon.Common;
using Velzon.Model.Service;
using Velzon.Model.System;
using Velzon.Services.Service;
using Velzon.Webs.Areas.Admin.Models;
using Newtonsoft.Json;

namespace Velzon.Webs.Areas.Admin.Models
{
    public class StatisticFormModel
    {
        public long Id { get; set; }
        public long? StatisticDataId { get; set; }
        public long LanguageId { get; set; }
        public long? StatisticTypeId { get; set; }
        public string? Title { get; set; }
        public string? Count { get; set; }
        public string? Url { get; set; }
        public IFormFile? LogoImage { get; set; }
        public string? ImageName { get; set; }
        public string? ImagePath { get; set; }
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

            // Retrieve validation rules from the database
            StatisticService objValidate = new StatisticService();
            var validationRules = objValidate.GetStatisticType().Where(x => x.Id == StatisticTypeId).Select(x => x.Validate).FirstOrDefault();

            lstModelList.Add(
            new Velzon.Common.ValidationType
            {
                FieldName = "StatisticTypeId",
                IsRequired = true,
                StrMessage = "Select Type!",
                RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.NumberOnly),
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
                        case "Title":
                            lstModelList.Add(
                            new Velzon.Common.ValidationType
                            {
                                FieldName = "Title",
                                IsRequired = true,
                                StrMessage = "Enter Title!",
                                RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.TitleString),
                                StrRegExMessage = "Enter Character Only For Title!",
                                IsFormClickTab = false,
                                StrTypeMessage = "Enter Title!"

                            });
                            break;
                        case "Count":
                            lstModelList.Add(
                            new Velzon.Common.ValidationType
                            {
                                FieldName = "Count",
                                IsRequired = true,
                                StrMessage = "Enter Count!",
                                //RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.AlphanumericOnly),
                                //StrRegExMessage = "Enter Alpha Numeric Only For Count!",
                                IsFormClickTab = false,
                                StrTypeMessage = "Enter Count!"
                            });
                            break;
                        case "Url":
                            lstModelList.Add(
                            new Velzon.Common.ValidationType
                            {
                                FieldName = "Url",
                                IsRequired = true,
                                StrMessage = "Enter Url!",
                                RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.Url),
                                StrRegExMessage = "Enter Proper Url!",
                                CharacterMinLength = 5,
                                CharacterMaxLength = 300,
                                IsFormClickTab = false,
                                StrTypeMessage = "Enter Url!"
                            });
                            break;
                        case "LogoImage":
                            // Dynamic validation based on Id and LogoImage
                            if (Id == 0)
                            {
                                lstModelList.Add(
                                new Velzon.Common.ValidationType
                                {
                                    FieldName = "LogoImage",
                                    IsRequired = true,
                                    StrMessage = "Upload Icon Image!",
                                    RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.AlphanumericOnly),
                                    IsFormClickTab = false,
                                    StrTypeMessage = "Upload Icon Image!"
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
                                        StrMessage = "Upload Icon Image!",
                                        RegExVAlidation = Functions.DescriptionAttr<ValidationDataType>(ValidationDataType.AlphanumericOnly),
                                        IsFormClickTab = false,
                                        StrTypeMessage = "Upload Icon Image!"
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
