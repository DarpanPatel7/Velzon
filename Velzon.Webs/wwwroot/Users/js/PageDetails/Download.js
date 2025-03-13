$(document).ready(function () {
    var lgLangId = $("#lgLanguageId").val();
    if (lgLangId == "2") {
        $("#lblsrno").html('ક્રમ નંબર');
        $("#lblsubject").html('વિગતો/વિષય');
        $("#lbldocument").html('ડોક્યુમેન્ટ');
    }
    else {
        $("#lblsrno").html('Sr.No');
        $("#lblsubject").html('Details/Subject');
        $("#lbldocument").html('Document');
    }
    BindGrid({}); // Initial call with empty filterParams
});

function BindGrid(filterParams = {}, index = 1) {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    var data = {
        CurrentPage: index,
        AntiforgeryFieldname: token,
        ...filterParams
    };

    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindDownloadsGrid"),
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
                        <td>${value.subject ?? ""}</td>
                        <td class='file_td'>${strpath ? `<a href='${strpath}' target='_blank'><i class='fa fa-file-pdf fa-2x'>&nbsp;</i></a>` : ""}</td>
                    </tr>`;
                },
                () => `<tr align="center">
                    <td colspan='3' class='no-record'>No matching records found!</td>
                </tr>`
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}