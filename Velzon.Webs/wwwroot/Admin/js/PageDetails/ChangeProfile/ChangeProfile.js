/**
 * Page Change Profile
 */

"use strict";

var datatable; // Declare globally

$(function () {
    var main = 'ChangeProfile';

    // Start upload,crop,preview image - croppie plugin
    var $uploadCrop,
        tempFilename,
        rawImg,
        imageId;
    function readFile(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('.upload-demo').addClass('ready');
                $('#cropImagePop').modal('show');
                rawImg = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
            input.value = null;
        }
        else {
            console.log("Sorry - you're browser doesn't support the FileReader API");
        }
    }

    $uploadCrop = $('#upload-demo').croppie({
        viewport: {
            width: 105,
            height: 105,
            type: 'circle'
        },
        enforceBoundary: false,
        enableExif: true
    });

    $('#cropImagePop').on('shown.bs.modal', function () {
        $uploadCrop.croppie('bind', {
            url: rawImg
        }).then(function () {
            console.log('jQuery bind complete');
        });
    });

    $('.item-img').on('change', function () {
        imageId = $(this).data('id'); tempFilename = $(this).val();
        $('#cancelCropBtn').data('id', imageId); readFile(this);
    });

    $('#cropImageBtn').on('click', function (ev) {
        $uploadCrop.croppie('result', {
            type: 'base64',
            format: 'png',
            size: { width: 105, height: 105 }
        }).then(async function (resp) {
            $('.preview-profile-image').attr('src', resp);
            $('.header-profile-user').attr('src', resp);
            $('.profile_photo').val(resp);
            await safeAjax({
                type: "POST",
                url: ResolveUrl("/Admin/UpdateProfilePic"),
                data: { "strData": resp },
                success: function (data) {
                    HideLoader();
                    $('#cropImagePop').modal('hide');
                    ShowMessage(data.strMessage, "", data.type);
                },
                error: function (data) {
                    ShowMessage("Something went wrong, Try again!", "", "error");
                    HideLoader();
                }
            });
            HideLoader();
        });
    });
    // End upload preview image

    // file trigger using anchor tag
    $(document).on("click", "#select_image", function (ev) {
        ev.preventDefault();
        $("#h_file:file").trigger('click');
    });

    // clear image event
    $(document).on("click", "#clear_image", function (ev) {
        ev.preventDefault();
        $('.preview-profile-image').attr('src', defaultImage);
        $('.profile_photo').val(defaultImageBase64);
    });
});