
function setSelectedValue(selectObj, valueToSet) {
    for (var i = 0; i < selectObj.options.length; i++) {
        if (selectObj.options[i].value == valueToSet) {
            selectObj.options[i].selected = true;
            return;
        }
    }
}

$(document).ready(function () {

    $('.validalphanumeric').bind('paste', function () {
        var currentid = $(this).attr('id');
        setTimeout(function () {
            var name = $('#' + currentid).val();
            if (!regexAlphaNumeric.test(name)) {
                $('#' + currentid).val('');
            }

        }, 100);
    });

    $('.validalphanumeric').keypress(function (e) {
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (!regexAlphaNumeric.test(str)) {
            e.preventDefault();
            return false;
        }
        return true;
    });

    $('.validname').bind('paste', function () {
        var currentid = $(this).attr('id');
        setTimeout(function () {
            var name = $('#' + currentid).val();
            if (!regexName.test(name)) {
                $('#' + currentid).val('');
            }

        }, 100);
    });

    $('.validname').keypress(function (e) {
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (!regexName.test(str)) {
            e.preventDefault();
            return false;
        }
        return true;
    });

    $('.validdecimal').bind('paste', function () {
        var currentid = $(this).attr('id');
        setTimeout(function () {
            var name = $('#' + currentid).val();
            if (!regexDecimal.test(name)) {
                $('#' + currentid).val('');
            }

        }, 100);
    });

    $('.validdecimal').keyup(function (e) {
        var val = $(this).val();
        if (isNaN(val)) {
            val = val.replace(/[^0-9\.]/g, '');
            if (val.split('.').length > 2)
                val = val.replace(/\.+$/, "");
        }
        $(this).val(val);
    });

    $('.validnumber').bind('paste', function () {
        var currentid = $(this).attr('id');
        setTimeout(function () {
            var name = $('#' + currentid).val();
            if (!regexNumber.test(name)) {
                $('#' + currentid).val('');
            }

        }, 100);
    });

    $('.validnumber').keypress(function (e) {
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        if (!regexNumber.test(str)) {
            e.preventDefault();
            return false;
        }
        return true;
    });

    $('.validpincode').bind('paste', function () {
        var currentid = $(this).attr('id');
        setTimeout(function () {
            var name = $('#' + currentid).val();
            if (!regexPincode.test(name)) {
                $('#' + currentid).val('');
            }

        }, 100);
    });

    $('.validpincode').keypress(function (e) {
        var $this = $(this);
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        // for 6 digit number only
        if ($this.val().length > 5) {
            e.preventDefault();
            return false;
        }
        if (regexNumber.test(str)) {
            return true;
        }
        e.preventDefault();
        return false;
    });

    $('.phone').bind('paste', function () {
        var currentid = $(this).attr('id');
        setTimeout(function () {
            var Mobile = $('#' + currentid).val();
            if (!regexMobileNo.test(Mobile)) {
                $('#' + currentid).val('');
            }
        }, 100);
    });

    $('.phone').keypress(function (e) {
        var $this = $(this);
        var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
        // for 10 digit number only
        if ($this.val().length > 9) {
            e.preventDefault();
            return false;
        }
        if (e.charCode > 47 && e.charCode < 54) {
            if (e.target.selectionStart == 0) {
                e.preventDefault();
                return false;
            }
            else {
                return true;
            }
        }
        if (regexNumber.test(str)) {
            return true;
        }
        e.preventDefault();
        return false;
    });

    $("input,textarea").keypress(function (e) {
        var keyCode = e.keyCode || e.which;
        var isValid = regexGlobalValidation.test(String.fromCharCode(keyCode));
        if (!isValid) {
            e.preventDefault();
        }
    });

    /*$("input,textarea").on("paste", function () {
        var currentid = $(this).attr('id');
        setTimeout(function () {
            var num = $('#' + currentid).val();
            if (!regexGlobalValidation.test(num)) {
                $('#' + currentid).val('');
            }
        }, 100);
    });*/

});
/*function ShowLoader() {
    $("#loading").show();
}

function HideLoader() {
    $("#loading").hide();
}*/

function ShowLoader() {
    $("#preloader").css({ "opacity": "1", "visibility": "visible" });
}

function HideLoader() {
    $("#preloader").css({ "opacity": "0", "visibility": "hidden" });
}


function changeSwitchery(element, checked) {
    if ((element.is(':checked') && checked == false) || (!element.is(':checked') && checked == true)) {
        element.parent().find('.switchery').trigger('click');
    }
}

function TabActive(tabName, LinkPrefix, tabNo, MaxTab) {
    for (var i = 1; i <= MaxTab; i++)//see that I removed the $ preceeding the `for` keyword, it should not have been there
    {
        if (i == tabNo) {

            $("#" + tabName + i).addClass("active show");
            $("#" + LinkPrefix + tabName + i).addClass("active show");

            $("#" + tabName + i).removeClass("disabled");
            $("#" + LinkPrefix + tabName + i).removeClass("disabled");
        }

        else {

            $("#" + tabName + i).removeClass("active show");
            $("#" + LinkPrefix + tabName + i).removeClass("active show");

            $("#" + tabName + i).addClass("disabled");
            $("#" + LinkPrefix + tabName + i).addClass("disabled");
        }

    }

}

function isTextSelected(textboxId) {
    var input = document.getElementById(textboxId);
    if (!input) {
        console.error("Textbox with ID " + textboxId + " not found.");
        return false;
    }
    // Get the selection range
    var selectionStart = input.selectionStart;
    var selectionEnd = input.selectionEnd;

    // If selection start and end are different, then some text is selected
    return selectionStart !== selectionEnd;
}
function CheckDecimals(control, event, maxlength, allowDecimialsAfterPoint, notAllowDot, allowAlphabets, allowSpace) {
    var isError = false;
    var isTextSelect = isTextSelected(control.id);
    var controlKeys = [8, 9, 13];
    var isControlKey = controlKeys.join(",").match(new RegExp(event.which));

    if ((event.which == 45 && control.value.length == 0)) {
        return;
    }
    if (!isTextSelect && event.key != '.' && control.value.toString().indexOf('.') == -1 && control.value.length >= maxlength) {
        isError = true;
    }
    if (notAllowDot != undefined && notAllowDot) {
        if (event.which == 46 && control.value.length > 0) {
            isError = true;
        }
    }
    if (!isTextSelect && control.value.toString().indexOf('.') != -1 &&
        (control.value.toString().length - control.value.toString().indexOf('.')) > allowDecimialsAfterPoint) {
        isError = true;
    }

    if ((!event.which ||
        (48 <= event.which && event.which <= 57) ||
        (allowSpace != undefined && allowSpace && event.which == 32) ||
        (allowAlphabets != undefined && allowAlphabets && ((65 <= event.which && event.which <= 90) || (97 <= event.which && event.which <= 122))) ||
        (46 == event.which && control.value.toString().length > 0 && control.value.toString().lastIndexOf('.') == -1) || isControlKey) && !isError) {
        return;
    } else {
        isError = true;
    }

    if (isError) {
        return false;
    }
    else {
        if (isTextSelect) {
            return;
        }
    }
}

// Function to validate password based on criteria
var regexPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$/;

