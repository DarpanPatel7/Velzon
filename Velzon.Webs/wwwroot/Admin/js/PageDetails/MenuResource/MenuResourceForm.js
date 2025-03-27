/**
 * Page Manu Resource Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'MenuResource';
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
            { data: "menuName", name: "Menu Name", autoWidth: true },
            { data: "menuURL", name: "Menu URL", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateMenuResourceStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetMenuResourceDataDetails')}' data-id='${FrontValue(row.id)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteMenuResourceData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

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
        if ($.ValidateAndShowError($('#MenuName'), "menu name", "text")) return;
        if ($.ValidateAndShowError($('#MenuURL'), "menu url", "text")) return;
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
        $.easyAjax({
            url: url,
            type: "POST",
            data: { id: id }, // Send id in the request body
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            success: function (data) {
                var dataList = data.result;
                Object.keys(dataList).forEach(function (key) {
                    if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                        if (key.includes("is")) {
                            $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                        }
                        else {
                            $('#' + capitalizeFirstLetter(key)).val(dataList[key]); console.log("key:" + capitalizeFirstLetter(key) + "value:" + dataList[key]);
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

});
