/**
 * Page CMS Menu Resource Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'CMSMenuResource';
    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        // Your DataTable configurations
        initComplete: function () {
            MergeGridCells("datatable" + main, [5]); // Apply initially
        },
        drawCallback: function () {
            MergeGridCells("datatable" + main, [5]); // Reapply on page change
        },
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "menuName", name: "MenuName", autoWidth: true },
            { data: "menuURL", name: "MenuURL", autoWidth: true },
            { data: "col_menu_type", name: "Menu Resource Type", autoWidth: true },
            { data: "parentName", name: "ParentName", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateCMSMenuResourceStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetCMSMenuResourceDataDetails')}' data-id='${FrontValue(row.id)}' data-language='${FrontValue(1)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    if (row.col_menu_type != null && row.col_menu_type !== "" && (row.col_menu_type === "ParentMenu" || row.col_menu_type === "ChildMenu")) {
                        strEdit += `<a href='javascript:void(0);' class='link-warning fs-15' onclick="SwapModel('${FrontValue(row.menuRank)}', '${FrontValue('up')}', '${FrontValue(row.col_menu_type)}', '${FrontValue(row.col_parent_id)}')" title='Move Up'><i class='ri-arrow-up-line'></i></a>`;
                        strEdit += `<a href='javascript:void(0);' class='link-warning fs-15' onclick="SwapModel('${FrontValue(row.menuRank)}', '${FrontValue('down')}', '${FrontValue(row.col_menu_type)}', '${FrontValue(row.col_parent_id)}')" title='Move Down'><i class='ri-arrow-down-line'></i></a>`;
                    }
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteCMSMenuResourceData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

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

    $('#BannerImage').change(function () {
        if ($('#BannerImage').val() != '') {
            $("#ViewfileIF").css('display', 'none');
        }
    });

    $('#IconImage').change(function () {
        if ($('#IconImage').val() != '') {
            $("#ViewfileIF1").css('display', 'none');
        }
    });

    $("#col_menu_type").change(function () {
        ValidateParentOrNot();
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
        ValidateParentOrNot();
        BindParentCMSMenu(null);
        BindMenuType();
        BindMenuTypes();
        $('#dvParentId').hide();
        $('#ViewfileIF').css('display', 'none');
        $('#ViewfileIF1').css('display', 'none');
        $('#LanguageId').val("1").attr("selected", "selected");
        $('#LanguageId').attr('disabled', true);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0
            }
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", function () {
        if ($.ValidateAndShowError($('#ResourceType'), "resource type", "dropdown", "Please select a resource type!")) return;
        if ($.ValidateAndShowError($('#MenuName'), "menu name", "none")) return;
        if ($.ValidateAndShowError($('#Tooltip'), "tooltip", "none")) return;
        if ($.ValidateAndShowError($('#MenuURL'), "menu url", "none")) return;
        if ($.ValidateAndShowError($('#MetaTitle'), "meta title", "text")) return;
        if ($.ValidateAndShowError($('#MetaDescription'), "meta description", "text")) return;
        if ($.ValidateAndShowError($('#col_menu_type'), "menu type", "dropdown", "Please select a menu type!")) return;
        if ($('#col_menu_type').val() == "1" && $.ValidateAndShowError($('#col_parent_id'), "parent menu", "dropdown", "Please select parent menu!")) return;
        if ($.ValidateImageAndShowError('#BannerImage', "Banner Image", false)) return;
        if ($.ValidateImageAndShowError('#IconImage', "Icon Image", false)) return;
        $('#LanguageId').attr('disabled', false);
        $("#PageDescription").val(sanitizeCKEditorHTML(CKEDITOR.instances['PageDescription'].getData()));
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
        BindMenuType();
        BindMenuTypes();
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
                $.easyAjax({
                    type: "POST",
                    url: ResolveUrl("/Admin/BindParentCMSMenus"),
                    data: { lgId: dataList.id },
                    success: function (res) {
                        $("#col_parent_id").empty();
                        $.each(res, function (data, value) {
                            $("#col_parent_id").append($("<option></option>").val(value.value).html(value.text));
                        });
                        if (data.isError == true) {
                            ShowMessage(data.strMessage, "Error!", "error");
                            HideLoader();
                        }
                        else if (dataList != null) {
                            Object.keys(dataList).forEach(function (key) {
                                if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                                    if (key.startsWith("is")) {
                                        $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                                    }
                                    else if (key == "pageDescription") {
                                        CKEDITOR.instances['PageDescription'].setData(dataList[key]);
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                    else if (key == "cmsMenuResId") {
                                        $('#CMSMenuResId').val(dataList[key]);
                                    }
                                    else if (key == "col_menu_type") {
                                        $('#col_menu_type').val(dataList[key]);
                                    }
                                    else if (key == "col_parent_id") {

                                        var parentIdstr = "" + dataList[key];
                                        $('#col_parent_id').val(parentIdstr);
                                    }
                                    else if (key === "bannerImagePath") {
                                        handleImageVisibility('#ViewfileIF', dataList[key]);
                                    } else if (key === "iconImagePath") {
                                        handleImageVisibility('#ViewfileIF1', dataList[key]);
                                    }
                                    else {
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                }
                                if ($('#col_menu_type').val() == 1) {
                                    $('#dvParentId').show();
                                }
                                else {
                                    $('#dvParentId').hide();
                                }
                            });
                        }
                        else {
                            $('#MenuName').val('');
                            $('#PageDescription').val('');
                            CKEDITOR.instances['PageDescription'].setData("");
                            $('#ddlTemplateId').val('');
                            $('#Tooltip').val('');
                            $('#col_parent_id').val('');
                            $('#col_menu_type').val('');
                            var valId = FrontdValue(id);
                            $('#Id').val(valId);
                        }
                        $('#LanguageId').attr('readonly', false);
                        HideLoader();
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
        if (ValidateControl($("#LanguageId")) && ValidateControl($("#Id"))) {
            var intLang = parseInt($("#LanguageId").val());
            var intId = parseInt($("#CMSMenuResId").val());
            if (intLang > 0 && intId > 0) {
                $.easyAjax({
                    type: "POST",
                    url: ResolveUrl("/Admin/GetCMSMenuResourceDataDetailsByResId"),
                    data: { "id": encodeURIComponent((intId)), "langId": encodeURIComponent((intLang)) },
                    success: function (data) {
                        var dataList = data.result;
                        if (data.isError == true) {
                            ShowMessage(data.strMessage, "Error!", "error");
                            HideLoader();
                        }
                        else if (dataList != null) {
                            Object.keys(dataList).forEach(function (key) {
                                if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                                    if (key.startsWith("is")) {
                                        $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                                    }
                                    else if (key == "pageDescription") {
                                        CKEDITOR.instances['PageDescription'].setData(dataList[key]);
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                    else if (key == "cmsMenuResId") {
                                        //$('#CMSMenuResId').val(dataList[key]);
                                    }
                                    else if (key == "col_menu_type") {
                                        $('#col_menu_type').val(dataList[key]);
                                    }
                                    else if (key == "col_parent_id") {
                                        $('#col_parent_id').val(dataList[key]);
                                    }
                                    else if (key.includes("bannerImagePath")) {
                                        if (dataList.bannerImagePath != null && dataList.bannerImagePath != '') {
                                            $('#ImagePath').val(dataList.bannerImagePath);
                                            $('#ViewfileIF').css('display', 'block');
                                            $("#ViewfileIF").attr("href", "" + ResolveUrl("/Admin/ViewFile?fileName=") + GreateHashString(dataList.bannerImagePath) + "");
                                        }
                                        else {
                                            $('#ViewfileIF').css('display', 'none');
                                        }
                                    }
                                    else if (key.includes("iconImagePath")) {
                                        if (dataList.iconImagePath != null && dataList.iconImagePath != '') {
                                            $('#ImagePath').val(dataList.iconImagePath);
                                            $('#ViewfileIF1').css('display', 'block');
                                            $("#ViewfileIF1").attr("href", "" + ResolveUrl("/Admin/ViewFile?fileName=") + GreateHashString(dataList.iconImagePath) + "");
                                        }
                                        else {
                                            $('#ViewfileIF1').css('display', 'none');
                                        }
                                    }
                                    else {
                                        $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                    }
                                }
                            });
                        }
                        else {
                            $('#MenuName').val('');
                            $('#Tooltip').val('');
                            $('#PageDescription').val('');
                            CKEDITOR.instances['PageDescription'].setData("");
                        }
                        HideLoader();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        ShowMessage("Something went wrong, Try again!", "Error!", "error");
                        HideLoader();
                    }
                });
            }
        }
    });

    function BindParentCMSMenu(id) {
        ShowLoader();
        if (id == undefined && id == null) {
            $.easyAjax({
                type: "POST",
                url: ResolveUrl("/Admin/BindParentCMSMenus"),
                data: { lgId: id },
                dataType: "json",
                success: function (res) {
                    $("#col_parent_id").empty();
                    $.each(res, function (data, value) {
                        $("#col_parent_id").append($("<option></option>").val(value.value).html(value.text));
                    });
                    HideLoader();
                }

            });
            HideLoader();
        }
        else {
            $.easyAjax({
                type: "POST",
                url: ResolveUrl("/Admin/BindParentCMSMenus"),
                data: { lgId: id },
                success: function (res) {
                    $("#col_parent_id").empty();
                    $.each(res, function (data, value) {
                        $("#col_parent_id").append($("<option></option>").val(value.value).html(value.text));
                    });
                    HideLoader();
                }
            });
            HideLoader();
        }
    }

    function BindMenuTypes() {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/BindMenuType"),
            success: function (res) {
                $("#col_menu_type").empty();
                $.each(res, function (data, value) {
                    $("#col_menu_type").append($("<option></option>").val(value.value).html(value.text));
                });
                HideLoader();
            }
        });
        HideLoader();
    }

    function ValidateParentOrNot() {
        if ($('#col_menu_type').val() == "1" && $('#col_menu_type').val() != undefined && $('#col_menu_type').val() != null) {
            $('#dvParentId').show();
            var lgid = $('#LanguageId').val();
            BindParentCMSMenu(lgid);
        }
        else {
            $('#dvParentId').hide();
        }
    }

    function BindMenuType() {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/BindMenuResourceType"),
            success: function (res) {
                $("#ResourceType").empty();
                $.each(res, function (data, value) {
                    $("#ResourceType").append($("<option></option>").val(value.value).html(value.text));
                });
                HideLoader();
            }
        });
        HideLoader();
    }

    function handleImageVisibility(viewFileSelector, imagePath) {
        if (imagePath && imagePath !== '') {
            $(viewFileSelector).css('display', 'block');
            $(viewFileSelector).attr('href', ResolveUrl("/Admin/ViewFile?fileName=") + GreateHashString(imagePath));
        } else {
            $(viewFileSelector).css('display', 'none');
        }
    }

    window.SwapModel = function (row, dir, type, parentid) {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/CMSMenuResourceSwapDetails"),
            data: { "rank": row, "dir": dir, "type": type, "parentid": parentid },
            datatable: datatable, // ✅ Use global datatable
        });
        BindParentCMSMenu(null);
        BindMenuTypes();
        ValidateParentOrNot();
    }
});