function ValidatePassword(password) {
    if (password != null && password != undefined && password !== '') {
        // Check if the password matches the regex criteria
        return regexPassword.test(password);
    } else {
        return false;
    }
}
function GreateHashString(strHash) {
    let newStr = strHash.toString().replace(' ', '_');
    let newStrPart0 = FrontValue(newStr).toString();
    let newStrPart1 = newStrPart0.replace(/\//g, "HASH__HASH").replace(/\+/g, "HASH_HASH");
    strHash = newStrPart1;
    return strHash;
}


function MergeGridCells(TableID, rCols) {
    var dimension_cells = new Array();
    var dimension_col = null;
    for (Col in rCols) {
        dimension_col = rCols[Col];
        // first_instance holds the first instance of identical td
        var first_Hash = "";
        var first_instance = null;
        var rowspan = 1;
        // iterate through rows
        $("#" + TableID + "> tbody > tr").children("td").attr('hidden', false);
        $("#" + TableID + "> tbody > tr").children("td").attr('rowspan', 1);
        $("#" + TableID + "> tbody").find('tr').each(function () {

            // find the td of the correct column (determined by the dimension_col set above)
            var dimension_td = $(this).find('td:nth-child(' + dimension_col + ')');
            var dim_Hash = "";
            for (x = 1; x < dimension_col; x++) {
                dim_Hash += $(this).find('td:nth-child(' + x + ')').text();
            }
            if (first_instance === null) {
                // must be the first row
                first_instance = dimension_td;
            } else if (dimension_td.text() == first_instance.text()) {
                // the current td is identical to the previous AND the Hashes are as well
                // remove the current td
                // dimension_td.remove();
                dimension_td.attr('hidden', true);
                ++rowspan;
                // increment the rowspan attribute of the first instance
                first_instance.attr('rowspan', rowspan);
            } else {
                // this cell is different from the last
                first_instance = dimension_td;
                first_Hash = dim_Hash;
                rowspan = 1;
            }
        });
    }
}

function formatDate(input) {
    var datePart = input.match(/\d+/g),
        year = datePart[0], // get only two digits
        month = datePart[1], day = datePart[2];

    return day + '/' + month + '/' + year;
}

function fromDateToJSDate(input) {
    var datePart = input.match(/\d+/g),
        day = datePart[0], // get only two digits
        month = datePart[1], year = datePart[2];

    return new Date(year,month,day);
}
//msgType="success",msgType="warning",msgType="error",msgType="info"
/*function ShowMessage(msgDescription, msgTitle = "", msgType = "info", msgTimer = 0, msgShowbutton = true) {
    if (msgTimer == 0) {
        Swal.fire({ title: msgTitle, text: msgDescription, type: msgType, showConfirmButton: msgShowbutton });
        HideLoader();
    }
    else {
        Swal.fire({ title: msgTitle, text: msgDescription, type: msgType, timer: msgTimer, showConfirmButton: msgShowbutton });
        HideLoader();
    }
}*/

/*function ShowMessage(msgDescription, msgTitle = "", msgType = "info", msgTimer = 0, msgShowButton = true) {

    Swal.fire({
        title: msgTitle,
        text: msgDescription,
        icon: msgType,  // Fixed 'type' -> 'icon'
        timer: msgTimer > 0 ? msgTimer : undefined,  // Only include timer if greater than 0
        showConfirmButton: msgShowButton
    }).then(() => {
        if (typeof HideLoader === "function") {  // Ensure HideLoader exists before calling
            HideLoader();
        }
    });
}*/

function ShowMessage(msgDescription, msgTitle = "", msgType = "info", msgTimer = 0, msgShowButton = true) {
    let swalOptions = {
        title: msgTitle,
        text: msgDescription,
        icon: msgType,
        timer: msgTimer > 0 ? msgTimer : undefined,
        showConfirmButton: msgShowButton,
        buttonsStyling: false
    };

    // Custom styles and additional options based on message type
    switch (msgType) {
        case "success":
            swalOptions.showCancelButton = true;
            swalOptions.confirmButtonClass = "btn btn-primary w-xs me-2 mt-2";
            swalOptions.cancelButtonClass = "btn btn-danger w-xs mt-2";
            break;

        case "error":
            swalOptions.confirmButtonClass = "btn btn-primary w-xs mt-2";
            break;

        case "warning":
            swalOptions.showCancelButton = true;
            swalOptions.confirmButtonClass = "btn btn-primary w-xs me-2 mt-2";
            swalOptions.cancelButtonClass = "btn btn-danger w-xs mt-2";
            swalOptions.confirmButtonText = "Yes, delete it!";
            swalOptions.preConfirm = () => {
                Swal.fire({
                    title: "Deleted!",
                    text: "Your file has been deleted.",
                    icon: "success",
                    confirmButtonClass: "btn btn-primary w-xs mt-2",
                    buttonsStyling: false
                });
            };
            break;

        case "info":
            swalOptions.confirmButtonClass = "btn btn-primary w-xs mt-2";
            break;
    }

    Swal.fire(swalOptions).then(() => {
        if (typeof HideLoader === "function") {  // Ensure HideLoader exists before calling
            HideLoader();
        }
    });
}



function ShowMessageWithCallback(msgDescription, msgTitle = "", msgType = "info", callback = null, msgTimer = 0, msgShowbutton = true, reloadPageFlag = false, url = null) {
    Swal.fire({ title: "Any fool can use a computer", confirmButtonClass: "btn btn-primary w-xs mt-2", buttonsStyling: !1, showCloseButton: !0 });
    if (msgTimer === 0) {
        Swal.fire({
            title: msgTitle,
            text: msgDescription,
            type: msgType,
            showConfirmButton: msgShowbutton
        }).then((result) => {
            if (result.isConfirmed && callback) {
                callback(); // Execute the callback after OK button
            }

            // If the reloadPageFlag is true, reload the page after closing the popup
            if (reloadPageFlag) {
                location.reload(); // Reload the page
            }
            if (url != null && url != "" && url != undefined) {
                window.location.href = url; 
            }
        });
    } else {
        swal({
            title: msgTitle,
            text: msgDescription,
            type: msgType,
            timer: msgTimer,
            showConfirmButton: msgShowbutton
        }).then((result) => {
            if (result.isConfirmed && callback) {
                callback(); // Execute the callback after OK button
            }

            // If the reloadPageFlag is true, reload the page after closing the popup
            if (reloadPageFlag) {
                location.reload(); // Reload the page
            }
        });
    }
}




function ShowMessageForLogin(msgDescription, msgTitle = "", msgType = "info", msgTimer = 0, msgShowbutton = true) {

    if (msgTimer == 0) {
        swal({ title: msgTitle, text: msgDescription, type: msgType, showConfirmButton: msgShowbutton}).catch(swal.noop);
        HideLoader();
    }
    else {
        swal({ title: msgTitle, text: msgDescription, type: msgType, timer: msgTimer, showConfirmButton: msgShowbutton}).catch(swal.noop);
        HideLoader();
    }
}

function ShowMessageWithIcon(msgDescription, imageUrl, msgTimer = 0, msgTitle = "", msgShowbutton = true) {
    if (msgTimer == 0) {
        swal({ title: msgTitle, text: msgDescription, imageUrl: imageUrl, showConfirmButton: msgShowbutton });
    }
    else {
        swal({ title: msgTitle, text: msgDescription, imageUrl: imageUrl, timer: msgTimer, showConfirmButton: msgShowbutton });
    }
}

function FrontValue(value) {

    //var key = CryptoJS.enc.Utf8.parse('4080808080808020');
    //var iv = CryptoJS.enc.Utf8.parse('4080808080808020');

    var key = CryptoJS.enc.Utf8.parse('4090909090909020');
    var iv = CryptoJS.enc.Utf8.parse('4090909090909020');


    var encryptedlogin = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(value), key,
        {

            keySize: 128 / 8,
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        });

    var tesss = encryptedlogin.toString().split(/=/g).join('♬').split(/&/g).join('✦').split(/\//g).join('✤').split(/\+/g).join( '✿');
    return tesss;
}


function FrontdValue(value) {

    //var key = CryptoJS.enc.Utf8.parse('4080808080808020');
    //var iv = CryptoJS.enc.Utf8.parse('4080808080808020');

    var key = CryptoJS.enc.Utf8.parse('4090909090909020');
    var iv = CryptoJS.enc.Utf8.parse('4090909090909020');

    var value = value.toString().replace(/♬/g, '=').replace(/✦/g, '&').replace(/✤/g, '/').replace(/✿/g, '+');
    var encryptedlogin = CryptoJS.AES.decrypt((value), key,
        {
            keySize: 128 / 8,
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        });

    return encryptedlogin.toString(CryptoJS.enc.Utf8);;
}

function lettersAndNumbersOnly(e) {
    var result = false;
    try {
        var charCode = (e.which) ? e.which : e.keyCode;
        // Allow only letters (uppercase and lowercase), numbers, and spaces
        if ((charCode >= 48 && charCode <= 57) ||  // Numbers 0-9
            (charCode >= 65 && charCode <= 90) ||  // Uppercase letters A-Z
            (charCode >= 97 && charCode <= 122) || // Lowercase letters a-z
            charCode === 32) {                     // Space
            result = true;
        }
    }
    catch (err) {
        //console.log(err);
    }
    return result;
}
function FrontEncryptFront(controlInput) {

    //var key = CryptoJS.enc.Utf8.parse('4080808080808020');
    //var iv = CryptoJS.enc.Utf8.parse('4080808080808020');

    var key = CryptoJS.enc.Utf8.parse('4090909090909020');
    var iv = CryptoJS.enc.Utf8.parse('4090909090909020');


    var encryptedlogin = CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(document.getElementById(controlInput).value), key,
        {
            keySize: 128 / 8,
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        });

    document.getElementById(controlInput).value = encryptedlogin;
}

