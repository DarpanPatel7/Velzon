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
        url: ResolveUrl("/BindProjectList"),
        contentType: "application/x-www-form-urlencoded",
        data: data,
        dataType: "json",
        success: function (res) {
            renderGrid(
                res,
                index,
                (value, rowIndex) => {
                    const strpath = value.filePath ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.filePath)}`) : ResolveUrl("/Admin/img/noimage.png");
                    const strlink = value.id ? ResolveUrl("/ProjectDetailspage?" + encodeURIComponent(FrontValue(value.id))) : "#";
                    
					return `<div class="col-lg-4">
								<article class="pbmit-blog-style-1">
									<div class="post-item">
										<div class="pbmit-featured-container">
											<div class="pbmit-featured-wrapper">
												<img src="${strpath}" class="img-fluid" alt="">
											</div>
										</div>
										<div class="pbminfotech-box-content">
											<div class="pbminfotech-box-container">
												<h3 class="pbmit-post-title">
                                                    <d>${value.projectName}</d>
												</h3>
												<div class="pbminfotech-box-desc">
													<div class="pbminfotech-box-desc-text">
														${value.description.length > 25 ? value.description.substring(0, 25) + "..." : value.description}
													</div>
												</div>
												<div class="pbmit-service-btn">
													<a class="btn-arrow" href="${ResolveUrl("/Home/ProjectDetailspage/" + FrontValue(value.projectMasterId))}">Read More</a>
												</div>
											</div>
										</div>
									</div>
								</article>

							</div>`;
                },
                () => `<div class="photo-gallery" align="center">No projects Found!</div>`,
                '#AllProjectDetails'
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}