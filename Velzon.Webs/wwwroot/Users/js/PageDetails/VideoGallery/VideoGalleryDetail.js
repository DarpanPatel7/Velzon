$(document).ready(function () {
    var filterParams = {
        id: $("#Id").val()
    };
    BindGrid(filterParams); // Initial call with empty filterParams
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
        url: ResolveUrl("/BindVideoGalleryDetailData"),
        contentType: "application/x-www-form-urlencoded",
        data: data,
        dataType: "json",
        success: function (res) {
            const mainData = res.resultList;
            $("#ShowVideoGalleryImageTitle").html(mainData[0].videoTitle ?? "Title");
            renderGrid(
                res,
                index,
                (value, rowIndex) => {
                    let strHtml = "";
                    let strvideopath = value.videoUrl ?? '';
                    var strthumbpath = value.thumbImage ?? '';

                    let sourcehtml = `<a class="image-popup" href="${strvideopath}" data-fancybox="gallery" title="${value.videoTitle ?? ''}">
                                  <i class="fa-regular fas fa-video"></i>
                              </a>`;

                    if (value.islinkvideo == 0) {
                        // CouchDB file loading in video tag
                        strvideopath = value.videoUrl
                            ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.videoUrl)}`)
                            : ResolveUrl("/Admin/img/noimage.png");

                        strthumbpath = value.thumbImage
                            ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.thumbImage)}`)
                            : ResolveUrl("/Admin/img/noimage.png");

                        sourcehtml = `<a class="image-popup" href="${strvideopath}" data-fancybox="gallery" data-type="video" title="${value.videoTitle ?? ''}">
                                <i class="fa-regular fas fa-video"></i>
                              </a>`;
                    }

                    strHtml += `<div class="col-lg-4 col-md-6 vdo-glr-section">
                            <div class="gallery-item">
                                <img src="${strthumbpath}" alt="${value.videoName ?? ''}" />
                                <div class="gallery-desc">
                                    ${sourcehtml}
                                </div>
                            </div>
                            <h4 class="album_title">${value.videoName ?? ''}</h4>
                        </div>`;
                    return strHtml;
                },
                () => `<div class="photo-gallery-detail" align="center">No video found!</div>`,
                '#ShowVideoGalleryImage'
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}