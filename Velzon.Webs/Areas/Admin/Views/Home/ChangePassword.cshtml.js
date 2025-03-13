function SubmitsEncry() {    
    //if (!ValidateControlPassword($('#OldPassword'))) {
    //    if ($('#OldPassword').val().length > 0) {
    //        ShowMessage("Old Passwords should contain at least one lowercase letter, one uppercase letter, one numeric digit, one special character and length is between 8 to 15 characters!", "", "warning", "", $('#OldPassword'));
    //    }
    //    else {
    //        ShowMessage("Enter old password!", "", "warning", "", $('#OldPassword'));
    //    }
    //    return false;
    //}
    if (!$('#OldPassword').val().length > 0) {
       
        ShowMessage("Enter old password!", "", "error");
        return false;
       
    }
    else if (!ValidateControlPassword($('#NewPassword'))) {
        if ($('#NewPassword').val().length > 0) {
            ShowMessage("New Passwords should contain at least one uppercase letter,one lowercase letter, one numeric digit, one special character and length must be in between 8 to 15 characters!", "", "warning", "", $('#NewPassword'));
        }
        else {
            ShowMessage("Enter new password!", "", "error");
        }
        return false;
    }
    else if (!ValidateControlPassword($('#ConfirmPassword'))) {
        if ($('#ConfirmPassword').val().length > 0) {
            ShowMessage("Confirm Passwords should contain at least one uppercase letter, one lowercase letter, one numeric digit, one special character and length must be in between 8 to 15 characters!", "", "warning", "", $('#ConfirmPassword'));
        }
        else {
            ShowMessage("Enter confirm password!", "", "error");
        }
        return false;
    }
    else {

        $('#OldPassword').val(FrontValue($('#OldPassword').val()));
        $('#NewPassword').val(FrontValue($('#NewPassword').val()));
        $('#ConfirmPassword').val(FrontValue($('#ConfirmPassword').val()));
        //txtUserName.value = FrontEncryptFront("Username");
        //$('#Password').val(FrontValue($('#Password').val() + "exegil" + $('#Captcha').val()));
        $('form#frmChangesPassword').submit();
        return true;
    }
}

function ValidateControlPassword(obj) {
    var objval = $(obj).val();
    if (objval != null && objval != undefined && objval != '' && regexGlobalValidation.test(objval)) {
        var objclass = $(obj).attr('class');
        if (objclass != null && objclass != undefined && objclass != '') {
            if (objclass.includes('validpassword')) {
                if (regexPassword.test(objval)) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        return true;
    } else {
        return false;
    }
}