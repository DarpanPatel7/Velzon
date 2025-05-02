/**
 * Page SQL Execute
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'SQLExecute';
    let tableSelector = "#datatable" + main;

    $(document).on("click", "#addedit" + main + "Submit", async function (e) {
        let sql = $("#SqlQuery").val().trim();
        if (!sql) {
            ShowMessage("Query is empty. Please enter a SELECT query.", "Validation Error", "error");
            return;
        }

        if (!/^SELECT\b/i.test(sql)) {
            ShowMessage("Only SELECT queries are allowed.", "Validation Error", "error");
            return;
        }

        await safeAjax({
            container: "#addedit" + main + "Form",
            type: "POST",
            buttonSelector: "#addedit" + main + "Submit",
            disableButton: true,
            formReset: true,
            success: function (data) {
                $(tableSelector).html('<thead></thead><tbody></tbody>');
                if (!data.isError) {
                    let result = data.result;
                    let columns = result.columns?.map((col, index) => ({
                        title: col,
                        data: index
                    })) || [];

                    let rows = result.rows || [];

                    // Clear any existing DataTable instance
                    if ($.fn.DataTable.isDataTable(tableSelector)) {
                        $(tableSelector).DataTable().clear().destroy();
                    }

                    if (columns.length === 0 || rows.length === 0) {
                        $(tableSelector).html(`<div class="alert alert-info" role="alert">
                            <b>No records found.</b>
                        </div>`);
                        HideLoader();
                        ShowMessage(data.strMessage, "", data.type);
                        return;
                    }

                    // Generate table headers dynamically
                    const thead = '<tr>' + result.columns.map(col => `<th>${col}</th>`).join('') + '</tr>';
                    $(tableSelector + ' thead').html(thead);

                    // Clear and populate <tbody>
                    const tbody = result.rows.map(row =>
                        '<tr>' + row.map(cell => `<td>${cell ?? ''}</td>`).join('') + '</tr>'
                    ).join('');
                    $(tableSelector + ' tbody').html(tbody);

                    // Initialize DataTable
                    $(tableSelector).DataTable({
                        scrollX: true,
                        "autoWidth": false, // Helps prevent column width issues
                        "processing": true, // for show progress bar
                        "serverSide": false, // for process server side
                        "filter": true, // this is for disable filter (search box)
                        "orderMulti": false, // for disable multiple column at once
                        "order": [], //Initial no order.
                        columnDefs: [
                            { targets: [0], searchable: false }
                        ],
                        drawCallback: function (settings) {
                            // Execute custom drawCallback if provided in options
                            if (typeof this.drawCallback === "function") {
                                this.drawCallback.call(this, settings);
                            }
                        },
                        dom: "<'row'<'col-md-12 text-center mb-3'B>>" + // Excel button centered with bottom margin
                            "<'row'<'col-md-6'l><'col-md-6'f>>" +      // Length and search
                            "<'row'<'col-12'tr>>" +
                            "<'row mt-2'<'col-md-5'i><'col-md-7'p>>",
                        buttons: [
                            {
                                extend: 'excelHtml5',
                                text: '<i class="ri-file-excel-fill"></i> Export to Excel',
                                className: 'btn btn-primary btn-round mr-2 btn-sm',
                                filename: 'SQL_Execute',
                                exportOptions: {
                                    columns: ':visible'
                                }
                            }
                        ],
                        initComplete: function () {
                            // Remove DataTables default "dt-button" class
                            $('.dt-button').removeClass('dt-button');
                        }
                    });

                    ShowMessage(data.strMessage, "", data.type);
                } else {
                    ShowMessage(data.strMessage, "", data.type);
                }
                HideLoader();
            },
            error: function () {
                ShowMessage("Something went wrong, try again!", "", "error");
                HideLoader();
            }
        });
    }); 

    $(document).on("click", "#clear" + main + "Submit", async function (e) {
        $.resetForm('#addedit' + main + 'Form');
    });
});