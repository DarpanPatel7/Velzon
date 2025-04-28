/**
 * Page Gallery Master
 */

"use strict";

var datatableMain; // Declare globally
var datatableSub;

$(function () {
    var main = 'Gallery';
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
            { data: "placeName", name: "Doc_Name", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateGalleryStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetGalleryDetails')}' data-id='${FrontValue(row.id)}' data-language='${FrontValue(1)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteGalleryData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

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
            {
                data: null,
                render: function (data, type, row) {
                    var viewstrDownloadFile = ResolveUrl("/ViewFile?fileName=" + GreateHashString(row.imagePath));
                    return `<img src="${viewstrDownloadFile}" width="100" height="100">`;
                }, autoWidth: true
            },
            {
                data: null,
                render: function (data, type, row, meta) {
                    var rowIndex = meta.row + meta.settings._iDisplayStart + 1;
                    let downloadLinks = '';
                    const hasImage = row.imagePath && row.imagePath !== '';
                    if (hasImage) {
                        const downloadUrl = ResolveUrl(`/Admin/DownloadFile?fileName=${GreateHashString(row.imagePath)}`);
                        downloadLinks = `<a class="link-primary fs-15" title="Download" href="${downloadUrl}"><i class="ri-download-2-line"></i></a>`;
                    }
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 deleteImage${main}' data-url='${ResolveUrl('/Admin/DeleteGallaryImageData')}' data-id='${FrontValue(rowIndex) }' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

                    return "<div class='hstack gap-3 flex-wrap'>" +
                        (frmPageView == "true" ? downloadLinks : "") +
                        (frmPageDelete == "true" ? strRemove : "") +
                        "</div>";
                },
                autoWidth: true,
                "bSortable": false
            },
        ]
    });

    $('#clearImageSubmit').click(function () {
        ClearImage();
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
    $(document).on("click", ".deleteImage" + main, async function () {
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
        ClearImage()
        $('#LanguageId').val("1").attr("selected", "selected");
        $('#LanguageId').attr('disabled', true);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0,
                GallerymasterId: 0
            },
        });
        $.resetForm('#addeditSub' + main + 'Form', {
            defaultValues: {
                RowIndex: 0,
                Command: 0,
                IsVideoGallery: 'false'
            },
        });
        await safeAjax({
            url: ResolveUrl('/Admin/GetGalleryDetails'),
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
                            GallerymasterId: 0
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
        if ($.ValidateAndShowError($('#PlaceName'), "album name", "none")) return;
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

    // add image
    $(document).on("click", "#saveImageSubmit", async function () {
        if ($.ValidateImageAndShowError('#Image', "image", true)) return;
        if (document.getElementById("Image").files.length > 30) {
            ShowMessage("Maximum 30 images at one request allowed!", "Error!", "error");
            isError = true;
            return false;
        }
        var size = 0;
        Array.from(document.getElementById("Image").files).forEach(file => {
            size += (file.size / 1000); //kb size
        });
        $('#LanguageId').attr('disabled', false);
        await safeAjax({
            container: "#addeditSub" + main + "Form",
            type: "POST",
            buttonSelector: "#saveImageSubmit",
            blockUI: "#addedit" + main + "Modal .modal-content",
            disableButton: true,
            formReset: true,
            file: true,
            restrictPopupClose: true,
        });
        // Reload the DataTable
        datatableSub.ajax.reload();
        $('#LanguageId').attr('disabled', true);
    });

    // render edit data
    $(document).on("click", ".edit" + main, async function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        let langId = $(this).attr("data-language"); // Get langauge id
        $.BindLanguage();
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
        if (ValidateControl($("#LanguageId")) && ValidateControl($("#GallerymasterId"))) {
            var intLang = parseInt($("#LanguageId").val());
            var intId = parseInt($("#GallerymasterId").val());
            if (intLang > 0 && intId > 0) {
                //let id = FrontValue(intId); // Get edit id
                //let langId = FrontValue(intLang); // Get langauge id
                await safeAjax({
                    url: ResolveUrl('/Admin/GetGalleryDataById'),
                    type: "POST",
                    data: { "id": encodeURIComponent(intId), "langId": encodeURIComponent(intLang) }, // Send id in the request body
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
                            $('#PlaceName').val('');
                        }
                        HideLoader();
                    },
                });
            }
        }
    });

    function ClearImage() {
        $('#RowIndex').val('0');
        $('#Command').val('0');
        $('#Image').val('');
        $('#DocImage').val('');
    }
});