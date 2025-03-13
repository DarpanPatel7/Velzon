$(document).ready(function () {
    var lgLangId = $("#lgLanguageId").val();
    if (lgLangId == "2") {
        $("#lblsrno").html('ક્રમ નંબર');
        $("#lbldate").html('તારીખ');
        $("#lblsubject").html('વિગતો/વિષય');
        $("#lbldocument").html('ડોક્યુમેન્ટ');
    }
    else {
        $("#lblsrno").html('Sr.No');
        $("#lbldate").html('Date');
        $("#lblsubject").html('Details/Subject');
        $("#lbldocument").html('Document/Link');
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
        url: ResolveUrl("/BindNewsGrid"),
        contentType: "application/x-www-form-urlencoded",
        data: data,
        dataType: "json",
        success: function (res) {
            renderGrid(
                res,
                index,
                (value, rowIndex) => {
                    const strpath = value.imagePath ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.imagePath)}`) : "";
                    let newsLink = "";

                    if (value.isLink) {
                        const urlMatch = value.newsDesc?.match(/https?:\/\/[^\s"]+/);
                        if (urlMatch) {
                            newsLink = `<a href='${urlMatch[0]}' target='_blank'>Read More</a>`;
                        } else if (value.isLink) {
                            newsLink = `<span>Read More</span>`;
                        }
                    }
                    

                    let documentLink = strpath ? `<a href='${strpath}' target='_blank'><i class='fa fa-file-pdf fa-2x'>&nbsp;</i></a>` : "";
                    return `<tr>
                        <td>${rowIndex}</td>
                        <td>${value.newsTitle ?? ""}</td>
                        <td>${value.dateDisplay ?? ""}</td>;
                        <td>${newsLink || documentLink}</td>
                        
                    </tr>`;
                },
                () => `<tr align="center">
                    <td colspan='4' class='no-record'>No matching records found!</td>
                </tr>`
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}