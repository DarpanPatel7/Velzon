/**
 * Page CMS Template Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'CMSTemplate';
    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "templateName", name: "TemplateName", autoWidth: true },
            { data: "templateType", name: "TemplateType", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateCMSTemplateStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetCMSTemplateDataDetails')}' data-id='${FrontValue(row.id)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteCMSTemplateData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

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
        BindMenuType();
        $('#LanguageId').val("1").attr("selected", "selected");
        $('#LanguageId').attr('disabled', true);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0,
                TemplateId: 0,
                Content: CKEDITOR.instances['Content'].setData("")
            }
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", function () {
        if ($.ValidateAndShowError($('#TemplateType'), "template type", "dropdown", "Please select a template type!")) return;
        if ($.ValidateAndShowError($('#TemplateName'), "template name", "text")) return;
        $('#LanguageId').attr('disabled', false);
        $("#Content").val(sanitizeCKEditorHTML(CKEDITOR.instances['Content'].getData()));
        $.easyAjax({
            container: "#addedit" + main + "Form",
            type: "POST",
            buttonSelector: "#addedit" + main + "Submit",
            blockUI: "#addedit" + main + "Modal .modal-content",
            disableButton: true,
            formReset: true,
            restrictPopupClose: true,
            datatable: datatable,
        });
    });

    // render edit data
    $(document).on("click", ".edit" + main, function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        $.BindLanguage();
        BindMenuType();
        $.easyAjax({
            url: url,
            type: "POST",
            data: { id: id, langId: FrontValue(1) }, // Send id in the request body
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            success: function (data) {
                var dataList = data.result;
                Object.keys(dataList).forEach(function (key) {
                    if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                        if (key.includes("is")) {
                            $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                        }
                        else if (key == "content") {
                            CKEDITOR.instances['Content'].setData(dataList[key]);
                            $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                        }
                        else {
                            $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                        }
                    }
                });
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
        if (ValidateControl($("#LanguageId")) && ValidateControl($("#TemplateId"))) {
            var intLang = parseInt($("#LanguageId").val());
            var intId = parseInt($("#TemplateId").val());
            if (intLang > 0 && intId > 0) {
                $.easyAjax({
                    type: "POST",
                    url: ResolveUrl("/Admin/GetCMSTemplateDataDetailsByTempId"),
                    data: { "id": encodeURIComponent(intId), "langId": encodeURIComponent(intLang) },
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
                                    else if (key == "templateName") {
                                        //$('#CMSMenuResId').val(dataList[key]);
                                    }
                                    else if (key == "content") {
                                        CKEDITOR.instances['Content'].setData(dataList[key]);
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                    else {
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                }

                            });
                        }
                        else {
                            $('#Content').val('');
                            CKEDITOR.instances['Content'].setData("");
                        }
                        HideLoader();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        ShowMessage("Something went wrong, Try again!", "", "error");
                        HideLoader();
                    }
                });
            }
        }
    });

    function BindMenuType() {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/BindCMSTemplateType"),
            success: function (res) {
                $("#TemplateType").empty();
                $.each(res, function (data, value) {
                    $("#TemplateType").append($("<option></option>").val(value.value).html(value.text));
                });
                HideLoader();
            }
        });
        HideLoader();
    }

});
