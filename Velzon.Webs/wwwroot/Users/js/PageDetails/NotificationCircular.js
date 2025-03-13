$(document).ready(function () {
    var lgLangId = $("#lgLanguageId").val();
    if (lgLangId == "2") {
        $("#lblfromdate").html('શરૂઆતની તારીખ');
        $("#lbltodate").html('અંતિમ તારીખ');
        $(".lblnotification").html('સૂચનાઓ/પરિપત્રો');
        $(".lblsubject").html('વિષય/શીર્ષક');
        $("#SearchGR").html('શોધો');
        $("#SearchClear").html('રીસેટ');
        $("#lblsrno").html('ક્રમ નંબર');
        $("#lblntdate").html('તારીખ');
        $("#lbldocument").html('ડોક્યુમેન્ટ');
    }
    else {
        $("#lblfromdate").html('From Date');
        $("#lbltodate").html('To Date');
        $(".lblnotification").html('Notification/Circular');
        $(".lblsubject").html('Subject/Title');
        $("#SearchGR").html('Search');
        $("#SearchClear").html('Reset');
        $("#lblsrno").html('Sr.No');
        $("#lblntdate").html('Date');
        $("#lbldocument").html('Document');
    }
    BindGrid({}); // Initial call with empty filterParams
    $('#FromDate').change(function () {
        $('#ToDate').attr('min', $('#FromDate').val());
    });
    $('#ToDate').change(function () {
        $('#FromDate').attr('max', $('#ToDate').val());
    });

    $("#SearchGR").click(function () {
        var filterParams = {
            FromDate: $('#FromDate').val(),
            ToDate: $('#ToDate').val(),
            Number: $('#Number').val(),
            Subject: $("#Subject").val()
        };
        BindGrid(filterParams); // Reset to first page on search
    });

    $("#SearchClear").click(function () {
        $('#FromDate').val('');
        $('#ToDate').val('');
        $('#Number').val('');
        $("#Subject").val('');
        BindGrid({}); // Clear filters
    });
});

function BindGrid(filterParams, index = 1) {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    var data = {
        CurrentPage: index,
        AntiforgeryFieldname: token,
        ...filterParams
    };

    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindNotificationCircularGrid"),
        contentType: "application/x-www-form-urlencoded",
        data: data,
        dataType: "json",
        success: function (res) {
            renderGrid(
                res,
                index,
                (value, rowIndex) => {
                    const strpath = value.imagePath ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.imagePath)}`) : "";
                    return `<tr>
                        <td>${rowIndex}</td>
                        <td>${value.ecitizenDateDisplay ?? ""}</td>
                        <td>${value.number ?? ""}</td>
                        <td>${value.subject ?? ""}</td>
                        <td class='file_td'>${strpath ? `<a href='${strpath}' target='_blank'><i class='fa fa-file-pdf fa-2x'>&nbsp;</i></a>` : ""}</td>
                    </tr>`;
                },
                () => `<tr align="center">
                    <td colspan='5' class='no-record'>No matching records found!</td>
                </tr>`
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}