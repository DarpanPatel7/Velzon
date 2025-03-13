$(document).ready(function () {
    var lgLangId = $("#lgLanguageId").val();
    if (lgLangId == "2") {
        $("#lblfromdate").html('શરૂઆતની તારીખ');
        $("#lbltodate").html('અંતિમ તારીખ');
        $(".lblgrnumber").html('સરકારી ઠરાવ નંબર');
        $(".lblbranch").html('શાખા');
        $(".lblsubject").html('વિષય/શીર્ષક');
        $("#SearchGR").html('શોધો');
        $("#SearchClear").html('રીસેટ');
        $("#lblsrno").html('ક્રમ નંબર');
        $("#lblgrdate").html('સરકારી ઠરાવની તારીખ');
        $("#lbldocument").html('ડોક્યુમેન્ટ');
    }
    else {
        $("#lblfromdate").html('From Date');
        $("#lbltodate").html('To Date');
        $(".lblgrnumber").html('GR Number');
        $(".lblbranch").html('Branch');
        $(".lblsubject").html('Subject/Title');
        $("#SearchGR").html('Search');
        $("#SearchClear").html('Reset');
        $("#lblsrno").html('Sr.No');
        $("#lblgrdate").html('GR Date');
        $("#lbldocument").html('Document');
    }
    BindBranch();
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
            Subject: $("#Subject").val(),
            BranchId: $('#BranchId').val()
        };
        BindGrid(filterParams); // Reset to first page on search
    });

    $("#SearchClear").click(function () {
        $('#FromDate').val('');
        $('#ToDate').val('');
        $('#Number').val('');
        $("#Subject").val('');
        $('#BranchId').prop('selectedIndex', 0).trigger('change'); 
        BindGrid({}); // Clear filters
    });
});

function BindBranch() {
    ShowLoader();
    var form = $('#frmAddEdit');
    var token = $('input[name="AntiforgeryFieldname"]', form).val();
    $.ajax({
        type: "POST", url: ResolveUrl("/BindBranch"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            $("#BranchId").empty();
            $.each(res, function (data, value) {
                $("#BranchId").append($("<option></option>").val(value.value).html(value.text));
            });
            HideLoader();
        }
    });
    HideLoader();
}

function BindGrid(filterParams = {}, index = 1) {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    var data = {
        CurrentPage: index,
        AntiforgeryFieldname: token,
        ...filterParams
    };

    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindGovernmentResolutionGrid"),
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
                        <td>${value.branchName ?? ""}</td>
                        <td class='file_td'>${strpath ? `<a href='${strpath}' target='_blank'><i class='fa fa-file-pdf fa-2x'>&nbsp;</i></a>` : ""}</td>
                    </tr>`;
                },
                () => `<tr align="center">
                    <td colspan='6' class='no-record'>No matching records found!</td>
                </tr>`
            );
            renderPagination(res, filterParams, index);
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}