function confirmDelete(msgQuestion, AjaxAPIUrl, AjaxAPIData, APIURLType = "POST", token = "", confirmYesButtontxt = "Yes, Delete it", confirmNoButtontxt = "No, Cancel", strErrorMessage = "Record not deleted, Try again") {
    swal({
        title: 'Are you sure?',
        text: msgQuestion,
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#0CC27E',
        cancelButtonColor: '#FF586B',
        confirmButtonText: confirmYesButtontxt,
        cancelButtonText: confirmNoButtontxt
    }).then(function (isConfirm) {
        if (isConfirm) {

            ShowLoader();
            if (token != "") {
                $.ajax({
                    url: AjaxAPIUrl,
                    type: APIURLType,
                    contentType: "application/x-www-form-urlencoded",
                    data: { "id": AjaxAPIData, "AntiforgeryFieldname": token },
                    success: function (data) {
                        if (data != null && data != undefined) {
                            ShowMessage(data.strMessage, "", data.type);
                            BindGrid();
                        }
                        else {
                            ShowMessage(strErrorMessage, "", "error");
                        }
                    },
                    error: function (ex) {
                        ShowMessage("Something went wrong, Try again!", "", "error");
                    }
                });
            }
            else {
                $.ajax({
                    url: AjaxAPIUrl,
                    type: APIURLType,
                    data: { "id": AjaxAPIData },
                    success: function (data) {
                        if (data != null && data != undefined) {
                            ShowMessage(data.strMessage, "", data.type);
                            BindGrid();
                        }
                        else {
                            ShowMessage(strErrorMessage, "", "error");
                        }
                    },
                    error: function (ex) {
                        ShowMessage("Something went wrong, Try again!", "", "error");
                    }
                });
            }
        }
    }).catch(swal.noop);
}


function confirmDeleteEiaMom(msgQuestion, AjaxAPIUrl, AjaxAPIData, ptype, APIURLType = "POST", token = "", confirmYesButtontxt = "Yes, Delete it", confirmNoButtontxt = "No, Cancel", strErrorMessage = "Record not deleted, Try again",callback) {
    swal({
        title: 'Are you sure?',
        text: msgQuestion,
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#0CC27E',
        cancelButtonColor: '#FF586B',
        confirmButtonText: confirmYesButtontxt,
        cancelButtonText: confirmNoButtontxt
    }).then(function (isConfirm) {
        if (isConfirm) {

            ShowLoader();
            if (token != "") {
                $.ajax({
                    url: AjaxAPIUrl,
                    type: APIURLType,
                    contentType: "application/x-www-form-urlencoded",
                    data: { "id": AjaxAPIData, "ptype": ptype,  "AntiforgeryFieldname": token },
                    success: function (data) {
                        if (data != null && data != undefined) {                            
                            if (callback != null) {
                                callback(data);
                            }
                        }
                        else {
                            ShowMessage(strErrorMessage, "", "error");
                        }
                    },
                    error: function (ex) {
                        ShowMessage("Something went wrong, Try again!", "", "error");
                    }
                });
            }
            else {
                $.ajax({
                    url: AjaxAPIUrl,
                    type: APIURLType,
                    data: { "id": AjaxAPIData, "ptype": ptype },
                    success: function (data) {
                        if (data != null && data != undefined) {
                            ShowMessage(data.strMessage, "", data.type);
                            BindImageDetail();
                        }
                        else {
                            ShowMessage(strErrorMessage, "", "error");
                        }
                    },
                    error: function (ex) {
                        ShowMessage("Something went wrong, Try again!", "", "error");
                    }
                });
            }
        }
    }).catch(swal.noop);
}

function isNumberKey(e) {
    var result = false;
    try {
        var charCode = (e.which) ? e.which : e.keyCode;
        if ((charCode > 31) && (charCode >= 48 && charCode <= 57)) {
            result = true;
        }
    }
    catch (err) {
        //console.log(err);
    }
    return result;
}

function isNumberKeyWithDot(e) {
    var result = false;
    try {
        var charCode = (e.which) ? e.which : e.keyCode;
        if ((charCode > 31) && (charCode >= 48 && charCode <= 57) || charCode == 46) {
            result = true;
        }
    }
    catch (err) {
        //console.log(err);
    }
    return result;
}

function lettersOnly() {
    var charCode = event.keyCode;

    if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8)

        return true;
    else
        return false;
}

$('.decimal').keyup(function () {
    var val = $(this).val();
    if (isNaN(val)) {
        val = val.replace(/[^0-9\.]/g, '');
        if (val.split('.').length > 2)
            val = val.replace(/\.+$/, "");
    }
    $(this).val(val);
});

function lettersWithSpaceOnly() {
    var charCode = event.keyCode;
    if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8 || charCode == 32)

        return true;
    else
        return false;
}

function ValidateControl(obj) {
    if ($(obj).val() != null && $(obj).val() != undefined && $(obj).val() != '') {
        return true;
    } else {
        return false;
    }
}
function validateEmail(email) {
    const emailPattern = /\S+@\S+\.\S+/;
    return emailPattern.test(email);
}

function SetDatePickerOld(input, val) {

    var new_data = val.split("T");
    val = formatDate(new_data[0]);

    var picker = $('#' + input).pickadate('picker');
    picker.set('select', fromDateToJSDate(val));
}

function CreateSetDatePicker(input, val = null) {
    if (val != null) {
        var new_data = val.split("T");
        val = formatDate(new_data[0]);

        $('#' + input).datepicker({
            changeMonth: true,
            changeYear: true,
            format: "dd/mm/yyyy",
            //setDate: val,
            //language: "tr"
        }).on('changeDate', function (ev) {
            $(this).blur();
            $(this).datepicker('hide');
        }).attr('readonly', 'readonly');

        $('#' + input).datepicker('setDate', val);

        //$('#' + input).datepicker("setDate", new Date(val.split('/')[2], val.split('/')[1], val.split('/')[0]));

    }
    else {

        $('#' + input).datepicker({
            changeMonth: true,
            changeYear: true,
            format: "dd/mm/yyyy",
            //language: "tr"
        }).on('changeDate', function (ev) {
            $(this).blur();
            $(this).datepicker('hide');
        }).attr('readonly', 'readonly');

    }
}

function CreateSetTimePicker(input, val = null) {
    if (val != null) {

        $('#' + input).clockpicker({
            autoclose: true,
            //twelvehour: true,
            afterDone: function () {
                var time = $('#' + input).val();
                $('#' + input).val(time);
            }
        }).attr('readonly', 'readonly');

        $('#' + input).val(val);

    }
    else {

        $('#' + input).clockpicker({
            autoclose: true,
            //twelvehour: true,
            afterDone: function () {
                var time = $('#' + input).val();
                $('#' + input).val(time);
            }
        }).attr('readonly', 'readonly');
    }
}

function CreateDatePickerOld(input) {
    var picker = $('#' + input).pickadate({
        //min: [2016, 8, 20],
        //max: [2016, 10, 30]

        //disable: [
        //    [2016, 5, 10],
        //    [2016, 5, 15],
        //    [2016, 5, 20]
        //]

        selectMonths: true,
        selectYears: true,

        // Escape any 'rule' characters with an exclamation mark (!).
        format: 'dd/mm/yyyy',
        formatSubmit: 'dd/mm/yyyy',
        hiddenPrefix: 'prefix__',
        hiddenSuffix: '__suffix'
    });

}

