/**
 * Page News Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'News';
    var yesLink = '<td><span class="badge badge-soft-success text-uppercase">Yes</span></td>';
    var noLink = '<td><span class="badge badge-soft-danger text-uppercase">No</span></td>';
    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageView = document.getElementById("frmPageView").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "newsTypeName", name: "NewsType", autoWidth: true },
            { data: "newsTitle", name: "NewsTitle", autoWidth: true },
            {
                data: "publicDate", autoWidth: true,
                render: function (data) {
                    if (data == null) {
                        return data;
                    }
                    else {
                        var new_data = data.split("T");
                        new_data[0] = formatDate(new_data[0]);
                        return new_data[0];
                    }
                }
            },
            {
                data: "archiveDate", autoWidth: true,
                render: function (data) {
                    if (data == null) {
                        return data;
                    }
                    else {
                        var new_data = data.split("T");
                        new_data[0] = formatDate(new_data[0]);
                        return new_data[0];
                    }
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    return row.isLink ? yesLink : noLink;
                }, autoWidth: true
            },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateNewsStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    let downloadLinks = '';
                    const hasImage = row.imagePath && row.imagePath !== '';
                    if (hasImage) {
                        const downloadUrl = ResolveUrl(`/Admin/DownloadFile?fileName=${GreateHashString(row.imagePath)}`);
                        const viewUrl = ResolveUrl(`/Admin/ViewFile?fileName=${GreateHashString(row.imagePath)}`);
                        downloadLinks = `<a class="link-primary fs-15" title="Download" href="${downloadUrl}"><i class="ri-download-2-line"></i></a>
                                        <a class="link-secondary fs-15" title="View" target="_blank" href="${viewUrl}"><i class="ri-eye-line"></i></a>`;
                    }
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetNewsDetails')}' data-id='${FrontValue(row.id)}' data-language='${FrontValue(1)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteNewsData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

                    return "<div class='hstack gap-3 flex-wrap'>" +
                        (frmPageUpdate == "true" ? strEdit : "") +
                        (frmPageView == "true" ? downloadLinks : "") +
                        (frmPageDelete == "true" ? strRemove : "") +
                        "</div>";
                },
                autoWidth: true,
                "bSortable": false
            },
        ]
    });

    $("#IsLink").on("click", function () {
        $("#ImageNameDiv").toggle(!this.checked);
    });

    $('#ImageName').change(function () {
        if ($('#ImageName').val() != '') {
            $("#ViewfileIF").css('display', 'none');
        }
    });

    CreateSetDatePicker("PublicDate");
    CreateSetDatePicker("ArchiveDate");

    $('#PublicDate').change(function () {
        var date1 = $('#PublicDate').val()
        SetMinDate($('#ArchiveDate'), date1);
    });

    $('#ArchiveDate').change(function () {
        var date1 = $('#ArchiveDate').val()
        SetMaxDate($('#PublicDate'), date1);
    });

    // Delete Record
    $(document).on("click", ".delete" + main, function () {
        let url = $(this).attr("data-url"); // Get delete URL
        let id = $(this).attr("data-id"); // Get delete id
        $.easyAjax({
            url: url,
            type: "POST",
            data: { id: id }, // Send id in the request body
            blockUI: true,
            confirmation: true,
            datatable: datatable, // ✅ Use global datatable
        });
    });

    // open form modal
    $(document).on("click", "#add" + main, function () {
        $.BindLanguage();
        $('#ViewfileIF').css('display', 'none');
        $('#LanguageId').val("1").attr("selected", "selected");
        $('#LanguageId').attr('disabled', true);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0,
                Subject: CKEDITOR.instances['NewsDesc'].setData("")
            },
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", function () {
        if ($.ValidateAndShowError($('#NewsTypeId'), "news type", "dropdown", "Please select a news type!")) return;
        if ($.ValidateAndShowError($('#NewsTitle'), "news title", "none")) return;
        if ($.ValidateAndShowError($('#PublicDate'), "public date", "none")) return;
        $("#NewsDesc").val(sanitizeCKEditorHTML(CKEDITOR.instances['NewsDesc'].getData()));
        if (!ValidateControl($('#NewsDesc'))) {
            ShowMessage("Please enter description!", "", "error");
            return false;
        }
        $('#LanguageId').attr('disabled', false);
        $.easyAjax({
            container: "#addedit" + main + "Form",
            type: "POST",
            buttonSelector: "#addedit" + main + "Submit",
            blockUI: "#addedit" + main + "Modal .modal-content",
            disableButton: true,
            formReset: true,
            file: true,
            restrictPopupClose: true,
            datatable: datatable,
        });
    });

    // render edit data
    $(document).on("click", ".edit" + main, function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        let langId = $(this).attr("data-language"); // Get langauge id
        $.BindLanguage();
        $.easyAjax({
            url: url,
            type: "POST",
            data: { "id": encodeURIComponent(id), "langId": encodeURIComponent(langId) }, // Send id in the request body
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            success: function (data) {
                $('#LanguageId').attr('disabled', false);
                var dataList = data.result;
                if (data.isError == true) {
                    ShowMessage(data.strMessage, "", "error");
                    HideLoader();
                }
                else if (dataList != null) {
                    $("#PublicDate").val('');
                    $("#ArchiveDate").val('');
                    Object.keys(dataList).forEach(function (key) {
                        if (dataList.isLink != true) {
                            $("#ImageNameDiv").show();
                        }
                        else {
                            $("#ImageNameDiv").hide();
                        }
                        if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + capitalizeFirstLetter(key)) != undefined && capitalizeFirstLetter(key) != "ImageName") {
                            if (key == "isLink") {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                            }
                            else if (key.includes("is")) {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                            }
                            else if (key == "publicDate") {
                                CreateSetDatePicker("PublicDate", dataList[key])
                            }
                            else if (key == "archiveDate") {
                                CreateSetDatePicker("ArchiveDate", dataList[key])
                            }
                            else if (key.includes("imagePath")) {
                                if (dataList.imagePath != null && dataList.imagePath != '') {
                                    $('#ImagePath').val(dataList.imagePath);
                                    $('#ViewfileIF').css('display', 'block');
                                    $("#ViewfileIF").attr("href", "" + ResolveUrl("/Admin/ViewFile?fileName=") + GreateHashString(dataList.imagePath) + "");
                                    $('#IsLink').prop('checked', false);
                                }
                                else {
                                    $('#ImagePath').val('');
                                    $('#ViewfileIF').css('display', 'none');
                                }
                            }
                            else if (key == "newsDesc") {
                                CKEDITOR.instances['NewsDesc'].setData(dataList[key]);
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                            else if (key == "imageName") {
                            }
                            else {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                        }
                    });
                }
                else {
                    CKEDITOR.instances['NewsDesc'].setData("");
                    var valId = FrontdValue(id);
                    $('#Id').val(valId);
                }
                $('#LanguageId').attr('readonly', false);
                $("#addedit" + main + "Modal").modal('show');
                HideLoader();
            },
        });
    });

    // Handle status change
    $(document).on("click", ".status" + main, function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        let $switch = $(this); // Store reference to the switch element
        let isActive = $switch.is(":checked") ? 1 : 0;
        $.easyAjax({
            url: url,
            type: "POST",
            data: { Id: id, IsActive: isActive }, // Send id in the request body
            blockUI: true,
            confirmation: true,
            statusSwitch: $switch,
            datatable: datatable, // ✅ Use global datatable
        });
    });

    $("#LanguageId").change(function () {
        if (ValidateControl($("#LanguageId")) && ValidateControl($("#Id"))) {
            var intLang = parseInt($("#LanguageId").val());
            var intId = parseInt($("#Id").val());
            if (intLang > 0 && intId > 0) {
                let id = FrontValue(intId); // Get edit id
                let langId = FrontValue(intLang); // Get langauge id
                $.easyAjax({
                    url: ResolveUrl('/Admin/GetNewsDetails'),
                    type: "POST",
                    data: { "id": encodeURIComponent(id), "langId": encodeURIComponent(langId) }, // Send id in the request body
                    showModal: "#addedit" + main + "Modal",
                    blockUI: true,
                    success: function (data) {
                        $('#LanguageId').attr('disabled', false);
                        var dataList = data.result;
                        if (data.isError == true) {
                            ShowMessage(data.strMessage, "", "error");
                            HideLoader();
                        }
                        else if (dataList != null) {
                            $("#PublicDate").val('');
                            $("#ArchiveDate").val('');
                            Object.keys(dataList).forEach(function (key) {
                                if (dataList.isLink != true) {
                                    $("#ImageNameDiv").show();
                                }
                                else {
                                    $("#ImageNameDiv").hide();
                                }
                                if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + capitalizeFirstLetter(key)) != undefined && capitalizeFirstLetter(key) != "ImageName") {
                                    if (key == "isLink") {
                                        $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                                    }
                                    else if (key.includes("is")) {
                                        $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                                    }
                                    else if (key == "publicDate") {
                                        CreateSetDatePicker("PublicDate", dataList[key])
                                    }
                                    else if (key == "archiveDate") {
                                        CreateSetDatePicker("ArchiveDate", dataList[key])
                                    }
                                    else if (key.includes("imagePath")) {
                                        if (dataList.imagePath != null && dataList.imagePath != '') {
                                            $('#ImagePath').val(dataList.imagePath);
                                            $('#ViewfileIF').css('display', 'block');
                                            $("#ViewfileIF").attr("href", "" + ResolveUrl("/Admin/ViewFile?fileName=") + GreateHashString(dataList.imagePath) + "");
                                            $('#IsLink').prop('checked', false);
                                        }
                                        else {
                                            $('#ImagePath').val('');
                                            $('#ViewfileIF').css('display', 'none');
                                        }
                                    }
                                    else if (key == "newsDesc") {
                                        CKEDITOR.instances['NewsDesc'].setData(dataList[key]);
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                    else if (key == "imageName") {
                                    }
                                    else {
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                }
                            });
                        }
                        else {
                            CKEDITOR.instances['NewsDesc'].setData("");
                            var valId = FrontdValue(id);
                            $('#Id').val(valId);
                        }
                        $('#LanguageId').attr('readonly', false);
                        $("#addedit" + main + "Modal").modal('show');
                        HideLoader();
                    },
                });
            }
        }
    });

    function SetMinDate(obj, date) {
        $(obj).datepicker('setStartDate', date);
    }

    function SetMaxDate(obj, date) {
        $(obj).datepicker('setEndDate', date);
    }
});