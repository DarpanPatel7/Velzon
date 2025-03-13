$(document).ready(function () {
 
    var lgLangId = $("#lgLanguageId").val();

    if (lgLangId == "1") {
        document.getElementById("home").innerHTML = 'Home';

    }
    else if (lgLangId == "2") {
        document.getElementById("home").innerHTML = 'હોમ';

    }
    
    LetestProject();
    GetAllFrontImagesById();
});

function LetestProject() {
    $.ajax({
        type: "get", url: ResolveUrl("/GetProjectList"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {

            var dataList = res.result;

            if (res.isError == true) {
                ShowMessage(res.strMessage, "", "error");
            }
            else {
                var strInnerHtml = "";

                $.each(dataList, function (data, value) {

                    var strSubStr = "";
                    if (value.filePath != null && value.filePath != undefined && value.filePath != '') {
                        var strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.filePath));
                    }
                    strSubStr = strSubStr + '<li>';
                    strSubStr = strSubStr + '    <a href="' + ResolveUrl("/Home/ProjectDetailsPage/" + FrontValue(value.projectMasterId)) + '">';
                    if (strpath != null) {
                        strSubStr = strSubStr + '        <img src="' + strpath + '"  alt="post-img">';
                    }
                    strSubStr = strSubStr + '    </a>';
                    strSubStr = strSubStr + '    <a href="' + ResolveUrl("/Home/ProjectDetailsPage/" + FrontValue(value.projectMasterId)) + '">' + value.projectName + '</a>';
                    strSubStr = strSubStr + '</li>';
                    strInnerHtml = strInnerHtml + strSubStr;
                });
                document.getElementById("LatestProjectArea").innerHTML = strInnerHtml;
            }
        }
    });
}
function GetAllFrontImagesById() {

    var projectId = $('#hiddenProjectMasterId').val();

    var formdata = new FormData();
    formdata.append("projectMasterId", FrontValue(projectId));

    $.ajax({
        type: "get", url: ResolveUrl("/GetAllProjectImagesById?projectMasterId=" + FrontValue(projectId)),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            var dataList = res.result;

            if (res.isError == true) {
                ShowMessage(res.strMessage, "", "error");
            }
            else {
                var strInnerHtml = "";
                $.each(dataList, function (data, value) {
                    $("#breadcrumbTitle").text(value.projectName);
                    var strSubStr = "";
                    if (value.filePath != null && value.filePath != undefined && value.filePath != '') {
                        var strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.filePath));
                    }
                    // strSubStr = strSubStr + '<img class="img-fluid" src="' + strpath + '" alt="Details">';

                    strSubStr = strSubStr + '<article class="post ttm-blog-single clearfix">';
                    strSubStr = strSubStr + '    <div class="ttm-post-featured-wrapper">';
                    strSubStr = strSubStr + '        <div class="ttm-post-featured mb-30">';
                    strSubStr = strSubStr + '     <img class="img-fluid" src="' + strpath + '" alt="Details">';
                    strSubStr = strSubStr + '        </div>';
                    strSubStr = strSubStr + '    </div>';
                    strSubStr = strSubStr + '    <div class="ttm-blog-single-content">';
                    strSubStr = strSubStr + '        <div class="entry-content">';
                    strSubStr = strSubStr + '            <h5 class="schemsbg">Name Of the Project</h5>';
                    strSubStr = strSubStr + '            <div class="col-md-12">';
                    strSubStr = strSubStr + '                <div class="">';
                    strSubStr = strSubStr + '                    <ul class="ttm-list ttm-list-style-icon">';
                    strSubStr = strSubStr + '                        <li>';
                    strSubStr = strSubStr + '                            <i class="fa fa-arrow-right ttm-textcolor-skincolor"></i>' + value.projectName + '';
                    strSubStr = strSubStr + '                        </li>';
                    strSubStr = strSubStr + '                    </ul>';
                    strSubStr = strSubStr + '                </div>';
                    strSubStr = strSubStr + '            </div>';
                    strSubStr = strSubStr + '            <br>';
                    strSubStr = strSubStr + '                <div>' + (value.description) + '</div>';
                    strSubStr = strSubStr + '                <div class="separator">';
                    strSubStr = strSubStr + '                    <div class="sep-line mt-25 mb-25"></div>';
                    strSubStr = strSubStr + '                </div>';
                    strSubStr = strSubStr + '        </div>';
                    strSubStr = strSubStr + '    </div>';
                    strSubStr = strSubStr + '</article>';

                    strInnerHtml = strInnerHtml + strSubStr;
                });
                document.getElementById("image").innerHTML = strInnerHtml;
            }
        }

    });
}