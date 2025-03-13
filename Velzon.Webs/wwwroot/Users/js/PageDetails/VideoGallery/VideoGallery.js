$(document).ready(function () {
    var lgLangId = $("#lgLanguageId").val();
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
        url: ResolveUrl("/BindVideoGalleryFirstData"),
        contentType: "application/x-www-form-urlencoded",
        data: data,
        dataType: "json",
        success: function (res) {
            renderGrid(
                res,
                index,
                (value, rowIndex) => {
                    var strHtml = '';
                    const strlink = value.id ? ResolveUrl("/VideoGalleryDetail?" + encodeURIComponent(FrontValue(value.id))) : "#";
                    var strthumbpath = value.thumbImage ?? '';

                    let sourcehtml = `<a class="image-popup" href="${strlink}" title="Video File"><i class="fa-regular fas fa-link"></i></a>`;


                    if (value.islinkvideo == 0) {
                        strthumbpath = value.thumbImage
                            ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.thumbImage)}`)
                            : ResolveUrl("/Admin/img/noimage.png");
                    }

                    strHtml += `<div class="col-lg-4 col-md-6 vdo-glr-section">
                            <div class="gallery-item">
                                <img src="${strthumbpath}" alt="${value.videoTitle ?? ''}" />
                                <div class="gallery-desc">
                                    ${sourcehtml}
                                </div>
                            </div>
                            <h4 class="album_title"><a href="${strlink}">${value.videoTitle ?? ''}</a></h4>
                        </div>`;
                    return strHtml;
                },
                () => `<div class="video-gallery" align="center">No video found!</div>`,
                '#ShowVideoGallery'
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}