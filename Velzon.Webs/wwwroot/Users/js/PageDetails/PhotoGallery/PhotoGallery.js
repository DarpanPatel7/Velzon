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
        url: ResolveUrl("/BindPhotoGalleryFirstData"),
        contentType: "application/x-www-form-urlencoded",
        data: data,
        dataType: "json",
        success: function (res) {
            renderGrid(
                res,
                index,
                (value, rowIndex) => {
                    const strpath = value.firstImagePath ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.firstImagePath)}`) : ResolveUrl("/Admin/img/noimage.png");
                    const strlink = value.id ? ResolveUrl("/PhotoGalleryDetail?" + encodeURIComponent(FrontValue(value.id))) : "#";
                    return `<div class="col-lg-4 col-md-6 pht-glr-section">
                            <div class="gallery-item">
                                <img src="${strpath}" alt="${value.placeName ?? ''}">
                                <div class="gallery-desc">
                                    <a class="image-popup" href="${strlink}" title="${value.placeName ?? ''}">
                                        <i class="fa fa-link"></i>
                                    </a>
                                </div>
                            </div>
                            <h4 class="album_title"> <a href="${strlink}">${value.placeName ?? ''}</a></h4>
                        </div>`;
                },
                () => `<div class="photo-gallery" align="center">No photo found!</div>`,
                '#ShowPhotoGallery'
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}