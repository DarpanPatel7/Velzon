/**
 * Page Manu Resource Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    window.SelectAllCheckBox = function(objType) {
        ShowLoader();
        $("input:checkbox." + objType + "").each(function () {
            var rowInsert = document.getElementById("chkAll" + objType + "");
            if (rowInsert.checked) {
                $(this).attr('checked', 'checked');
            }
            else {
                $(this).removeAttr('checked');
            }
        });
        HideLoader();
    }

    window.SetCheckBoxCheck = function(id, field) {
        ShowLoader();
        var rowInsert = document.getElementById("chk" + id + "Insert");
        var rowUpdate = document.getElementById("chk" + id + "Update");
        var rowDelete = document.getElementById("chk" + id + "Delete");
        var rowView = document.getElementById("chk" + id + "View");
        if (rowInsert.checked && rowView.checked && field != "Update" && field != "Delete") {
            rowUpdate.checked = true;
            rowDelete.checked = true;
        }
        HideLoader();
    }

    window.GetAllSaveResult = function () {
        var string = "";
        ShowLoader();

        var form = $('#frmCardUpdate');
        var token = $('input[name="AntiforgeryFieldname"]', form).val();
        var table = document.getElementById("tblRoleRightdata");
        var chkIdInsert, chkIdUpdate, chkIdDelete, chkIdView;
        var rowCount = 0;
        $('#tblRoleRightdata tr ').each(function (index, tr) {
            $(tr).find('td input[type=checkbox].Insert').each(function (index, td) {
                if (td.id != undefined && td.id != null) {
                    chkIdInsert = td.id;
                }
            });
            if (rowCount != 0) {
                var id = chkIdInsert.replace("chk", "").replace("Insert", "");
                var rowInsert = document.getElementById("chk" + id + "Insert");
                var rowUpdate = document.getElementById("chk" + id + "Update");
                var rowDelete = document.getElementById("chk" + id + "Delete");
                var rowView = document.getElementById("chk" + id + "View");
                string = string + id + ",";
                string = string + rowInsert.checked + ",";
                string = string + rowUpdate.checked + ",";
                string = string + rowDelete.checked + ",";
                string = string + rowView.checked + "";
                string = string + "|";
                string = (string);
            }
            rowCount = rowCount + 1;
        });
        if (string != "") {
            var ddlSelectedRoleId = document.getElementById("SelectedRoleId");
            $.easyAjax({
                type: "POST",
                url: ResolveUrl("/Admin/UpdatePageRights"),
                data: { "strData": string, "lgRoleId": ddlSelectedRoleId.value },
                success: function (data) {
                    HideLoader();
                    ShowMessage(data.strMessage, "", data.type);
                    var $div = $('#dvRightsTable');
                    $div.contents().remove();
                    document.getElementById('btnSaveRight').style.display = "none";
                    $("#SelectedRoleId").val($("#target option:first").val());
                    $("#SelectedMenuId").val($("#target option:first").val());
                },
                error: function (data) {
                    ShowMessage("Something went wrong, Try again!", "", "error");
                }
            });
        }
    }
});