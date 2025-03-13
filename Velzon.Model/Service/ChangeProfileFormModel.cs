using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Velzon.Model.Service;

public class ChangeProfileFormModel
{
    public long Id { get; set; }
    public string? FirstName { get; set; }
    public string? MiddleName { get; set; }
    public string? LastName { get; set; }
    public string? Email { get; set; }
    public string? PhoneNo { get; set; }
    public bool IsActive { get; set; }
    public bool IsChangeProfile { get; set; }
    public string? CreatedBy { get; set; }
    public string? DeleteBy { get; set; }
    public IFormFile? ApplicantPhoto { get; set; }
    public string? ApplicantPhotoPath { get; set; }
    public string? Address { get; set; }
    public string? InvestorType {  get; set; }
    public string? IsExistingInvestment { get; set; }
    public string[]? AgroFoodPreferences { get; set; }
    public string? AgroFoodPreferencesValue { get; set; }
    public string[]? KeyInterest { get; set; }
    public string? KeyInterestValue { get; set; }
    public string?  AverageInvestment { get; set; }
    public string? InvestmentHorizon { get; set; }
    public string[]?  SpecificInformation { get; set; }
    public string? SpecificInformationValue { get; set; }
    public string?  AdditionalInformation { get; set; }
    public string? CompleteProfile { get; set; }
    public string? Designation { get;set; }
    public string? Company { get; set; }
    public string? PinCode { get; set; }
    public string? Website { get; set; }
    public string ? StateName { get; set;}
    public string ? CityName { get; set; }
    public int DistrictId {  get; set; }
    public int StateId { get; set; }    

}
