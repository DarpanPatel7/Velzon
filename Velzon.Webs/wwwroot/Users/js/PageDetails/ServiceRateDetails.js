$(document).ready(function () {
    //var strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString("@Model.FilePath"));
    //document.getElementById("image").innerHTML = '<img src="' + strpath + '" alt="Image" height="500px" width="500px">';
    var lgLangId = $("#lgLanguageId").val();

    if (lgLangId == "1") {
        document.getElementById("home").innerHTML = 'Home';

    }
    else if (lgLangId == "2") {
        document.getElementById("home").innerHTML = 'હોમ';

    }
    //if (lgLangId == "1") {
    //    document.getElementById("alldetails").innerHTML = 'Service Rate';

    //}
    //else if (lgLangId == "2") {
    //    document.getElementById("alldetails").innerHTML = 'સેવા દર';

    //}
    ServiceRateList();
    ServiceRateDetails();
});

function ServiceRateList() {
    $.ajax({
        type: "GET",
        url: ResolveUrl("/GetServiceRateList"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            if (res.isError) {
                ShowMessage(res.strMessage, "", "error");
                return;
            }

            var dataList = res.result.sort((a, b) => a.serviceRank - b.serviceRank);
            var strInnerHtml = `<h2> Service Rate</h2>
                                <div class="all-post-list pbmit-bg-color-global">
                                    <ul>`;

            $.each(dataList, function (index, value) {
                var serviceUrl = ResolveUrl("/Home/ServiceRateDetails/" + FrontValue(value.serviceRateId));
                strInnerHtml += `<li><a href="${serviceUrl}">${value.serviceName}</a></li>`;
            });

            strInnerHtml += `</ul></div>`;

            $("#ServiceRateArea").html(strInnerHtml);
        }
    });
}

function ServiceRateDetails() {

    var serviceRateId = $('#hiddenServiceRateId').val();

    var formdata = new FormData();
    formdata.append("serviceRateId", FrontValue(serviceRateId));

    $.ajax({
        type: "get", url: ResolveUrl("/GetServiceDetailById?serviceMasterId=" + FrontValue(serviceRateId)),
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
                    $("#breadcrumbTitle").text(value.serviceName);
                    var strSubStr = "";
                    if (value.imagePath != null && value.imagePath != undefined && value.imagePath != '') {
                        var strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.imagePath));
                    }

                    strSubStr += value.serviceDescription;

                    strInnerHtml = strInnerHtml + strSubStr;
                });
                document.getElementById("ServiceDetails").innerHTML = strInnerHtml;
            }
        }

    });
}