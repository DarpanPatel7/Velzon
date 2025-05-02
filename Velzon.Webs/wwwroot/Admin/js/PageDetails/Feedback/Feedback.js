/**
 * Page Feedback
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'Feedback';

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "fName", name: "Firstname", autoWidth: true },
            { data: "lName", name: "Lastname", autoWidth: true },
            { data: "mobileNo", name: "mobile", autoWidth: true },
            { data: "email", name: "email", autoWidth: true, /*visible:false*/ },
            { data: "subject", name: "subject", autoWidth: true },
            { data: "feedbackDetails", name: "feedback", autoWidth: true },
        ]
    });
});