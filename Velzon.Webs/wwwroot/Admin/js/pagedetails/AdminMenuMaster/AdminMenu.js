/**
 * Page Admin Menu Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'AdminMenu';
    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        // Your DataTable configurations
        initComplete: function () {
            MergeGridCells("datatableAdminMenu", [4]); // Apply initially
        },
        drawCallback: function () {
            MergeGridCells("datatableAdminMenu", [4]); // Reapply on page change
        },
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "name", name: "Name", autoWidth: true },
            { data: "menuType", name: "Menu Type", autoWidth: true },
            { data: "parentName", name: "Parent Name", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateAdminMenuStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetAdminMenuDataDetails')}' data-id='${FrontValue(row.id)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    strEdit += `<a href='javascript:void(0);' class='link-warning fs-15' onclick="SwapModel('${FrontValue(row.menuRank)}', '${FrontValue('up')}', '${FrontValue(row.menuType)}', '${FrontValue(row.parentId)}')" title='Move Up'><i class='ri-arrow-up-line'></i></a>`;
                    strEdit += `<a href='javascript:void(0);' class='link-warning fs-15' onclick="SwapModel('${FrontValue(row.menuRank)}', '${FrontValue('down')}', '${FrontValue(row.menuType)}', '${FrontValue(row.parentId)}')" title='Move Down'><i class='ri-arrow-down-line'></i></a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteAdminMenuData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;
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

    $("#MenuType").change(function () {
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
        BindMenu();
        BindParentMenu(null);
        BindMenuType();
        ValidateParentOrNot();
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0
            },
            skipFields: ["IsActive"] // This now merges with Antiforgery token instead of replacing it
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", function () {
        if ($.ValidateAndShowError($('#Name'), "menu name", "text", "Please enter menu name!")) return;
        if ($.ValidateAndShowError($('#MenuId'), "menu resource", "dropdown", "Please select menu resource!")) return;
        if ($.ValidateAndShowError($('#MenuType'), "menu type", "dropdown", "Please select menu type!")) return;
        if ($('#MenuType').val() == "1" && $.ValidateAndShowError($('#ParentId'), "parent menu", "dropdown", "Please select parent menu!")) return;
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
        BindMenu();
        BindMenuType();
        $.easyAjax({
            url: url,
            type: "POST",
            data: { id: id }, // Send id in the request body
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            initSelect2: "#addedit" + main + "Modal",
            success: function (data) {
                var dataList = data.result;
                $.easyAjax({
                    type: "POST",
                    url: ResolveUrl("/Admin/BindParentMenu"),
                    data: { lgId: dataList.id },
                    success: function (res) {
                        $("#ParentId").empty(); // Clear once
                        $.each(res, function (index, value) {
                            if (value.value && value.text) {
                                $("#ParentId").append($("<option></option>").val(value.value).text(value.text));
                            }
                        });
                        Object.keys(dataList).forEach(function (key) {
                            if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                                if (key.includes("is")) {
                                    $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                                } else {
                                    $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                                }
                            }
                        });
                        ValidateParentOrNot();
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

    function BindMenu() {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/BindMenu"),
            success: function (res) {
                $("#MenuId").empty();
                $.each(res, function (data, value) {
                    $("#MenuId").append($("<option></option>").val(value.value).html(value.text));
                });
                HideLoader();
            }
        });
        HideLoader();
    }

    function BindParentMenu(id) {
        ShowLoader();
        if (id == undefined && id == null) {
            $.easyAjax({
                type: "POST",
                url: ResolveUrl("/Admin/BindParentMenu"),
                data: { lgId: null },
                success: function (res) {
                    $("#ParentId").empty();
                    $.each(res, function (data, value) {
                        $("#ParentId").append($("<option></option>").val(value.value).html(value.text));
                    });
                    HideLoader();
                }
            });
            HideLoader();
        }
        else {
            $.easyAjax({
                type: "POST",
                url: ResolveUrl("/Admin/BindParentMenu"),
                data: { lgId: id },
                success: function (res) {
                    $("#ParentId").empty();
                    $.each(res, function (data, value) {
                        $("#ParentId").append($("<option></option>").val(value.value).html(value.text));
                    });
                    HideLoader();
                }
            });
            HideLoader();
        }
    }

    function BindMenuType() {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/BindMenuType"),
            success: function (res) {
                $("#MenuType").empty();
                $.each(res, function (data, value) {
                    if (value.text != 'QuickLinks') {
                        $("#MenuType").append($("<option></option>").val(value.value).html(value.text));
                    }
                });
                HideLoader();
            }
        });
        HideLoader();
    }

    function ValidateParentOrNot() {
        if ($('#MenuType').val() == "1" && $('#MenuType').val() != undefined && $('#MenuType').val() != null) {
            $('#dvParentId').show();
        }
        else {
            $('#dvParentId').hide();
        }
    }

    window.SwapModel = function (row, dir, type, parentid) {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/AdminMenuSwapDetails"),
            data: { "rank": row, "dir": dir, "type": type, "parentid": parentid },
            datatable: datatable, // ✅ Use global datatable
        });
        BindMenu();
        BindParentMenu(null);
        BindMenuType();
        ValidateParentOrNot();
    } 

});