function initializeDateRangePicker(selector, val = null, options = {}) {
    // Check if the provided element exists
    if ($(selector).length) {
        // Set default options
        var defaultOptions = {
            timePicker: true,
            showDropdowns: true,
            startDate: moment().startOf('hour'),
            endDate: moment().startOf('hour').add(32, 'hour'),
            locale: {
                format: 'DD/MM/YYYY hh:mm A'
            },
            applyButtonClasses: 'btn btn-outline-primary btn-round',
            cancelButtonClasses: 'btn grey btn-outline-secondary btn-round'
        };

        // Merge user-provided options with default options
        var settings = $.extend({}, defaultOptions, options);

        // Initialize the daterangepicker with the combined settings
        $(selector).daterangepicker(settings);

        // Clear the textbox value to ensure it is initially empty
        if (val != null) {
            $(selector).val(val);
        } else {
            $(selector).val('');
        }

        // Set the readonly attribute
        $(selector).attr('readonly', 'readonly');

        // Event handlers for apply and cancel
        $(selector).on('apply.daterangepicker', function (ev, picker) {
            // Triggered when the "Apply" button is clicked
            $(selector).val(picker.startDate.format(settings.locale.format) + ' - ' + picker.endDate.format(settings.locale.format));
        });

        $(selector).on('cancel.daterangepicker', function (ev, picker) {
            // Triggered when the "Cancel" button is clicked
            $(selector).val('');
        });
    }
}

function ResolveUrl(url) {
    if (url.indexOf("/") == 0) {
        url = url.split(baseUrl.substring(0, (baseUrl.length - 1))).join('');

        url = baseUrl + url.substring(1);
    }
    return url;
}

function htmlDecode(input) {
    var doc = new DOMParser().parseFromString(input, "text/html");
    return doc.documentElement.textContent;
}
function sanitizeCKEditorHTML(HTMLOfCK) {
    //  HTMLOfCK = htmlDecode(HTMLOfCK);

    //var mainraw = "";

    
    //var config = {
    //  /*  ALLOWED_TAGS: ['p', '#text'], // only <P> and text nodes*/
    //    KEEP_CONTENT: false, // remove content from non-allow-listed nodes too
    //    ADD_ATTR: ['class','style','target'], // permit kitty-litter attributes
    //    //ADD_TAGS: ['ying', 'yang'], // permit additional custom tags
    //    RETURN_DOM: false, // return a document object instead of a string
    //};
    //var clean = DOMPurify.sanitize(HTMLOfCK, config);//.split("Onload").join("").split("onload").join("").split("ONLOAD").join("").split("ONload").join("").split("ONLoad").join("").split("ONLOad").join("").split("ONLOAd").join("").split("prompt").join("").split("Prompt").join("").split("alert(").join("").split("alert)").join("").split("alert").join("").split("onerror").join("").split("svg").join("").split("onscroll").join("").split("confirm()").join("").split("confirm").join("").split("object()").join("").split("object").join("").split("IFRAME").join("").split("onfocus").join("").split("autofocus").join("");

    //mainraw = clean.split("<code>")[0];

    //var innerMainHTMLOfCK = clean.split("<code>")[1].toString().split("</code>").join("");

    //var updateHTMLOfCK = htmlDecode(innerMainHTMLOfCK);

    //updateHTMLOfCK = DOMPurify.sanitize((updateHTMLOfCK), config);
    //debugger
    //mainraw = mainraw + updateHTMLOfCK;

    return HTMLOfCK;
}


function CreateTimePickerOld(input) {

    var picker = $('#' + input).pickatime({
        //disable: [
        //    new Date(2016, 3, 20, 4, 30),
        //    new Date(2016, 3, 20, 9)
        //]

        //disable: [
        //    { from: [2, 0], to: [5, 30] }
        //]

		// Disable Using Array
        /*disable: [
            [0,30],
            [2,0],
            [8,30],
            [9,0]
        ]*/
    });

    //if (ValidateControl('#' + input)) {
    //    picker.set('select', val);
    //}
}

function CallAjaxPost(URL, Data, DataType = "json") {
    $.ajax({
        type: "post",
        url: URL,
        data: Data,
        dataType: DataType,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        success: function (data) {
            if (data != null && data != undefined) {
                ShowMessage(data.strMessage, "", data.type);
            }
            else {
                ShowMessage("Record not saved, Try again", "", "error");
            }
        },
        error: function () {
            ShowMessage("Something went wrong, Try again!", "", "error");
        }
    });
}

