/**
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
                    return row.isActive ? yesBadge : noBadge;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = "<a href='javascript:void(0);' class='link-success fs-15 editUser' data-url='" + ResolveUrl('/Admin/GetUserDataDetails') + "' data-id='" + FrontValue(row.id) + "' title='Edit'> <i class='ri-edit-2-line'></i> </a>";
                    var strRemove = "<a href='javascript:void(0);' class='link-danger fs-15 deleteUser' data-url='" + ResolveUrl('/Admin/DeleteUserData') + "' data-id='" + FrontValue(row.id) + "' title='Delete'> <i class='ri-delete-bin-line'></i> </a>";

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
            deleteConfirmation: true,
            datatable: datatable, // ✅ Use global datatable
        });
    });

    // Delete Record
    $(document).on("click", "#add" + main, function () {
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", function () {
        FrontEncryptFront("Username");
        $.easyAjax({
            container: "#addedit" + main + "Form",
            url: ResolveUrl("/Admin/SaveUserData"),
            type: "POST",
            buttonSelector: "#addedit" + main + "Submit",
            blockUI: "#addeditUserModal .modal-content",
            disableButton: true,
            formReset: true,
            datatable: datatable,
        });
        document.getElementById("Username").value = FrontdValue(document.getElementById("Username").value);
    });

    // render edit data
    /*$(document).on("click", ".edit" + main, function () {
        var url = $(this).data("url");
        $.easyAjax({
            url: url,
            type: "GET",
            //appendHtml: "#edit" + main + "Content",
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            initSelect2: "#edit" + main + "Modal",
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
                $('#mdlAddNew').modal('show');
                HideLoader();
            },
        });
    });*/

    // update
    /*$("body").on("click", "#edit" + main + "Submit", function (event) {
        $.easyAjax({
            container: "#edit" + main + "Form",
            type: "PATCH",
            buttonSelector: "#edit" + main + "Submit",
            //file: true,
            blockUI: true,
            disableButton: true,
            formReset: true,
            datatable: datatable,
        });
    });*/

});
