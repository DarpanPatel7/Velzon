/**
 * Page Css Master
 */

"use strict";

var datatable; // Declare globally
var cssEditor;
var cssEditorInitialized = false;

$(function () {
    var main = 'Css';
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
            { data: "title", name: "Title", autoWidth: true },
            /*{ data: "cssfile", name: "Cssfile", autoWidth: true },*/
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateCssStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetCssDetails')}' data-id='${FrontValue(row.id)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteCssData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

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
    $(document).on("click", "#add" + main, async function () {
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: { Id: 0 },
        });

        $('#addedit' + main + 'Modal').modal('show');

        await new Promise(resolve => {
            $('#addedit' + main + 'Modal').on('shown.bs.modal', function () {
                resolve();
            });
        });

        if (!cssEditorInitialized) {
            cssEditor = CodeMirror.fromTextArea(document.getElementById("Cssfile"), {
                mode: "css",
                lineNumbers: true,
                theme: "monokai",
                lineWrapping: true,
                autoCloseBrackets: true,
                matchBrackets: true,
                styleActiveLine: true,
                foldGutter: true,
                gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"],
            });
            cssEditorInitialized = true;
        } else {
            cssEditor.setValue($('#Cssfile').val());
            cssEditor.refresh();
        }
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", async function () {
        // Get the CodeMirror instance and sync it back to the original textarea
        if (window.cssEditor && typeof window.cssEditor.getValue === "function") {
            $('#Cssfile').val(window.cssEditor.getValue());
        }
        // Now validation will work correctly
        if ($.ValidateAndShowError($('#Title'), "css name", "none")) return;
        if ($.ValidateAndShowError($('#Cssfile'), "css", "none")) return;
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
    });

    // render edit data
    $(document).on("click", ".edit" + main, async function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        await safeAjax({
            url: url,
            type: "POST",
            data: { "id": encodeURIComponent(id) }, // Send id in the request body
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            success: async function (data) {
                var dataList = data.result;
                if (data.isError == true) {
                    ShowMessage(data.strMessage, "", "error");
                    HideLoader();
                }
                else if (dataList != null) {
                    Object.keys(dataList).forEach(function (key) {
                        if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                            if (key.includes("isActive")) {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]).change();
                            } else if (key == "cssfile") {
                                // Update CodeMirror with the Cssfile content
                                //cssEditor.setValue(dataList[key]); // <- this sets the editor content
                                $('#Cssfile').val(dataList[key]);
                            } else {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                        }
                    });
                }
                else {
                    var valId = FrontdValue(id);
                    $('#Id').val(valId);
                }
                $("#addedit" + main + "Modal").modal('show');

                await new Promise(resolve => {
                    $('#addedit' + main + 'Modal').on('shown.bs.modal', function () {
                        resolve();
                    });
                });

                if (!cssEditorInitialized) {
                    cssEditor = CodeMirror.fromTextArea(document.getElementById("Cssfile"), {
                        mode: "css",
                        lineNumbers: true,
                        theme: "monokai",
                        lineWrapping: true,
                        autoCloseBrackets: true,
                        matchBrackets: true,
                        styleActiveLine: true,
                        foldGutter: true,
                        gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"],
                    });
                    cssEditorInitialized = true;
                } else {
                    cssEditor.setValue($('#Cssfile').val());
                    cssEditor.refresh();
                }

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