function getMimeType(ext) {

    if (!ext.startsWith(".")) {
        ext = "." + ext;
    }
    let myList =
        [
            {"key":".323", "value": "text/h323"},
            {"key":".3g2", "value": "video/3gpp2"},
            {"key":".3gp", "value": "video/3gpp"},
            {"key":".3gp2", "value": "video/3gpp2"},
            {"key":".3gpp", "value": "video/3gpp"},
            {"key":".7z", "value": "application/x-7z-compressed"},
            {"key":".aa", "value": "audio/audible"},
            {"key":".AAC", "value": "audio/aac"},
            {"key":".aaf", "value": "application/octet-stream"},
            {"key":".aax", "value": "audio/vnd.audible.aax"},
            {"key":".ac3", "value": "audio/ac3"},
            {"key":".aca", "value": "application/octet-stream"},
            {"key":".accda", "value": "application/msaccess.addin"},
            {"key":".accdb", "value": "application/msaccess"},
            {"key":".accdc", "value": "application/msaccess.cab"},
            {"key":".accde", "value": "application/msaccess"},
            {"key":".accdr", "value": "application/msaccess.runtime"},
            {"key":".accdt", "value": "application/msaccess"},
            {"key":".accdw", "value": "application/msaccess.webapplication"},
            {"key":".accft", "value": "application/msaccess.ftemplate"},
            {"key":".acx", "value": "application/internet-property-stream"},
            {"key":".AddIn", "value": "text/xml"},
            {"key":".ade", "value": "application/msaccess"},
            {"key":".adobebridge", "value": "application/x-bridge-url"},
            {"key":".adp", "value": "application/msaccess"},
            {"key":".ADT", "value": "audio/vnd.dlna.adts"},
            {"key":".ADTS", "value": "audio/aac"},
            {"key":".afm", "value": "application/octet-stream"},
            {"key":".ai", "value": "application/postscript"},
            {"key":".aif", "value": "audio/x-aiff"},
            {"key":".aifc", "value": "audio/aiff"},
            {"key":".aiff", "value": "audio/aiff"},
            {"key":".air", "value": "application/vnd.adobe.air-application-installer-package+zip"},
            {"key":".amc", "value": "application/x-mpeg"},
            {"key": ".application", "value": "application/x-ms-application" },
            {"key": ".apk", "value": "application/vnd.android.package-archive" },
            {"key":".art", "value": "image/x-jg"},
            {"key":".asa", "value": "application/xml"},
            {"key":".asax", "value": "application/xml"},
            {"key":".ascx", "value": "application/xml"},
            {"key":".asd", "value": "application/octet-stream"},
            {"key":".asf", "value": "video/x-ms-asf"},
            {"key":".ashx", "value": "application/xml"},
            {"key":".asi", "value": "application/octet-stream"},
            {"key":".asm", "value": "text/plain"},
            {"key":".asmx", "value": "application/xml"},
            {"key":".aspx", "value": "application/xml"},
            {"key":".asr", "value": "video/x-ms-asf"},
            {"key":".asx", "value": "video/x-ms-asf"},
            {"key":".atom", "value": "application/atom+xml"},
            {"key":".au", "value": "audio/basic"},
            {"key":".avi", "value": "video/x-msvideo"},
            {"key":".axs", "value": "application/olescript"},
            {"key":".bas", "value": "text/plain"},
            {"key":".bcpio", "value": "application/x-bcpio"},
            {"key":".bin", "value": "application/octet-stream"},
            {"key":".bmp", "value": "image/bmp"},
            {"key":".c", "value": "text/plain"},
            {"key":".cab", "value": "application/octet-stream"},
            {"key":".caf", "value": "audio/x-caf"},
            {"key":".calx", "value": "application/vnd.ms-office.calx"},
            {"key":".cat", "value": "application/vnd.ms-pki.seccat"},
            {"key":".cc", "value": "text/plain"},
            {"key":".cd", "value": "text/plain"},
            {"key":".cdda", "value": "audio/aiff"},
            {"key":".cdf", "value": "application/x-cdf"},
            {"key":".cer", "value": "application/x-x509-ca-cert"},
            {"key":".chm", "value": "application/octet-stream"},
            {"key":".class", "value": "application/x-java-applet"},
            {"key":".clp", "value": "application/x-msclip"},
            {"key":".cmx", "value": "image/x-cmx"},
            {"key":".cnf", "value": "text/plain"},
            {"key":".cod", "value": "image/cis-cod"},
            {"key":".config", "value": "application/xml"},
            {"key":".contact", "value": "text/x-ms-contact"},
            {"key":".coverage", "value": "application/xml"},
            {"key":".cpio", "value": "application/x-cpio"},
            {"key":".cpp", "value": "text/plain"},
            {"key":".crd", "value": "application/x-mscardfile"},
            {"key":".crl", "value": "application/pkix-crl"},
            {"key":".crt", "value": "application/x-x509-ca-cert"},
            {"key":".cs", "value": "text/plain"},
            {"key":".csdproj", "value": "text/plain"},
            {"key":".csh", "value": "application/x-csh"},
            {"key":".csproj", "value": "text/plain"},
            {"key":".css", "value": "text/css"},
            {"key":".csv", "value": "text/csv"},
            {"key":".cur", "value": "application/octet-stream"},
            {"key":".cxx", "value": "text/plain"},
            {"key":".dat", "value": "application/octet-stream"},
            {"key":".datasource", "value": "application/xml"},
            {"key":".dbproj", "value": "text/plain"},
            {"key":".dcr", "value": "application/x-director"},
            {"key":".def", "value": "text/plain"},
            {"key":".deploy", "value": "application/octet-stream"},
            {"key":".der", "value": "application/x-x509-ca-cert"},
            {"key":".dgml", "value": "application/xml"},
            {"key":".dib", "value": "image/bmp"},
            {"key":".dif", "value": "video/x-dv"},
            {"key":".dir", "value": "application/x-director"},
            {"key":".disco", "value": "text/xml"},
            {"key":".dll", "value": "application/x-msdownload"},
            {"key":".dll.config", "value": "text/xml"},
            {"key":".dlm", "value": "text/dlm"},
            {"key":".doc", "value": "application/msword"},
            {"key":".docm", "value": "application/vnd.ms-word.document.macroEnabled.12"},
            {"key":".docx", "value": "application/vnd.openxmlformats-officedocument.wordprocessingml.document"},
            {"key":".dot", "value": "application/msword"},
            {"key":".dotm", "value": "application/vnd.ms-word.template.macroEnabled.12"},
            {"key":".dotx", "value": "application/vnd.openxmlformats-officedocument.wordprocessingml.template"},
            {"key":".dsp", "value": "application/octet-stream"},
            {"key":".dsw", "value": "text/plain"},
            {"key":".dtd", "value": "text/xml"},
            {"key":".dtsConfig", "value": "text/xml"},
            {"key":".dv", "value": "video/x-dv"},
            {"key":".dvi", "value": "application/x-dvi"},
            {"key":".dwf", "value": "drawing/x-dwf"},
            {"key":".dwp", "value": "application/octet-stream"},
            {"key":".dxr", "value": "application/x-director"},
            {"key":".eml", "value": "message/rfc822"},
            {"key":".emz", "value": "application/octet-stream"},
            {"key":".eot", "value": "application/octet-stream"},
            {"key":".eps", "value": "application/postscript"},
            {"key":".etl", "value": "application/etl"},
            {"key":".etx", "value": "text/x-setext"},
            {"key":".evy", "value": "application/envoy"},
            {"key":".exe", "value": "application/octet-stream"},
            {"key":".exe.config", "value": "text/xml"},
            {"key":".fdf", "value": "application/vnd.fdf"},
            {"key":".fif", "value": "application/fractals"},
            {"key":".filters", "value": "Application/xml"},
            {"key":".fla", "value": "application/octet-stream"},
            {"key":".flr", "value": "x-world/x-vrml"},
            {"key":".flv", "value": "video/x-flv"},
            {"key":".fsscript", "value": "application/fsharp-script"},
            {"key":".fsx", "value": "application/fsharp-script"},
            {"key":".generictest", "value": "application/xml"},
            {"key":".gif", "value": "image/gif"},
            {"key":".group", "value": "text/x-ms-group"},
            {"key":".gsm", "value": "audio/x-gsm"},
            {"key":".gtar", "value": "application/x-gtar"},
            {"key":".gz", "value": "application/x-gzip"},
            {"key":".h", "value": "text/plain"},
            {"key":".hdf", "value": "application/x-hdf"},
            {"key":".hdml", "value": "text/x-hdml"},
            {"key":".hhc", "value": "application/x-oleobject"},
            {"key":".hhk", "value": "application/octet-stream"},
            {"key":".hhp", "value": "application/octet-stream"},
            {"key":".hlp", "value": "application/winhlp"},
            {"key":".hpp", "value": "text/plain"},
            {"key":".hqx", "value": "application/mac-binhex40"},
            {"key":".hta", "value": "application/hta"},
            {"key":".htc", "value": "text/x-component"},
            {"key":".htm", "value": "text/html"},
            {"key":".html", "value": "text/html"},
            {"key":".htt", "value": "text/webviewhtml"},
            {"key":".hxa", "value": "application/xml"},
            {"key":".hxc", "value": "application/xml"},
            {"key":".hxd", "value": "application/octet-stream"},
            {"key":".hxe", "value": "application/xml"},
            {"key":".hxf", "value": "application/xml"},
            {"key":".hxh", "value": "application/octet-stream"},
            {"key":".hxi", "value": "application/octet-stream"},
            {"key":".hxk", "value": "application/xml"},
            {"key":".hxq", "value": "application/octet-stream"},
            {"key":".hxr", "value": "application/octet-stream"},
            {"key":".hxs", "value": "application/octet-stream"},
            {"key":".hxt", "value": "text/html"},
            {"key":".hxv", "value": "application/xml"},
            {"key":".hxw", "value": "application/octet-stream"},
            {"key":".hxx", "value": "text/plain"},
            {"key":".i", "value": "text/plain"},
            {"key":".ico", "value": "image/x-icon"},
            {"key":".ics", "value": "application/octet-stream"},
            {"key":".idl", "value": "text/plain"},
            {"key":".ief", "value": "image/ief"},
            {"key":".iii", "value": "application/x-iphone"},
            {"key":".inc", "value": "text/plain"},
            {"key":".inf", "value": "application/octet-stream"},
            {"key":".inl", "value": "text/plain"},
            {"key":".ins", "value": "application/x-internet-signup"},
            {"key":".ipa", "value": "application/x-itunes-ipa"},
            {"key":".ipg", "value": "application/x-itunes-ipg"},
            {"key":".ipproj", "value": "text/plain"},
            {"key":".ipsw", "value": "application/x-itunes-ipsw"},
            {"key":".iqy", "value": "text/x-ms-iqy"},
            {"key":".isp", "value": "application/x-internet-signup"},
            {"key":".ite", "value": "application/x-itunes-ite"},
            {"key":".itlp", "value": "application/x-itunes-itlp"},
            {"key":".itms", "value": "application/x-itunes-itms"},
            {"key":".itpc", "value": "application/x-itunes-itpc"},
            {"key":".IVF", "value": "video/x-ivf"},
            {"key":".jar", "value": "application/java-archive"},
            {"key":".java", "value": "application/octet-stream"},
            {"key":".jck", "value": "application/liquidmotion"},
            {"key":".jcz", "value": "application/liquidmotion"},
            {"key":".jfif", "value": "image/pjpeg"},
            {"key":".jnlp", "value": "application/x-java-jnlp-file"},
            {"key":".jpb", "value": "application/octet-stream"},
            {"key":".jpe", "value": "image/jpeg"},
            {"key":".jpeg", "value": "image/jpeg"},
            {"key":".jpg", "value": "image/jpeg"},
            {"key":".js", "value": "application/x-javascript"},
            {"key":".jsx", "value": "text/jscript"},
            {"key":".jsxbin", "value": "text/plain"},
            {"key":".latex", "value": "application/x-latex"},
            {"key":".library-ms", "value": "application/windows-library+xml"},
            {"key":".lit", "value": "application/x-ms-reader"},
            {"key":".loadtest", "value": "application/xml"},
            {"key":".lpk", "value": "application/octet-stream"},
            {"key":".lsf", "value": "video/x-la-asf"},
            {"key":".lst", "value": "text/plain"},
            {"key":".lsx", "value": "video/x-la-asf"},
            {"key":".lzh", "value": "application/octet-stream"},
            {"key":".m13", "value": "application/x-msmediaview"},
            {"key":".m14", "value": "application/x-msmediaview"},
            {"key":".m1v", "value": "video/mpeg"},
            {"key":".m2t", "value": "video/vnd.dlna.mpeg-tts"},
            {"key":".m2ts", "value": "video/vnd.dlna.mpeg-tts"},
            {"key":".m2v", "value": "video/mpeg"},
            {"key":".m3u", "value": "audio/x-mpegurl"},
            {"key":".m3u8", "value": "audio/x-mpegurl"},
            {"key":".m4a", "value": "audio/m4a"},
            {"key":".m4b", "value": "audio/m4b"},
            {"key":".m4p", "value": "audio/m4p"},
            {"key":".m4r", "value": "audio/x-m4r"},
            {"key":".m4v", "value": "video/x-m4v"},
            {"key":".mac", "value": "image/x-macpaint"},
            {"key":".mak", "value": "text/plain"},
            {"key":".man", "value": "application/x-troff-man"},
            {"key":".manifest", "value": "application/x-ms-manifest"},
            {"key":".map", "value": "text/plain"},
            {"key":".master", "value": "application/xml"},
            {"key":".mda", "value": "application/msaccess"},
            {"key":".mdb", "value": "application/x-msaccess"},
            {"key":".mde", "value": "application/msaccess"},
            {"key":".mdp", "value": "application/octet-stream"},
            {"key":".me", "value": "application/x-troff-me"},
            {"key":".mfp", "value": "application/x-shockwave-flash"},
            {"key":".mht", "value": "message/rfc822"},
            {"key":".mhtml", "value": "message/rfc822"},
            {"key":".mid", "value": "audio/mid"},
            {"key":".midi", "value": "audio/mid"},
            {"key":".mix", "value": "application/octet-stream"},
            {"key":".mk", "value": "text/plain"},
            {"key":".mmf", "value": "application/x-smaf"},
            {"key":".mno", "value": "text/xml"},
            {"key":".mny", "value": "application/x-msmoney"},
            {"key":".mod", "value": "video/mpeg"},
            {"key":".mov", "value": "video/quicktime"},
            {"key":".movie", "value": "video/x-sgi-movie"},
            {"key":".mp2", "value": "video/mpeg"},
            {"key":".mp2v", "value": "video/mpeg"},
            {"key":".mp3", "value": "audio/mpeg"},
            {"key":".mp4", "value": "video/mp4"},
            {"key":".mp4v", "value": "video/mp4"},
            {"key":".mpa", "value": "video/mpeg"},
            {"key":".mpe", "value": "video/mpeg"},
            {"key":".mpeg", "value": "video/mpeg"},
            {"key":".mpf", "value": "application/vnd.ms-mediapackage"},
            {"key":".mpg", "value": "video/mpeg"},
            {"key":".mpp", "value": "application/vnd.ms-project"},
            {"key":".mpv2", "value": "video/mpeg"},
            {"key":".mqv", "value": "video/quicktime"},
            {"key":".ms", "value": "application/x-troff-ms"},
            {"key":".msi", "value": "application/octet-stream"},
            {"key":".mso", "value": "application/octet-stream"},
            {"key":".mts", "value": "video/vnd.dlna.mpeg-tts"},
            {"key":".mtx", "value": "application/xml"},
            {"key":".mvb", "value": "application/x-msmediaview"},
            {"key":".mvc", "value": "application/x-miva-compiled"},
            {"key":".mxp", "value": "application/x-mmxp"},
            {"key":".nc", "value": "application/x-netcdf"},
            {"key":".nsc", "value": "video/x-ms-asf"},
            {"key":".nws", "value": "message/rfc822"},
            {"key":".ocx", "value": "application/octet-stream"},
            {"key":".oda", "value": "application/oda"},
            {"key":".odc", "value": "text/x-ms-odc"},
            {"key":".odh", "value": "text/plain"},
            {"key":".odl", "value": "text/plain"},
            {"key":".odp", "value": "application/vnd.oasis.opendocument.presentation"},
            {"key":".ods", "value": "application/oleobject"},
            {"key":".odt", "value": "application/vnd.oasis.opendocument.text"},
            {"key":".one", "value": "application/onenote"},
            {"key":".onea", "value": "application/onenote"},
            {"key":".onepkg", "value": "application/onenote"},
            {"key":".onetmp", "value": "application/onenote"},
            {"key":".onetoc", "value": "application/onenote"},
            {"key":".onetoc2", "value": "application/onenote"},
            {"key":".orderedtest", "value": "application/xml"},
            {"key":".osdx", "value": "application/opensearchdescription+xml"},
            {"key":".p10", "value": "application/pkcs10"},
            {"key":".p12", "value": "application/x-pkcs12"},
            {"key":".p7b", "value": "application/x-pkcs7-certificates"},
            {"key":".p7c", "value": "application/pkcs7-mime"},
            {"key":".p7m", "value": "application/pkcs7-mime"},
            {"key":".p7r", "value": "application/x-pkcs7-certreqresp"},
            {"key":".p7s", "value": "application/pkcs7-signature"},
            {"key":".pbm", "value": "image/x-portable-bitmap"},
            {"key":".pcast", "value": "application/x-podcast"},
            {"key":".pct", "value": "image/pict"},
            {"key":".pcx", "value": "application/octet-stream"},
            {"key":".pcz", "value": "application/octet-stream"},
            {"key":".pdf", "value": "application/pdf"},
            {"key":".pfb", "value": "application/octet-stream"},
            {"key":".pfm", "value": "application/octet-stream"},
            {"key":".pfx", "value": "application/x-pkcs12"},
            {"key":".pgm", "value": "image/x-portable-graymap"},
            {"key":".pic", "value": "image/pict"},
            {"key":".pict", "value": "image/pict"},
            {"key":".pkgdef", "value": "text/plain"},
            {"key":".pkgundef", "value": "text/plain"},
            {"key":".pko", "value": "application/vnd.ms-pki.pko"},
            {"key":".pls", "value": "audio/scpls"},
            {"key":".pma", "value": "application/x-perfmon"},
            {"key":".pmc", "value": "application/x-perfmon"},
            {"key":".pml", "value": "application/x-perfmon"},
            {"key":".pmr", "value": "application/x-perfmon"},
            {"key":".pmw", "value": "application/x-perfmon"},
            {"key":".png", "value": "image/png"},
            {"key":".pnm", "value": "image/x-portable-anymap"},
            {"key":".pnt", "value": "image/x-macpaint"},
            {"key":".pntg", "value": "image/x-macpaint"},
            {"key":".pnz", "value": "image/png"},
            {"key":".pot", "value": "application/vnd.ms-powerpoint"},
            {"key":".potm", "value": "application/vnd.ms-powerpoint.template.macroEnabled.12"},
            {"key":".potx", "value": "application/vnd.openxmlformats-officedocument.presentationml.template"},
            {"key":".ppa", "value": "application/vnd.ms-powerpoint"},
            {"key":".ppam", "value": "application/vnd.ms-powerpoint.addin.macroEnabled.12"},
            {"key":".ppm", "value": "image/x-portable-pixmap"},
            {"key":".pps", "value": "application/vnd.ms-powerpoint"},
            {"key":".ppsm", "value": "application/vnd.ms-powerpoint.slideshow.macroEnabled.12"},
            {"key":".ppsx", "value": "application/vnd.openxmlformats-officedocument.presentationml.slideshow"},
            {"key":".ppt", "value": "application/vnd.ms-powerpoint"},
            {"key":".pptm", "value": "application/vnd.ms-powerpoint.presentation.macroEnabled.12"},
            {"key":".pptx", "value": "application/vnd.openxmlformats-officedocument.presentationml.presentation"},
            {"key":".prf", "value": "application/pics-rules"},
            {"key":".prm", "value": "application/octet-stream"},
            {"key":".prx", "value": "application/octet-stream"},
            {"key":".ps", "value": "application/postscript"},
            {"key":".psc1", "value": "application/PowerShell"},
            {"key":".psd", "value": "application/octet-stream"},
            {"key":".psess", "value": "application/xml"},
            {"key":".psm", "value": "application/octet-stream"},
            {"key":".psp", "value": "application/octet-stream"},
            {"key":".pub", "value": "application/x-mspublisher"},
            {"key":".pwz", "value": "application/vnd.ms-powerpoint"},
            {"key":".qht", "value": "text/x-html-insertion"},
            {"key":".qhtm", "value": "text/x-html-insertion"},
            {"key":".qt", "value": "video/quicktime"},
            {"key":".qti", "value": "image/x-quicktime"},
            {"key":".qtif", "value": "image/x-quicktime"},
            {"key":".qtl", "value": "application/x-quicktimeplayer"},
            {"key":".qxd", "value": "application/octet-stream"},
            {"key":".ra", "value": "audio/x-pn-realaudio"},
            {"key":".ram", "value": "audio/x-pn-realaudio"},
            {"key":".rar", "value": "application/octet-stream"},
            {"key":".ras", "value": "image/x-cmu-raster"},
            {"key":".rat", "value": "application/rat-file"},
            {"key":".rc", "value": "text/plain"},
            {"key":".rc2", "value": "text/plain"},
            {"key":".rct", "value": "text/plain"},
            {"key":".rdlc", "value": "application/xml"},
            {"key":".resx", "value": "application/xml"},
            {"key":".rf", "value": "image/vnd.rn-realflash"},
            {"key":".rgb", "value": "image/x-rgb"},
            {"key":".rgs", "value": "text/plain"},
            {"key":".rm", "value": "application/vnd.rn-realmedia"},
            {"key":".rmi", "value": "audio/mid"},
            {"key":".rmp", "value": "application/vnd.rn-rn_music_package"},
            {"key":".roff", "value": "application/x-troff"},
            {"key":".rpm", "value": "audio/x-pn-realaudio-plugin"},
            {"key":".rqy", "value": "text/x-ms-rqy"},
            {"key":".rtf", "value": "application/rtf"},
            {"key":".rtx", "value": "text/richtext"},
            {"key":".ruleset", "value": "application/xml"},
            {"key":".s", "value": "text/plain"},
            {"key":".safariextz", "value": "application/x-safari-safariextz"},
            {"key":".scd", "value": "application/x-msschedule"},
            {"key":".sct", "value": "text/scriptlet"},
            {"key":".sd2", "value": "audio/x-sd2"},
            {"key":".sdp", "value": "application/sdp"},
            {"key":".sea", "value": "application/octet-stream"},
            {"key":".searchConnector-ms", "value": "application/windows-search-connector+xml"},
            {"key":".setpay", "value": "application/set-payment-initiation"},
            {"key":".setreg", "value": "application/set-registration-initiation"},
            {"key":".settings", "value": "application/xml"},
            {"key":".sgimb", "value": "application/x-sgimb"},
            {"key":".sgml", "value": "text/sgml"},
            {"key":".sh", "value": "application/x-sh"},
            {"key":".shar", "value": "application/x-shar"},
            {"key":".shtml", "value": "text/html"},
            {"key":".sit", "value": "application/x-stuffit"},
            {"key":".sitemap", "value": "application/xml"},
            {"key":".skin", "value": "application/xml"},
            {"key":".sldm", "value": "application/vnd.ms-powerpoint.slide.macroEnabled.12"},
            {"key":".sldx", "value": "application/vnd.openxmlformats-officedocument.presentationml.slide"},
            {"key":".slk", "value": "application/vnd.ms-excel"},
            {"key":".sln", "value": "text/plain"},
            {"key":".slupkg-ms", "value": "application/x-ms-license"},
            {"key":".smd", "value": "audio/x-smd"},
            {"key":".smi", "value": "application/octet-stream"},
            {"key":".smx", "value": "audio/x-smd"},
            {"key":".smz", "value": "audio/x-smd"},
            {"key":".snd", "value": "audio/basic"},
            {"key":".snippet", "value": "application/xml"},
            {"key":".snp", "value": "application/octet-stream"},
            {"key":".sol", "value": "text/plain"},
            {"key":".sor", "value": "text/plain"},
            {"key":".spc", "value": "application/x-pkcs7-certificates"},
            {"key":".spl", "value": "application/futuresplash"},
            {"key":".src", "value": "application/x-wais-source"},
            {"key":".srf", "value": "text/plain"},
            {"key":".SSISDeploymentManifest", "value": "text/xml"},
            {"key":".ssm", "value": "application/streamingmedia"},
            {"key":".sst", "value": "application/vnd.ms-pki.certstore"},
            {"key":".stl", "value": "application/vnd.ms-pki.stl"},
            {"key":".sv4cpio", "value": "application/x-sv4cpio"},
            {"key":".sv4crc", "value": "application/x-sv4crc"},
            {"key":".svc", "value": "application/xml"},
            {"key":".swf", "value": "application/x-shockwave-flash"},
            {"key":".t", "value": "application/x-troff"},
            {"key":".tar", "value": "application/x-tar"},
            {"key":".tcl", "value": "application/x-tcl"},
            {"key":".testrunconfig", "value": "application/xml"},
            {"key":".testsettings", "value": "application/xml"},
            {"key":".tex", "value": "application/x-tex"},
            {"key":".texi", "value": "application/x-texinfo"},
            {"key":".texinfo", "value": "application/x-texinfo"},
            {"key":".tgz", "value": "application/x-compressed"},
            {"key":".thmx", "value": "application/vnd.ms-officetheme"},
            {"key":".thn", "value": "application/octet-stream"},
            {"key":".tif", "value": "image/tiff"},
            {"key":".tiff", "value": "image/tiff"},
            {"key":".tlh", "value": "text/plain"},
            {"key":".tli", "value": "text/plain"},
            {"key":".toc", "value": "application/octet-stream"},
            {"key":".tr", "value": "application/x-troff"},
            {"key":".trm", "value": "application/x-msterminal"},
            {"key":".trx", "value": "application/xml"},
            {"key":".ts", "value": "video/vnd.dlna.mpeg-tts"},
            {"key":".tsv", "value": "text/tab-separated-values"},
            {"key":".ttf", "value": "application/octet-stream"},
            {"key":".tts", "value": "video/vnd.dlna.mpeg-tts"},
            {"key":".txt", "value": "text/plain"},
            {"key":".u32", "value": "application/octet-stream"},
            {"key":".uls", "value": "text/iuls"},
            {"key":".user", "value": "text/plain"},
            {"key":".ustar", "value": "application/x-ustar"},
            {"key":".vb", "value": "text/plain"},
            {"key":".vbdproj", "value": "text/plain"},
            {"key":".vbk", "value": "video/mpeg"},
            {"key":".vbproj", "value": "text/plain"},
            {"key":".vbs", "value": "text/vbscript"},
            {"key":".vcf", "value": "text/x-vcard"},
            {"key":".vcproj", "value": "Application/xml"},
            {"key":".vcs", "value": "text/plain"},
            {"key":".vcxproj", "value": "Application/xml"},
            {"key":".vddproj", "value": "text/plain"},
            {"key":".vdp", "value": "text/plain"},
            {"key":".vdproj", "value": "text/plain"},
            {"key":".vdx", "value": "application/vnd.ms-visio.viewer"},
            {"key":".vml", "value": "text/xml"},
            {"key":".vscontent", "value": "application/xml"},
            {"key":".vsct", "value": "text/xml"},
            {"key":".vsd", "value": "application/vnd.visio"},
            {"key":".vsi", "value": "application/ms-vsi"},
            {"key":".vsix", "value": "application/vsix"},
            {"key":".vsixlangpack", "value": "text/xml"},
            {"key":".vsixmanifest", "value": "text/xml"},
            {"key":".vsmdi", "value": "application/xml"},
            {"key":".vspscc", "value": "text/plain"},
            {"key":".vss", "value": "application/vnd.visio"},
            {"key":".vsscc", "value": "text/plain"},
            {"key":".vssettings", "value": "text/xml"},
            {"key":".vssscc", "value": "text/plain"},
            {"key":".vst", "value": "application/vnd.visio"},
            {"key":".vstemplate", "value": "text/xml"},
            {"key":".vsto", "value": "application/x-ms-vsto"},
            {"key":".vsw", "value": "application/vnd.visio"},
            {"key":".vsx", "value": "application/vnd.visio"},
            {"key":".vtx", "value": "application/vnd.visio"},
            {"key":".wav", "value": "audio/wav"},
            {"key":".wave", "value": "audio/wav"},
            {"key":".wax", "value": "audio/x-ms-wax"},
            {"key":".wbk", "value": "application/msword"},
            {"key":".wbmp", "value": "image/vnd.wap.wbmp"},
            {"key":".wcm", "value": "application/vnd.ms-works"},
            {"key":".wdb", "value": "application/vnd.ms-works"},
            {"key":".wdp", "value": "image/vnd.ms-photo"},
            {"key":".webarchive", "value": "application/x-safari-webarchive"},
            {"key":".webtest", "value": "application/xml"},
            {"key":".wiq", "value": "application/xml"},
            {"key":".wiz", "value": "application/msword"},
            {"key":".wks", "value": "application/vnd.ms-works"},
            {"key":".WLMP", "value": "application/wlmoviemaker"},
            {"key":".wlpginstall", "value": "application/x-wlpg-detect"},
            {"key":".wlpginstall3", "value": "application/x-wlpg3-detect"},
            {"key":".wm", "value": "video/x-ms-wm"},
            {"key":".wma", "value": "audio/x-ms-wma"},
            {"key":".wmd", "value": "application/x-ms-wmd"},
            {"key":".wmf", "value": "application/x-msmetafile"},
            {"key":".wml", "value": "text/vnd.wap.wml"},
            {"key":".wmlc", "value": "application/vnd.wap.wmlc"},
            {"key":".wmls", "value": "text/vnd.wap.wmlscript"},
            {"key":".wmlsc", "value": "application/vnd.wap.wmlscriptc"},
            {"key":".wmp", "value": "video/x-ms-wmp"},
            {"key":".wmv", "value": "video/x-ms-wmv"},
            {"key":".wmx", "value": "video/x-ms-wmx"},
            {"key":".wmz", "value": "application/x-ms-wmz"},
            {"key":".wpl", "value": "application/vnd.ms-wpl"},
            {"key":".wps", "value": "application/vnd.ms-works"},
            {"key":".wri", "value": "application/x-mswrite"},
            {"key":".wrl", "value": "x-world/x-vrml"},
            {"key":".wrz", "value": "x-world/x-vrml"},
            {"key":".wsc", "value": "text/scriptlet"},
            {"key":".wsdl", "value": "text/xml"},
            {"key":".wvx", "value": "video/x-ms-wvx"},
            {"key":".x", "value": "application/directx"},
            {"key":".xaf", "value": "x-world/x-vrml"},
            {"key":".xaml", "value": "application/xaml+xml"},
            {"key":".xap", "value": "application/x-silverlight-app"},
            {"key":".xbap", "value": "application/x-ms-xbap"},
            {"key":".xbm", "value": "image/x-xbitmap"},
            {"key":".xdr", "value": "text/plain"},
            {"key":".xht", "value": "application/xhtml+xml"},
            {"key":".xhtml", "value": "application/xhtml+xml"},
            {"key":".xla", "value": "application/vnd.ms-excel"},
            {"key":".xlam", "value": "application/vnd.ms-excel.addin.macroEnabled.12"},
            {"key":".xlc", "value": "application/vnd.ms-excel"},
            {"key":".xld", "value": "application/vnd.ms-excel"},
            {"key":".xlk", "value": "application/vnd.ms-excel"},
            {"key":".xll", "value": "application/vnd.ms-excel"},
            {"key":".xlm", "value": "application/vnd.ms-excel"},
            {"key":".xls", "value": "application/vnd.ms-excel"},
            {"key":".xlsb", "value": "application/vnd.ms-excel.sheet.binary.macroEnabled.12"},
            {"key":".xlsm", "value": "application/vnd.ms-excel.sheet.macroEnabled.12"},
            {"key":".xlsx", "value": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"},
            {"key":".xlt", "value": "application/vnd.ms-excel"},
            {"key":".xltm", "value": "application/vnd.ms-excel.template.macroEnabled.12"},
            {"key":".xltx", "value": "application/vnd.openxmlformats-officedocument.spreadsheetml.template"},
            {"key":".xlw", "value": "application/vnd.ms-excel"},
            {"key":".xml", "value": "text/xml"},
            {"key":".xmta", "value": "application/xml"},
            {"key":".xof", "value": "x-world/x-vrml"},
            {"key":".XOML", "value": "text/plain"},
            {"key":".xpm", "value": "image/x-xpixmap"},
            {"key":".xps", "value": "application/vnd.ms-xpsdocument"},
            {"key":".xrm-ms", "value": "text/xml"},
            {"key":".xsc", "value": "application/xml"},
            {"key":".xsd", "value": "text/xml"},
            {"key":".xsf", "value": "text/xml"},
            {"key":".xsl", "value": "text/xml"},
            {"key":".xslt", "value": "text/xml"},
            {"key":".xsn", "value": "application/octet-stream"},
            {"key":".xss", "value": "application/xml"},
            {"key":".xtp", "value": "application/octet-stream"},
            {"key":".xwd", "value": "image/x-xwindowdump"},
            {"key":".z", "value": "application/x-compress"},
            {"key":".zip", "value": "application/x-zip-compressed"}
        ]
    let index = myList.map((o) => o.key).indexOf(ext);
    let mime = myList[index]["value"];
    return mime

}

function base64ToArrayBuffer(base64) {
    var binaryString = window.atob(base64);
    var binaryLen = binaryString.length;
    var bytes = new Uint8Array(binaryLen);
    for (var i = 0; i < binaryLen; i++) {
        var ascii = binaryString.charCodeAt(i);
        bytes[i] = ascii;
    }
    return bytes;
}

function DownloadFileFromBytes(fileName,contentType, byte) {
    var blob = new Blob(byte, { type: contentType });
    var link = document.createElement("a");
    link.href = window.URL.createObjectURL(blob);
    link.download = fileName;
    link.click();
}
function htmlDecode(input) {
    var doc = new DOMParser().parseFromString(input, "text/html");
    return doc.documentElement.textContent;
}

//handle ajax error function
$.handleError = function (ajax, xhr) {
    console.log('Error Details:', {
        Url: ajax.url,
        ResponseText: xhr.responseText
    });
};

/**
* Helper function to sanitize text by removing specific tags.
* @param {string} text - The text to sanitize.
* @returns {string} - The sanitized text.
*/
$.sanitizePTag = function (text) {
    if (text == null) {
        return ''; // Return an empty string if text is null or undefined
    }
    return text.replace(/<\/?p>/g, ''); // Remove <p> and </p> tags
}

$.getURLParam = function (name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results == null) {
        return null;
    }
    return encodeURIComponent(decodeURI(results[1])) || 0;
}

function GetDateWithFormat(date, sep = '/') {
    try {
        if (date !== null && date !== undefined) {
            var dob = date.split('T');
            var datesplit = dob[0].split('-');
            var finaldate = datesplit[2] + sep + datesplit[1] + sep + datesplit[0];
            return finaldate;
        } else {
            return "-";
        }
    }
    catch (err) {
        return "-";
    }
}