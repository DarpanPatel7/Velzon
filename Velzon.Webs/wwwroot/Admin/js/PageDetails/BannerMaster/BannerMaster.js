/**
 * Page Banner Master
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'Banner';
    var yesBadge = '<td><span class="badge badge-soft-success text-uppercase">Active</span></td>';
    var noBadge = '<td><span class="badge badge-soft-danger text-uppercase">In Active</span></td>';

    var frmPageUpdate = document.getElementById("frmPageUpdate").value;
    var frmPageView = document.getElementById("frmPageView").value;
    var frmPageDelete = document.getElementById("frmPageDelete").value;

    let tableSelector = "#datatable" + main;
    datatable = $.initializeDataTable(tableSelector, { // ✅ Assign to global datatable
        // Your DataTable configurations
        columns: [
            {
                data: null, render: function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                }
            },
            { data: "title", name: "Title", autoWidth: true },
            { data: "description", name: "Description", autoWidth: true },
            {
                data: null,
                render: function (data, type, row) {
                    var checked = row.isActive ? "checked" : "";
                    return `<div class="form-check form-switch">
                        <input class="form-check-input toggle-status status${main}" type="checkbox" data-url="${ResolveUrl("/Admin/UpdateBannerStatus")}" data-id="${FrontValue(row.id)}" ${checked}>
                        | ${row.isActive ? yesBadge : noBadge}
                    </div>`;
                }
            },
            {
                data: null,
                render: function (data, type, row) {
                    let downloadLinks = '';
                    const hasImage = row.imagePath && row.imagePath !== '';
                    if (hasImage) {
                        const downloadUrl = ResolveUrl(`/Admin/DownloadFile?fileName=${GreateHashString(row.imagePath)}`);
                        const viewUrl = ResolveUrl(`/Admin/ViewFile?fileName=${GreateHashString(row.imagePath)}`);
                        downloadLinks = `<a class="link-primary fs-15" title="Download" href="${downloadUrl}"><i class="ri-download-2-line"></i></a>
                                        <a class="link-secondary fs-15" title="View" target="_blank" href="${viewUrl}"><i class="ri-eye-line"></i></a>`;
                    }
                    var strEdit = `<a href='javascript:void(0);' class='link-success fs-15 edit${main}' data-url='${ResolveUrl('/Admin/GetBannerDataDetails')}' data-id='${FrontValue(row.id)}' data-language='${FrontValue(1)}' title='Edit'> <i class='ri-edit-2-line'></i> </a>`;
                    strEdit += `<a href='javascript:void(0);' class='link-warning fs-15' onclick="SwapModel('${FrontValue(row.bannerRank)}', '${FrontValue('up')}')" title='Move Up'><i class='ri-arrow-up-line'></i></a>`;
                    strEdit += `<a href='javascript:void(0);' class='link-warning fs-15' onclick="SwapModel('${FrontValue(row.bannerRank)}', '${FrontValue('down')}')" title='Move Down'><i class='ri-arrow-down-line'></i></a>`;
                    var strRemove = `<a href='javascript:void(0);' class='link-danger fs-15 delete${main}' data-url='${ResolveUrl('/Admin/DeleteBannerData')}' data-id='${FrontValue(row.id)}' title='Delete'> <i class='ri-delete-bin-line'></i> </a>`;

                    return "<div class='hstack gap-3 flex-wrap'>" +
                        (frmPageUpdate == "true" ? strEdit : "") +
                        (frmPageView == "true" ? downloadLinks : "sdfsdf") +
                        (frmPageDelete == "true" ? strRemove : "") +
                        "</div>";
                },
                autoWidth: true,
                "bSortable": false
            },
        ]
    });

    $('#ImageName').change(function () {
        if ($('#ImageName').val() != '') {
            $("#ViewfileIF").css('display', 'none');
        }
    });

    // Delete Record
    $(document).on("click", ".delete" + main, function () {
        let url = $(this).attr("data-url"); // Get delete URL
        let id = $(this).attr("data-id"); // Get delete id
        $.easyAjax({
            url: url,
            type: "POST",
            data: { id: id }, // Send id in the request body
            blockUI: true,
            confirmation: true,
            datatable: datatable, // ✅ Use global datatable
        });
    });

    // open form modal
    $(document).on("click", "#add" + main, function () {
        //$.BindLanguage();
        $('#ViewfileIF').css('display', 'none');
        $('#LanguageId').val("1").attr("selected", "selected");
        $('#LanguageId').attr('disabled', true);
        $.resetForm('#addedit' + main + 'Form', {
            defaultValues: {
                Id: 0,
                Description: CKEDITOR.instances['Description'].setData("")
            },
        });
        $('#addedit' + main + 'Modal').modal('show');
    });

    // add
    $(document).on("click", "#addedit" + main + "Submit", function () {
        if ($.ValidateAndShowError($('#Title'), "banner title", "none")) return;
        $("#Description").val(sanitizeCKEditorHTML(CKEDITOR.instances['Description'].getData()));
        if (!ValidateControl($('#Description'))) {
            ShowMessage("Please enter description!", "", "error");
            return false;
        }
        if ($('#Id').val() === '0') {
            if ($.ValidateImageAndShowError('#ImageName', "banner image", true)) return;
        }
        $('#LanguageId').attr('disabled', false);
        $.easyAjax({
            container: "#addedit" + main + "Form",
            type: "POST",
            buttonSelector: "#addedit" + main + "Submit",
            blockUI: "#addedit" + main + "Modal .modal-content",
            disableButton: true,
            formReset: true,
            file: true,
            restrictPopupClose: true,
            datatable: datatable,
        });
    });

    // render edit data
    $(document).on("click", ".edit" + main, function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        let langId = $(this).attr("data-language"); // Get langauge id
        //$.BindLanguage();
        $.easyAjax({
            url: url,
            type: "POST",
            data: { "id": encodeURIComponent(id), "langId": encodeURIComponent(langId) }, // Send id in the request body
            showModal: "#addedit" + main + "Modal",
            blockUI: true,
            success: function (data) {
                $('#LanguageId').attr('disabled', false);
                var dataList = data.result;
                if (data.isError == true) {
                    ShowMessage(data.strMessage, "", "error");
                    HideLoader();
                }
                else if (dataList != null) {
                    Object.keys(dataList).forEach(function (key) {
                        if ($('#' + capitalizeFirstLetter(key)) != null && $('#' + key) != undefined) {
                            if (key == ("imageName") || key == ("imageName")) {
                            }
                            else if (key.includes("is")) {
                                $('#' + capitalizeFirstLetter(key)).prop('checked', dataList[key]);
                            }
                            else if (key == "title") {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                            else if (key == "url") {
                                $('#URL').val(dataList[key]);
                            }
                            else if (key.includes("imagePath")) {
                                $('#ImagePath').val(dataList[key]);
                                handleImageVisibility('#ViewfileIF', dataList[key]);
                            }
                            else if (key == "description") {
                                CKEDITOR.instances['Description'].setData(dataList[key]);
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                            else {
                                $('#' + capitalizeFirstLetter(key)).val(dataList[key]);
                            }
                        }
                    });
                }
                else {
                    var valId = FrontdValue(id);
                    $('#Id').val(valId);
                }
                $('#LanguageId').attr('readonly', false);
                $("#addedit" + main + "Modal").modal('show');
                HideLoader();
            },
        });
    });

    // Handle status change
    $(document).on("click", ".status" + main, function () {
        let url = $(this).attr("data-url"); // Get edit URL
        let id = $(this).attr("data-id"); // Get edit id
        let $switch = $(this); // Store reference to the switch element
        let isActive = $switch.is(":checked") ? 1 : 0;
        $.easyAjax({
            url: url,
            type: "POST",
            data: { Id: id, IsActive: isActive }, // Send id in the request body
            blockUI: true,
            confirmation: true,
            statusSwitch: $switch,
            datatable: datatable, // ✅ Use global datatable
        });
    });

    window.SwapModel = function (row, dir, type, parentid) {
        ShowLoader();
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/BannerSwapDetails"),
            data: { "rank": row, "dir": dir },
            datatable: datatable, // ✅ Use global datatable
        });
    }

    function handleImageVisibility(viewFileSelector, imagePath) {
        if (imagePath && imagePath !== '') {
            $(viewFileSelector).css('display', 'block');
            $(viewFileSelector).attr('href', ResolveUrl("/Admin/ViewFile?fileName=") + GreateHashString(imagePath));
        } else {
            $(viewFileSelector).css('display', 'none');
        }
    }
});
