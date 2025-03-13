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
        url: ResolveUrl("/BindPhotoGalleryDetailData"),
        contentType: "application/x-www-form-urlencoded",
        data: data,
        dataType: "json",
        success: function (res) {
           
            const mainData = res.resultList;
            $("#ShowPhotoGalleryImageTitle").html(mainData[0]?.placeName ?? "Title");
            renderGrid(
                res,
                index,
                (value, rowIndex) => {
                    $("#breadcrumbTitle").text(value.placeName);
                    let strHtml = "";
                    // Add the gallery item
                    strHtml += `<div class="col-lg-4 col-md-6 pht-glr-dtl-section">
                        <div class="gallery-item">
                            <img src="${value.imagePath ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.imagePath)}`) : ResolveUrl("/Admin/img/noimage.png")}" alt="${value.placeName ?? ''}" />
                            <div class="gallery-desc">
                                <a class="image-popup" href="${value.imagePath ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.imagePath)}`) : ResolveUrl("/Admin/img/noimage.png")}" data-fancybox="gallery" data-caption="${value.placeName ?? ''}" title="${value.placeName ?? ''}">
                                    <i class="pbmit-base-icon-plus-symbol-button"></i>
                                </a>
                            </div>
                        </div>
                    </div>`;
                    return strHtml;
                },
                () => `<div class="photo-gallery" align="center">No photo found!</div>`,
                '#ShowPhotoGalleryImage'
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}