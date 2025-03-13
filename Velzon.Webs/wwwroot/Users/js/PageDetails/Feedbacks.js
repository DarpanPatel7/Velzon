$(document).ready(function () {
    //BindImportantLinks();
   
    var lgLangId = $("#lgLanguageId").val();

   
});
$("#SearchClear").click(function (e) {
    $('#FName').val('');
    $('#LName').val('');
    $('#Email').val('');
    $('#MobileNo').val('');
    //$('#Zip').val('');
    $('#Subject').val('');
    //$('#Country').val('');
    //$('#State').val('');
    $('#City').val('');
    $('#Address').val('');
    $('#FeedbackDetails').val('');
    $('#Captcha').val('');
});
//function BindImportantLinks() {
//    var form = $('#frmAdd');
//    var token = $('input[name="AntiforgeryFieldname"]', form).val();

//    $.ajax({

//        type: "POST", url: ResolveUrl("/BindImportantLinks"),
//        contentType: "application/x-www-form-urlencoded",
//        data: { "AntiforgeryFieldname": token },
//        dataType: "json",
//        success: function (res) {

//            $("#dvImportantLink").empty();
//            var strTBody = "";
//            strTBody = strTBody + "";
//            //strTBody = strTBody + '<div class="col-lg-4 col-md-4 col-sm-12 col-12">';
//            strTBody = strTBody + (res.split('col-lg-4 col-md-4 ').join('col-lg-12 col-md-12 '));
//            //strTBody = strTBody + '</div>';
//            $("#dvImportantLink").html(strTBody);
//        }

//    });

//}

$(document).ready(function () {
    HideLoader();
    resetCaptchaImage();
    $('#btnMdlSave').click(function () {
        ShowLoader();
        var isError = false;

        if (!ValidateControl($('#FName'))) {
            ShowMessage("Enter First Name !", "", "error");
            isError = true;
        }
        else if (!ValidateControl($('#LName'))) {
            ShowMessage("Enter Last Name !", "", "error");
            isError = true;
        }
        else if (!ValidateControl($('#Email'))) {
            ShowMessage("Enter Email !", "", "error");
            isError = true;
        }
        else if (!ValidateControl($('#MobileNo'))) {
            ShowMessage("Enter Phone number !", "", "error");
            isError = true;
        }
        else if (!ValidateControl($('#Subject'))) {
            ShowMessage("Enter Subject !", "", "error");
            isError = true;
        }

        else if (!ValidateControl($('#City'))) {
            ShowMessage("Enter City !", "", "error");
            isError = true;
        }
        else if (!ValidateControl($('#FeedbackDetails'))) {
            ShowMessage("Enter Comments / Queries !", "", "error");
            isError = true;
        }
        if (!isError) {
            var Captcha = document.getElementById("Captcha");
            $('#hfEmail').val(FrontValue($('#Email').val() + "--exegil--" + $('#Captcha').val()));
            Captcha.value = FrontValue(Captcha.value);

            var formdata = new FormData(document.getElementById("frmAdd"));


            $.ajax({
                type: "post",
                url: ResolveUrl("/Admin/AddFeedback"),
                data: formdata,
                processData: false,
                contentType: false,
                dataType: 'json',
                success: function (data) {
                    if (data != null && data != undefined) {
                        ShowMessage(data.strMessage, "", data.type);
                        if (data.isError != true) {
                            ClearForm();
                        }
                        HideLoader();
                        resetCaptchaImage();
                        $('#Captcha').val('');
                    }
                    else {
                        ShowMessage("Record not saved, Try again", "", "error");
                        resetCaptchaImage();
                        HideLoader();
                    }
                },
                error: function (ex) {
                    ShowMessage("Something went wrong, Try again!", "", "error");
                    resetCaptchaImage();
                    HideLoader();
                }
            });
        }
    });

});

function resetCaptchaImage() {
    var fdhfCaptcha = document.getElementById("hfCaptcha");
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        destroy: true,
        type: "get",
        contentType: "application/x-www-form-urlencoded",
        url: ResolveUrl("/GetCaptchaDetails?strLast=" + document.getElementById("hfCaptcha").value),
        success: function (data) {
            var maindata = data.result;
            if (!data.isError) {
                // Define the string, also meaning that you need to know the file extension
                var encoded = maindata.fileSRC;
                var hfCaptcha = maindata.captchaval;

                // and then to display the image
                var img = document.getElementById("imgCapcha");
                fdhfCaptcha.value = hfCaptcha;

                // alternatively, you can do this
                img.src = "data:image/png;base64, " + encoded;
            }
            else {
                ShowMessage(data.strMessage, "", data.type);
            }
        }
    });
}
function ClearForm() {

    $('#FName').val('');
    $('#LName').val('');
    $('#Email').val('');
    $('#MobileNo').val('');
    $('#Zip').val('');
    $('#Subject').val('');
    //$('#Country').val('');
    //$('#State').val('');
    $('#City').val('');
    $('#Address').val('');
    $('#FeedbackDetails').val('');
    //$('#Captcha').val('');

}

