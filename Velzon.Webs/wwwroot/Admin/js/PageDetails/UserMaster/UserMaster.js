﻿/**
 * Page User Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'User';
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
            { data: "firstName", name: "First Name", autoWidth: true },
            { data: "lastName", name: "Last Name", autoWidth: true },
            { data: "username", name: "Username", autoWidth: true },
            { data: "email", name: "Email", autoWidth: true },
            { data: "phoneNo", name: "Mobile No", autoWidth: true },
            { data: "roleName", name: "Role Name", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateUserStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetUserDataDetails')}' data-id='${FrontValue(row.id)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteUserData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

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
        $("#noteUserPassword").hide();
        $('#Username').attr('readonly', false);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0
            }
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", async function () {
        if ($.ValidateAndShowError($('#FirstName'), "first name", "text")) return;
        if ($.ValidateAndShowError($('#LastName'), "last name", "text")) return;
        if ($.ValidateAndShowError($('#Username'), "username", "text")) return;
        // Special validation for password with custom messages
        if ($('#UserPassword').val()) {
            if ($.ValidateAndShowError($('#UserPassword'),
                "user password",
                "password",
                "Password cannot be empty!",
                "Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be between 8 to 15 characters!")) return;
        }
        if ($.ValidateAndShowError($('#Email'), "email", "email")) return;
        if ($.ValidateAndShowError($('#PhoneNo'), "mobile no", "mobileno")) return;
        if ($.ValidateAndShowError($('#RoleId'), "role", "dropdown", "Please select a role!")) return;
        FrontEncryptFront("Username");
        await safeAjax({
            container: "#addedit" + main + "Form",
            type: "POST",
            buttonSelector: "#addedit" + main + "Submit",
            blockUI: "#addedit" + main + "Modal .modal-content",
            disableButton: true,
            formReset: true,
            restrictPopupClose: true,
            datatable: datatable,
        });
        document.getElementById("Username").value = FrontdValue(document.getElementById("Username").value);
    });

    // render edit data
    $(document).on("click", ".edit" + main, async function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        $("#noteUserPassword").show();
        await safeAjax({
            url: url,
            type: "POST",
            data: { id: id }, // Send id in the request body
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            success: function (data) {
                $("#Username").attr("readonly", true);
                var dataList = data.result;
                Object.keys(dataList).forEach(function (key) {
                    if (key == 'userPassword') {
                        $("#UserPassword").val('');
                        $("#UserPassword").text('');
                    }
                    else {
                        if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                            if (key.includes("is")) {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                            }
                            else {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                        }
                    }
                });
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

});
