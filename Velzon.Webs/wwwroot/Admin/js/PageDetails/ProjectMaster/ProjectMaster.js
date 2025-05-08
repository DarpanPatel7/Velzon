/**
 * Page Project Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'Project';
    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageView = document.getElementById("frmPageView").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        // Your DataTable configurations
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "projectName", name: "Title", autoWidth: true },
            {
                data: "projectDate", autoWidth: true,
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
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateProjectStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    let downloadLinks = '';
                    const hasImage = row.filePath && row.filePath !== '';
                    if (hasImage) {
                        const downloadUrl = ResolveUrl(`/Admin/DownloadFile?fileName=${GreateHashString(row.filePath)}`);
                        const viewUrl = ResolveUrl(`/Admin/ViewFile?fileName=${GreateHashString(row.filePath)}`);
                        downloadLinks = `<a class="link-primary fs-15" title="Download" href="${downloadUrl}"><i class="ri-download-2-line"></i></a>
                                        <a class="link-secondary fs-15" title="View" target="_blank" href="${viewUrl}"><i class="ri-eye-line"></i></a>`;
                    }
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetProjectDetails')}' data-id='${FrontValue(row.id)}' data-language='${FrontValue(1)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteProjectData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

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

    $('#ImageName').change(function () {
        if ($('#ImageName').val() != '') {
            $("#ViewfileIF").css('display', 'none');
        }
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
            datatable: datatable, // ✅ Use global datatable
        });
    });

    // open form modal
    $(document).on("click", "#add" + main, function () {
        $.BindLanguage();
        CreateSetDatePicker("ProjectDate");
        $('#ViewfileIF').css('display', 'none');
        $('#LanguageId').val("1").attr("selected", "selected");
        $('#LanguageId').attr('disabled', true);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0,
                Description: CKEDITOR.instances['Description'].setData("")
            },
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", async function () {
        if ($.ValidateAndShowError($('#ProjectName'), "project name", "none")) return;
        if ($.ValidateAndShowError($('#ProjectDate'), "project date", "none")) return;
        $("#Description").val(sanitizeCKEditorHTML(CKEDITOR.instances['Description'].getData()));
        if (!ValidateControl($('#Description'))) {
            ShowMessage("Please enter description!", "", "error");
            return false;
        }
        if ($('#Id').val() === '0') {
            if ($.ValidateImageAndShowError('#File', "upload document", true)) return;
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
            datatable: datatable,
        });
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
                            if (key == ("imageName") || key == ("imageName")) {
                            }
                            else if (key.includes("is")) {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                            }
                            else if (key == "title") {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                            else if (key == "url") {
                                $('#URL').val(dataList[key]);
                            }
                            else if (key == "description") {
                                CKEDITOR.instances['Description'].setData(dataList[key]);
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                            else if (key == "projectDate") {
                                CreateSetDatePicker("ProjectDate", dataList[key])
                            }
                            else if (key.includes("filePath")) {
                                $('#FilePath').val(dataList[key]);
                                handleImageVisibility('#ViewfileIF', dataList[key]);
                            }
                            else {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                        }
                    });
                }
                else {
                    $('#ProjectName').val('');
                    $('#ProjectDate').val('');
                    $('#MetaTitle').val('');
                    $('#MetaDescription').val('');
                    $('#Location').val('');
                    $('#IsActive').prop('checked', false);
                    CKEDITOR.instances['Description'].setData("");
                    $('#File').val('');
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
            datatable: datatable, // ✅ Use global datatable
        });
    });

    $("#LanguageId").change(async function () {
        if (ValidateControl($("#LanguageId")) && ValidateControl($("#Id"))) {
            var intLang = parseInt($("#LanguageId").val());
            var intId = parseInt($("#Id").val());
            if (intLang > 0 && intId > 0) {
                let id = FrontValue(intId); // Get edit id
                let langId = FrontValue(intLang); // Get langauge id
                await safeAjax({
                    url: ResolveUrl('/Admin/GetProjectDetails'),
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
                                    if (key == ("imageName") || key == ("imageName")) {
                                    }
                                    else if (key.includes("is")) {
                                        $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                                    }
                                    else if (key == "title") {
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                    else if (key == "url") {
                                        $('#URL').val(dataList[key]);
                                    }
                                    else if (key == "description") {
                                        CKEDITOR.instances['Description'].setData(dataList[key]);
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                    else if (key == "projectDate") {
                                        CreateSetDatePicker("ProjectDate", dataList[key])
                                    }
                                    else if (key.includes("filePath")) {
                                        $('#FilePath').val(dataList[key]);
                                        handleImageVisibility('#ViewfileIF', dataList[key]);
                                    }
                                    else {
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                }
                            });
                        }
                        else {
                            $('#ProjectName').val('');
                            $('#ProjectDate').val('');
                            $('#MetaTitle').val('');
                            $('#MetaDescription').val('');
                            $('#Location').val('');
                            $('#IsActive').prop('checked', false);
                            CKEDITOR.instances['Description'].setData("");
                            $('#File').val('');
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

    function handleImageVisibility(viewFileSelector, imagePath) {
        if (imagePath && imagePath !== '') {
            $(viewFileSelector).css('display', 'block');
            $(viewFileSelector).attr('href', ResolveUrl("/Admin/ViewFile?fileName=") + GreateHashString(imagePath));
        } else {
            $(viewFileSelector).css('display', 'none');
        }
    }
});
