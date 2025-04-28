/**
 * Page Utility Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'Utility';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "userName", name: "User Name", autoWidth: true },
            { data: "lockStatus", name: "Lock Status", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var strlock = '';
                    var strunlock = '';
                    if (row.isLock == true) {
                        strunlock = `<a class="btn btn-danger btn-sm btn-border btnedit" title="Unlock" onclick="lockunlock(0, ${row.userId}, '${row.userName}')">Unlock</a>&nbsp`;
                    } else {
                        strlock = `<a class="btn btn-secondary btn-sm btn-border btnedit" title="Lock" onclick="lockunlock(1, ${row.userId}, '${row.userName}')">Lock</a>&nbsp;`;
                    }
                    var strMain = (frmPageUpdate == "true" ? strlock : "") + "&nbsp;" + (frmPageUpdate == "true" ? strunlock : "") + "&nbsp;";
                    return strMain;
                },
                autoWidth: true,
                "bSortable": false
            },
        ]
    });

    // lock uplock user
    window.lockunlock = async function(islock, u_id, u_name) {
        $("#plock").val(islock);
        $("#FormUserId").val(u_id);
        $("#UserName").val(u_name);
        await safeAjax({
            type: "POST",
            container: "#addedit" + main + "Form",
            datatable: datatable, // ✅ Use global datatable
        });
    }

});
