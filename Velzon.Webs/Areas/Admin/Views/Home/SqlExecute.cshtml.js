$(document).ready(function () {
});

$('#btnSQlQueryExecute').click(function () {
    var isError = false;
    if ($('#SqlQuery').val() == null || $('#SqlQuery').val() == '') {
        ShowMessage("Enter sql query!", "", "error", $('#SqlQuery'));
        isError = true;
    }
    if (!isError) {
        ShowLoader();
        var formdata = $('#formSQLExecute').serialize();
        var token = $('input[name="AntiforgeryFieldname"]').val();
        var mobileno = $('#SqlQuery').val();
        $.ajax({
            type: "POST",
            url: ResolveUrl("/Admin/GETMYSQLResult"),
            data: formdata,
            dataType: "json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            success: function (data) {
                if (data != null && data != undefined) {
                    if (data.isError) {
                        $('#tbldata').html(data.result.result);
                        $("#dvReportTable").DataTable({
                            "scrollX": true,
                            "processing": true, // for show progress bar
                            "serverSide": false, // for process server side
                            "filter": true, // this is for disable filter (search box)
                            "orderMulti": false,
                            "dom": "<'row'<'col-lg-8 col-md-6 col-12'B><'col-lg-4 col-md-6 col-12 pl-1 pt-1'f>>rt<'row mt-2'<'col-lg-2 col-md-3 col-12 pt-1'l><'col-lg-6 col-md-6 col-12 text-center'i><'col-lg-4 col-md-3 col-12'p>>",
                            "buttons": [
                                {
                                    extend: 'excel',
                                    text: '<i class="fas fa-file-excel mr-1"></i>Excel',
                                    filename: 'SQL Execute'
                                }
                            ],

                        });
                        ShowMessage(data.strMessage, "", data.type);
                    }
                    else {
                        $('#tbldata').html(data.result);
                    }
                    HideLoader();
                }
                else {
                    ShowMessage("Record not saved, Try again", "", "error");
                    HideLoader();
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                ShowMessage("Something went wrong, Try again!", "", "error");
                HideLoader();
            }
        });
    }
});

$('#btnClear').click(function () {
    $('#SqlQuery').val('');
});
