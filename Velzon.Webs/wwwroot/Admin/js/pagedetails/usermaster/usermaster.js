$(document).ready(function () {

    BindGrid();

    $('#btnAddNew').click(function () {
        ShowLoader();
        $('#mdlAddNew').modal('show');
        $('#FirstName').val('');
        $('#LastName').val('');
        $("#Username").attr("readonly", false);
        $('#Username').val('');
        $('#UserPassword').val('');
        $('#Email').val('');
        $('#PhoneNo').val('');
        $('#RoleId').val('');
        $('#IsActive').prop('checked', false);
        //$('#IsPasswordReset').prop('checked', false);
        $('#Id').val('0');
        HideLoader();
    });

    $('#mdlAddNew').on("hidden.bs.modal", function () {
        $('#FirstName').val('');
        $('#LastName').val('');
        $('#Username').val('');
        $("#Username").attr("readonly", false);
        $('#UserPassword').val('');
        $('#Email').val('');
        $('#PhoneNo').val('');
        $('#RoleId').val('');
        $('#IsActive').prop('checked', false);
        //$('#IsPasswordReset').prop('checked', false);
        $('#Id').val('0');
    });

    $('#btnMdlSave').click(function () {
        ShowLoader();
        var isError = false;
        if (!ValidateControl($('#FirstName'))) {
            ShowMessage("Enter First Name!", "", "error");
            isError = true;
        }
        else if (!ValidateControl($('#LastName'))) {
            ShowMessage("Enter Last Name!", "", "error");
            isError = true;
        }
        else if (!ValidateControl($('#Username'))) {
            ShowMessage("Enter Username!", "", "error");
            isError = true;
        }
        else if ($('#UserPassword').val()) {
            if (!ValidateControlPassword($('#UserPassword'))) {
                ShowMessage("User password should contain at least one uppercase letter, one lowercase letter, one numeric digit, one special character and length must be in between 8 to 15 characters!", "", "error");
                isError = true;
            }
        }
        else if (!ValidateControl($('#Email'))) {
            ShowMessage("Enter Email!", "", "error");
            isError = true;
        }
        else if ($('#RoleId').val() == "1" && !ValidateControl($('#RoleId'))) {
            ShowMessage("Select Role!", "", "error");
            isError = true;
        }
        if (!isError) {

            var txtUsername = document.getElementById("Username").value.trim();
            txtUsername.value = FrontEncryptFront("Username");

            var formdata = $('#frmAddEdit').serialize();
            $.ajax({
                type: "post",
                url: ResolveUrl("/Admin/SaveUserData"),
                data: formdata,
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function (data) {
                    if (data != null && data != undefined) {
                        ShowMessage(data.strMessage, "", data.type);
                        if (typeof data.isError != 'undefined' && data.isError == false) {
                            BindGrid();
                            $('#FirstName').val('');
                            $('#LastName').val('');
                            $('#Username').val('');
                            $('#UserPassword').val('');
                            $('#Email').val('');
                            $("#Username").attr("readonly", false);
                            $('#PhoneNo').val('');
                            $('#RoleId').val('');
                            $('#IsActive').prop('checked', false);
                            //$('#IsPasswordReset').prop('checked', false);
                            $('#Id').val('0');
                            $('#mdlAddNew').modal('hide');
                        }
                        document.getElementById("Username").value = FrontdValue(document.getElementById("Username").value);
                        HideLoader();
                    }
                    else {
                        ShowMessage("Record not saved, Try again", "", "error");
                        HideLoader();
                    }
                },
                error: function (ex) {
                    ShowMessage("Something went wrong, Try again!", "", "error");
                    HideLoader();
                }
            });
            FrontdValue(document.getElementById("UserPassword").value);
        }
    });

});

function DeleteData(row) {

    var form = $('#frmAddEdit');
    var token = $('input[name="AntiforgeryFieldname"]', form).val();

    confirmDelete("Do you want to delete " + row.RoleName, ResolveUrl("/Admin/DeleteUserData"), row, "POST", token);

    BindGrid();
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function EditModel(id) {

    ShowLoader();

    var form = $('#frmAddEdit');
    var token = $('input[name="AntiforgeryFieldname"]', form).val();

    $.ajax({
        destroy: true,
        type: "post",
        contentType: "application/x-www-form-urlencoded",
        url: ResolveUrl("/Admin/GetUserDataDetails"),
        data: { "id": id, "AntiforgeryFieldname": token  },
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
        error: function (jqXHR, textStatus, errorThrown) {
            ShowMessage("Something went wrong, Try again!", "", "error");
        }
    });
}

function BindGrid() {
    if ($.fn.DataTable.isDataTable("#tbldata")) {
        $('#tbldata').DataTable().clear().destroy();
    }

    ShowLoader();

    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    var token = $("input[name='AntiforgeryFieldname']").val();

    $("#tbldata").DataTable({
        //"scrollX": true,
        "responsive": true, // Enable responsive design
        "processing": true, // for show progress bar
        "serverSide": false, // for process server side
        "filter": true, // this is for disable filter (search box)
        "orderMulti": false, // for disable multiple column at once
        "order": [], //Initial no order.
        "ajax": {
            "url": ResolveUrl("/Admin/GetUserData"),
            "contentType": "application/x-www-form-urlencoded",
            "type": "POST",
            'data': {
                "AntiforgeryFieldname": token
                // etc..
            },
            "datatype": "json",
            "dataSrc": function (json) {
                // Settings.
                var jsonObj = json.data;

                HideLoader();
                // Data
                return jsonObj;
            }
        },
        "columnDefs": [{ "targets": 0, "responsivePriority": 1 }, // Sr No should always be visible
            { "targets": -1, "responsivePriority": 2 } // Action buttons should be visible
        ],
        "initComplete": function () {
            var api = this.api();
            var searchInput = $('.dataTables_filter input');
            searchInput.on('keyup change', function () {
                if (searchInput.val() === '') {
                    api.search('').draw();
                }
            });
        },
        "columns": [
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
                    var strEdit = "<a href='javascript:void(0);' class='link-success fs-15' title='Edit' onclick=\"EditModel('" + FrontValue(row.id) + "');\"> <i class='ri-edit-2-line'></i> </a>";
                    var strRemove = "<a href='javascript:void(0);' class='link-danger fs-15' title='Delete' onclick=\"DeleteData('" + FrontValue(row.id) + "');\"> <i class='ri-delete-bin-line'></i> </a>";

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

}

function ValidateControlPassword(obj) {
    var objval = $(obj).val();
    if (objval != null && objval != undefined && objval != '' && regexGlobalValidation.test(objval)) {
        var objclass = $(obj).attr('class');
        if (objclass != null && objclass != undefined && objclass != '') {
            if (objclass.includes('validpassword')) {
                if (regexPassword.test(objval)) {
                    return true;
                }
                else {
                    return false;
                }
            }
        }
        return true;
    } else {
        return false;
    }
}