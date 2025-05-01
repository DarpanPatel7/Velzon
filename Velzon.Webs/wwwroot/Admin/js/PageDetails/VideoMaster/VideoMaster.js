/**
 * Page Video Master
 */

"use strict";

var datatableMain; // Declare globally
var datatableSub;

$(function () {
    var main = 'Video';
    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageView = document.getElementById("frmPageView").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    let tableSelectorMain = "#datatable" + main;
    datatableMain = $.initializeDataTable(tableSelectorMain, { // ✅ Assign to global datatable
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "videoTitle", name: "VideoTitle", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateVideoStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetVideoDetails')}' data-id='${FrontValue(row.id)}' data-language='${FrontValue(1)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteVideoData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

                    return "<div class='hstack gap-3 flex-wrap'>" +
                        (frmPageUpdate == "true" ? strEdit : "") +
                        (frmPageDelete == "true" ? strRemove : "") +
                        "</div>";
                },
                autoWidth: true,
                "bSortable": false
            },
        ]
    });

    let tableSelectorSub = "#datatableSub" + main;
    datatableSub = $.initializeDataTable(tableSelectorSub, { // ✅ Assign to global datatable
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "videoName", name: "Video Name", autoWidth: true },
            {
                data: null,
                render: function (data, type, row, meta) {
                    var strpath = "", strDownloadFileimage = "";
                    if (row.urllink == 0) {
                        strpath = ResolveUrl("/Admin/DownloadResourceFile?fileName=" + GreateHashString(row.thumbImage));
                        strDownloadFileimage = `<a class="link-secondary fs-15" title="Download" href="${strpath}" ><i class="ri-download-2-line"></i></a>&nbsp;`;
                    }
                    if (row.urllink == 1) {
                        strDownloadFileimage += `<a class="link-secondary fs-15" title="View" target="_Target" href="${row.thumbImage}"><i class="ri-eye-line"></i></a>&nbsp;`;
                    }
                    var strMain = (frmPageView == "true" ? strDownloadFileimage : "");
                    return strMain;
                }, autoWidth: true
            },
            {
                data: null,
                render: function (data, type, row, meta) {
                    var strpath = "", strDownloadFile = "";
                    if (row.urllink == 0) {
                        strpath = ResolveUrl(`/Admin/DownloadVideoFile?fileName=${GreateHashString(row.videoUrl)}`);
                        strDownloadFile = `<a class="link-secondary fs-15" title="Download" target="_Target" href="${strpath}" ><i class="ri-download-2-line"></i></a>&nbsp;`;
                    }
                    if (row.urllink == 1) {
                        strpath = row.videoUrl;
                        strDownloadFile = `<a class="link-secondary fs-15" title="View" target="_Target" href="${row.videoUrl}" ><i class="ri-eye-line"></i></a>&nbsp;`;
                    }
                    var strMain = (frmPageView == "true" ? strDownloadFile : "");
                    return strMain;
                }, autoWidth: true
            },
            {
                data: null,
                render: function (data, type, row, meta) {
                    var rowIndex = meta.row + meta.settings._iDisplayStart + 1;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 deleteSub${main}' data-url='${ResolveUrl('/Admin/DeleteSubVideo')}' data-id='${FrontValue(rowIndex)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;
                    var strMain = (frmPageDelete == "true" ? strRemove : "");
                    return strMain;
                }, autoWidth: true
            },
        ]
    });

    $('#clearVideoSubmit').click(function () {
        ClearVideo();
    });

    // Delete Record
    $(document).on("click", ".delete" + main, async function () {
        let url = $(this).attr("data-url"); // Get delete URL
        let id = $(this).attr("data-id"); // Get delete id
        await safeAjax({
            url: url,
            type: "POST",
            data: { id: id }, // Send id in the request body
            blockUI: true,
            confirmation: true,
            datatable: datatableMain, // ✅ Use global datatable
        });
    });

    // Delete Image
    $(document).on("click", ".deleteSub" + main, async function () {
        let url = $(this).attr("data-url"); // Get delete URL
        let id = $(this).attr("data-id"); // Get delete id
        await safeAjax({
            url: url,
            type: "POST",
            data: { id: id }, // Send id in the request body
            blockUI: true,
            confirmation: true
        });
        // Reload the DataTable
        datatableSub.ajax.reload();
    });

    // open form modal
    $(document).on("click", "#add" + main, async function () {
        $.BindLanguage();
        ClearVideo()
        $('#LanguageId').val("1").attr("selected", "selected");
        $('#LanguageId').attr('disabled', true);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0,
                VideoId: 0
            },
        });
        $.resetForm('#addeditSub' + main + 'Form', {
            defaultValues: {
                RowIndex: 0,
                Command: 0,
                urllink: 0
            },
        });
        $.getradiovalue($("input[name=customRadioInline3]")[0]);
        await safeAjax({
            url: ResolveUrl('/Admin/GetVideoDetails'),
            type: "POST",
            data: { "id": encodeURIComponent(0), "langId": encodeURIComponent(1) }, // Send id in the request body
            blockUI: true,
            success: function (data) {
                var dataList = data.result;
                if (data.isError == true) {
                    ShowMessage(data.strMessage, "", "error");
                    HideLoader();
                }
                else if (dataList != null) {
                    Object.keys(dataList).forEach(function (key) {
                        if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                            if (key.startsWith("is")) {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                            }
                            else {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                        }
                    });
                }
                else {
                    $.resetForm('#addedit' + main + 'Form', {
                        defaultValues: {
                            Id: 0,
                            VideoId: 0
                        },
                    });
                }
                datatableSub.ajax.reload();
                $('#addedit' + main + 'Modal').modal('show');
                HideLoader();
            },
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", async function () {
        if ($.ValidateAndShowError($('#VideoTitle'), "section name", "none")) return;
        if ($("#datatableSubVideo")[0].rows[1].cells[0].innerHTML == 'No data available in table') {
            ShowMessage("Please save atleast one video!", "Error!", "error");
            return false;
        }
        $('#LanguageId').attr('disabled', false);
        await safeAjax({
            container: "#addedit" + main + "Form",
            type: "POST",
            buttonSelector: "#addedit" + main + "Submit",
            blockUI: "#addedit" + main + "Modal .modal-content",
            disableButton: true,
            formReset: true,
            file: true,
            restrictPopupClose: true,
            datatable: datatableMain,
        });
        $('#LanguageId').attr('disabled', true);
    });

    // add video
    $(document).on("click", "#saveVideoSubmit", async function () {
        if ($("input[name=customRadioInline3]")[0].checked) {
            if ($.ValidateAndShowError($('#VideoName'), "video name", "text")) return;
            if ($.ValidateAndShowError($('#ThumbImage'), "thumb image url", "none")) return;
            if ($.ValidateAndShowError($('#VideoUrl'), "video url", "none")) return;
        }
        else {
            if ($.ValidateAndShowError($('#VideoName'), "video name", "none")) return;
            if ($.ValidateImageAndShowError('#ThumbFile', "upload image", true)) return;
            if ($.ValidateFileAndShowError('#Image', "Upload Video", true, ['mp4', 'mov', 'avi', 'mkv', 'wmv'])) return;
        }
        $('#LanguageId').attr('disabled', false);
        await safeAjax({
            container: "#addeditSub" + main + "Form",
            type: "POST",
            buttonSelector: "#saveVideoSubmit",
            blockUI: "#addedit" + main + "Modal .modal-content",
            disableButton: true,
            formReset: true,
            file: true,
            restrictPopupClose: true,
        });
        // Reload the DataTable
        datatableSub.ajax.reload();
        $.getradiovalue($("input[name=customRadioInline3]")[0]);
        $('#LanguageId').attr('disabled', true);
    });

    // render edit data
    $(document).on("click", ".edit" + main, async function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        let langId = $(this).attr("data-language"); // Get langauge id
        $.BindLanguage();
        $.getradiovalue($("input[name=customRadioInline3]")[0]);
        await safeAjax({
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
                    Object.keys(dataList).forEach(function (key) {
                        if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                            if (key.startsWith("is")) {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                            }
                            else {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                        }
                    });
                }
                else {
                    ClearForm();
                }
                $('#LanguageId').attr('readonly', false);
                datatableSub.ajax.reload();
                $("#addedit" + main + "Modal").modal('show');
                HideLoader();
            },
        });
    });

    // Handle status change
    $(document).on("click", ".status" + main, async function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        let $switch = $(this); // Store reference to the switch element
        let isActive = $switch.is(":checked") ? 1 : 0;
        await safeAjax({
            url: url,
            type: "POST",
            data: { Id: id, IsActive: isActive }, // Send id in the request body
            blockUI: true,
            confirmation: true,
            statusSwitch: $switch,
            datatable: datatableMain, // ✅ Use global datatable
        });
    });

    $("#LanguageId").change(async function () {
        if (ValidateControl($("#LanguageId")) && ValidateControl($("#VideoId"))) {
            var intLang = parseInt($("#LanguageId").val());
            var intId = parseInt($("#VideoId").val());
            if (intLang > 0 && intId > 0) {
                let id = FrontValue(intId); // Get edit id
                let langId = FrontValue(intLang); // Get langauge id
                await safeAjax({
                    url: ResolveUrl('/Admin/GetVideoDataDetails'),
                    type: "POST",
                    data: { "id": encodeURIComponent(id), "langId": encodeURIComponent(langId) }, // Send id in the request body
                    showModal: "#addedit" + main + "Modal",
                    blockUI: true,
                    success: function (data) {
                        var dataList = data.result;
                        if (data.isError == true) {
                            ShowMessage(data.strMessage, "", "error");
                            HideLoader();
                        }
                        else if (dataList != null) {
                            Object.keys(dataList).forEach(function (key) {
                                if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                                    if (key.startsWith("is")) {
                                        $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                                    }
                                    else {
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                }
                            });
                        }
                        else {
                            $('#VideoTitle').val('');
                        }
                        HideLoader();
                    },
                });
            }
        }
    });

    function ClearVideo() {
        $("#RowIndex").val('0');
        $("#VideoName").val('');
        $("#ThumbImage").val('');
        $("#VideoUrl").val('');
        $('#ThumbFile').val('');
        $('#RowIndex').val('0');
        $('#Command').val('0');
        $('#Image').val('');
        $('#DocImage').val('');
    }

    $.getradiovalue = function(e) {
        if (e.id == 'customRadioInline3') {
            $("#vnameid").show();
            $("#thumbid").hide();
            $("#vurlid").hide();
            $("#vimagesid").show();
            $("#thumbiploadid").show();
            $("#urllink").val(0);
        }
        else {
            $("#vnameid").show();
            $("#thumbid").show();
            $("#vurlid").show();
            $("#vimagesid").hide();
            $("#thumbiploadid").hide();
            $("#urllink").val(1);
        }
    }
});