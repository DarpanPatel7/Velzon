(function ($) {
    "use strict";

    /**
     * Initializes a DataTable with custom options.
     * @param {string} selector - The jQuery selector for the table.
     * @param {object} options - Additional configuration options.
     */
    $.initializeDataTable = function (selector, options = {}) {
        try {
            var dt_selector = $(selector);
            if (!dt_selector.length) {
                console.warn(`DataTable Initialization Warning: No element found for selector '${selector}'`);
                return;
            }

            // Default settings
            var defaultOptions = {
                "responsive": true, // Enable responsive design
                "autoWidth": false, // Helps prevent column width issues
                "processing": true, // for show progress bar
                "serverSide": false, // for process server side
                "filter": true, // this is for disable filter (search box)
                "orderMulti": false, // for disable multiple column at once
                "order": [], //Initial no order.
                ajax: {
                    url: ResolveUrl(dt_selector.data('url')),
                    contentType: "application/x-www-form-urlencoded",
                    type: "POST",
                    data: function (d) {
                        let antiforgery = {
                            "AntiforgeryFieldname": document.querySelector('input[name="AntiforgeryFieldname"]').value
                        };

                        let dynamicData = {};
                        if (typeof options.data === "function") {
                            dynamicData = options.data();
                        } else if (typeof options.data === "object") {
                            dynamicData = options.data;
                        }

                        return Object.assign({}, d, antiforgery, dynamicData);
                    },
                    datatype: "json",
                    dataSrc: function (json) {
                        HideLoader();
                        return json.data;
                    },
                    error: function (xhr, error, thrown) {
                        console.error(`DataTable AJAX Error: ${error}, ${thrown}`, xhr);
                        alert("An error occurred while loading the data. Please try again.");
                    }
                },
                columnDefs: [
                    { targets: [0], searchable: false }
                ],
                initComplete: function () {
                    var api = this.api();
                    var searchInput = $('.dataTables_filter input');

                    searchInput.on('keyup change', function () {
                        if (searchInput.val() === '') {
                            api.search('').draw();
                        }
                    });

                    // Execute additional initComplete logic if provided in options
                    if (typeof options.initComplete === "function") {
                        options.initComplete.call(this, api);
                    }
                },
                drawCallback: function (settings) {
                    // Execute custom drawCallback if provided in options
                    if (typeof options.drawCallback === "function") {
                        options.drawCallback.call(this, settings);
                    }
                },
                columns: []
            };

            // Merge default options with user-defined options
            var finalOptions = $.extend(true, {}, defaultOptions, options);

            // Initialize DataTable
            var inDatatable = dt_selector.DataTable(finalOptions);

            return inDatatable;

        } catch (error) {
            console.error("DataTable Initialization Error:", error);
        }
    };

    /**
     * Displays a confirmation dialog.
     * @param {object} options - Configuration options for the confirmation dialog.
     */
    $.showConfirmation = function (options = {}) {
        Swal.fire({
            title: options.title ?? "Are you sure?",
            text: options.text ?? "You won't be able to revert this!",
            icon: options.icon ?? "warning",
            showCancelButton: options.showCancelButton ?? true,
            confirmButtonText: options.confirmButtonText ?? "Yes, Confirm it!",
            cancelButtonText: options.cancelButtonText ?? "Cancel",
            buttonsStyling: options.buttonsStyling ?? false,
            showCloseButton: options.showCloseButton ?? false,
            customClass: {
                confirmButton: options.confirmButtonClass ?? "btn btn-primary w-xs me-2 mt-2",
                cancelButton: options.cancelButtonClass ?? "btn btn-danger w-xs mt-2"
            }
        }).then((result) => {
            if (result.isConfirmed) {
                if (typeof options.onConfirm === "function") {
                    options.onConfirm(); // Call custom confirm callback
                }

                // Call loadAjax if it's provided in options, otherwise call global loadAjax()
                if (typeof options.loadAjax === "function") {
                    options.loadAjax();
                } else if (typeof $.loadAjax === "function") {
                    $.loadAjax(); // Default to calling global loadAjax()
                }

            } else if (result.dismiss === Swal.DismissReason.cancel ||
                result.dismiss === Swal.DismissReason.backdrop ||
                result.dismiss === Swal.DismissReason.close) {

                // ✅ Revert the switch state if `statusSwitch` is provided
                if (options.statusSwitch) {
                    options.statusSwitch.prop("checked", !options.statusSwitch.prop("checked"));
                }

                // ✅ Call onCancel only if it's defined
                if (typeof options.onCancel === "function") {
                    options.onCancel();
                }
            }
        });
    };

    /**
     * Shows a message notification.
     * @param {string} msgDescription - Message content.
     * @param {string} msgTitle - Message title.
     * @param {string} msgType - Type of message (info, success, warning, error).
     * @param {number} msgTimer - Auto-hide timer duration.
     * @param {boolean} msgShowButton - Whether to show a close button.
     */
    $.ShowMessage = function (msgDescription, msgTitle = "", msgType = "info", msgTimer = 0, msgShowButton = true) {
        let swalOptions = {
            title: msgTitle,
            text: msgDescription,
            icon: msgType,
            timer: msgTimer > 0 ? msgTimer : undefined,
            showConfirmButton: msgShowButton,
            buttonsStyling: false,
            customClass: {
                confirmButton: "btn btn-primary w-xs me-2 mt-2",
                cancelButton: "btn btn-danger w-xs mt-2"
            }
        };

        // Additional options based on message type
        switch (msgType) {
            case "success":
                //swalOptions.showCancelButton = true;
                break;

            case "error":
                break;

            case "warning":
                swalOptions.showCancelButton = true;
                swalOptions.confirmButtonText = "Yes, delete it!";
                swalOptions.preConfirm = () => {
                    Swal.fire({
                        title: "Deleted!",
                        text: "Your file has been deleted.",
                        icon: "success",
                        buttonsStyling: false,
                        customClass: {
                            confirmButton: "btn btn-primary w-xs mt-2"
                        }
                    });
                };
                break;

            case "info":
                break;
        }

        Swal.fire(swalOptions).then(() => {
            if (typeof HideLoader === "function") {  // Ensure HideLoader exists before calling
                HideLoader();
            }
        });
    };

    /**
     * Resets a form to its default state.
     * @param {string} formId - The ID of the form to reset.
     */
    $.resetForm = function (formId, options = {}) {
        const $form = $(formId);

        if ($form.length === 0) {
            console.warn("Form not found:", formId);
            return;
        }

        const defaults = {
            skipFields: [],
            defaultValues: {},
            afterReset: function () { }
        };

        const settings = $.extend(true, {}, defaults, options);

        // Preserve anti-forgery token
        const antiforgeryField = $form.find("input[type='hidden'][name='AntiforgeryFieldname']");
        const antiforgeryValue = antiforgeryField.val();

        if (antiforgeryField.length) {
            settings.skipFields.push("AntiforgeryFieldname");
        }

        // Reset form
        $form[0].reset();

        // Restore anti-forgery token
        if (antiforgeryField.length) {
            antiforgeryField.val(antiforgeryValue);
        }

        // Restore custom default values
        $.each(settings.defaultValues, function (name, value) {
            if (settings.skipFields.includes(name)) return;

            const $fields = $form.find(`[name='${name}']`);

            $fields.each(function () {
                const $field = $(this);

                if ($field.is(":checkbox")) {
                    // Support both single and multiple checkbox values
                    const values = Array.isArray(value) ? value : [value];
                    $field.prop("checked", values.includes($field.val()));
                } else if ($field.is(":radio")) {
                    $field.prop("checked", $field.val() == value);
                } else {
                    $field.val(value);
                }
            });
        });

        // Reset checkboxes that were not in defaultValues (unchecked)
        $form.find("input[type='checkbox']").each(function () {
            const $checkbox = $(this);
            const name = $checkbox.attr("name");

            // Skip if in skipFields or already handled
            if (settings.skipFields.includes(name) || settings.defaultValues.hasOwnProperty(name)) return;

            $checkbox.prop("checked", false);
        });

        // Callback
        settings.afterReset.call($form);
    };

    /**
     * Unblocks a popup and allows it to close.
     * @param {string} selector - The jQuery selector for the popup.
     */
    $.blockPopupClose = function (selector) {
        var $modal = $(selector);

        var keyboard = false; // Prevent closing by ESC
        var backdrop = "static"; // Prevent closing on click outside the modal
        var modalInstance = bootstrap.Modal.getInstance($modal[0]); // Get existing instance

        if (!modalInstance) {
            // Modal has not been initialized yet
            $modal.modal({
                keyboard: keyboard,
                backdrop: backdrop
            });
        } else {
            // Modal already exists, update options
            modalInstance._config.keyboard = keyboard;
            modalInstance._config.backdrop = backdrop;

            if (!keyboard) {
                $modal.off("keydown.dismiss.bs.modal"); // Disable ESC key
            } else {
                $modal.on("keydown.dismiss.bs.modal", function (event) {
                    if (event.key === "Escape") {
                        modalInstance.hide();
                    }
                });
            }
        }
    };

    /**
     * Blocks a popup to prevent closing.
     * @param {string} selector - The jQuery selector for the popup.
     */
    $.unblockPopupClose = function (selector) {
        var $modal = $(selector);
        var keyboard = true; // Allow closing by ESC
        var backdrop = true; // Allow closing on click outside the modal

        var modalInstance = bootstrap.Modal.getInstance($modal[0]); // Get existing instance

        if (!modalInstance) {
            // Modal has not been initialized yet
            $modal.modal({
                keyboard: keyboard,
                backdrop: backdrop,
            });
        } else {
            // Modal already exists, update options correctly
            modalInstance._config.keyboard = keyboard;
            modalInstance._config.backdrop = backdrop;

            // Restore ESC key functionality
            $modal.off("keydown.dismiss.bs.modal").on("keydown.dismiss.bs.modal", function (event) {
                if (event.key === "Escape") {
                    modalInstance.hide();
                }
            });
        }
    };

    /**
     * Blocks the UI with a loading overlay.
     * @param {string} blockUI - The selector to block.
     * @param {string} message - Optional message to display.
     */
    $.easyBlockUI = function (blockUI, message) {
        if (message != '') {
            message = '<div class="d-flex justify-content-center h4"><p class="mb-0">' + message + '</p> <div class="sk-wave m-0"><div class="sk-rect sk-wave-rect"></div> <div class="sk-rect sk-wave-rect"></div> <div class="sk-rect sk-wave-rect"></div> <div class="sk-rect sk-wave-rect"></div> <div class="sk-rect sk-wave-rect"></div></div> </div>';
        } else {
            message = '<div class="spinner-border text-white" role="status"></div>';
        }

        if (blockUI != undefined) {
            // element blocking
            var el = $(blockUI);
            var centerY = false;
            if (el.height() <= $(window).height()) {
                centerY = true;
            }
            el.block({
                message: message,
                baseZ: 999999,
                centerX: true,
                centerY: centerY,
                css: {
                    backgroundColor: 'transparent',
                    border: '0'
                },
                overlayCSS: {
                    opacity: 0.5,
                    cursor: "wait",
                }
            });
        } else {
            // page blocking
            $.blockUI({
                message: '<div class="spinner-border text-white" role="status"></div>',
                baseZ: 999999,
                css: {
                    backgroundColor: 'transparent',
                    border: '0'
                },
                overlayCSS: {
                    opacity: 0.5,
                    cursor: "wait",
                }
            });
        }
    };

    /**
     * Unblocks the UI and removes the loading overlay.
     * @param {string} blockUI - The selector to unblock.
     */
    $.easyUnblockUI = function (blockUI) {
        $(blockUI).unblock();
        $.unblockUI();
    };

    /**
     * Shows a loading spinner on a button.
     * @param {string} selector - The button selector.
     */
    $.loadingButton = function (selector) {
        var button = $(selector);
        if (button.find("span.spinner-border-sm-new").length === 0) {
            button.prepend('<span class="spinner-border-sm-new me-2" role="status"></span>');
        }
        button.prop("disabled", true);
    };

    /**
     * Removes the loading spinner from a button.
     * @param {string} selector - The button selector.
     */
    $.unloadingButton = function (selector) {
        var button = $(selector); // Fix: Directly use selector
        button.find("span.spinner-border-sm-new").remove(); // Fix: Use `find` instead of `children`
        button.prop("disabled", false);
    };

    /**
     * Validates an input value based on the specified type.
     * @param {string} controlValue - The value to validate.
     * @param {string} type - The type of validation (text, email, mobileno, password, pincode, dropdown, date, time, etc.).
     * @returns {boolean} - True if the value is valid, false otherwise.
     */
    $.ValidControlValue = function(controlValue, type = "none") {
        let allow = false;
        try {
            let strControlValue = controlValue instanceof jQuery ? controlValue.val().trim() : controlValue.toString().trim();

            if (strControlValue && regexGlobalValidation.test(strControlValue)) {
                switch (type) {
                    case "text":
                        allow = regexName.test(strControlValue);
                        break;
                    case "email":
                        allow = regexEmail.test(strControlValue);
                        break;
                    case "mobileno":
                        allow = regexMobileNo.test(strControlValue);
                        break;
                    case "password":
                        allow = regexPassword.test(strControlValue);
                        break;
                    case "pincode":
                        allow = regexPincode.test(strControlValue);
                        break;
                    case "dropdown":
                        let dropdownValue = parseInt(strControlValue, 10);
                        allow = !isNaN(dropdownValue) && (dropdownValue >= 0);
                        break;
                    case "date":
                        allow = $.isValidDate(strControlValue, dateFormat);
                        break;
                    case "time":
                        allow = $.isValidDate(strControlValue, "hh:mm A");
                        break;
                    default:
                        allow = true;
                }
            }
        } catch (error) {
            console.error("Validation Error:", error);
        }
        return allow;
    }

    /**
     * Validates whether a given date string matches the expected format.
     * @param {string} dateStr - The date string to validate.
     * @param {string} format - The expected date format.
     * @returns {boolean} - True if the date is valid, false otherwise.
     */
    $.isValidDate = function(dateStr, format) {
        try {
            return moment(dateStr, format, true).isValid();
        } catch {
            return false;
        }
    }

    /**
     * Validates a field and shows an error message if invalid.
     * @param {jQuery} control - The jQuery object of the input field.
     * @param {string} fieldName - The name of the field for error messages.
     * @param {string} type - The validation type (text, email, password, dropdown, etc.).
     * @param {string} [customRequiredMsg] - Custom message for required field (optional).
     * @param {string} [customInvalidMsg] - Custom message for invalid value (optional).
     * @returns {boolean} - True if validation fails (invalid), false otherwise.
     */
    $.ValidateAndShowError = function (control, fieldName, type, customRequiredMsg = "", customInvalidMsg = "") {
        let value = control.val().trim();

        // Set default messages if custom messages are not provided
        let requiredMsg = customRequiredMsg || `Please enter ${fieldName}!`;
        let invalidMsg = customInvalidMsg || `Please enter valid ${fieldName}!`;

        // Check if value is empty
        if (!value) {
            ShowMessage(requiredMsg, "Error!", "error"); // Show required field error
            return true;
        }

        // Validate the value using ValidControlValue
        if (!$.ValidControlValue(control, type)) {
            ShowMessage(invalidMsg, "Error!", "error"); // Show invalid format error
            return true;
        }

        return false; // No error
    };

    /**
     * Validates an image file input by ID and shows an error if invalid.
     * @param {string} controlId - The jQuery selector for the file input (e.g. '#BannerImageInput').
     * @param {string} fieldName - Field name to show in error messages.
     * @param {boolean} required - Whether the image is required.
     * @param {Array<string>} allowedExtensions - Allowed file extensions (default: jpg, jpeg, png).
     * @returns {boolean} - True if validation fails (invalid), false otherwise.
     */
    $.ValidateImageAndShowError = function (controlId, fieldName, required, allowedExtensions = ['jpg', 'jpeg', 'png']) {
        let control = $(controlId);
        let fileName = control.val().split('\\').pop(); // Extract file name
        let extension = fileName.split('.').pop().toLowerCase();

        if (required) {
            if (!fileName) {
                ShowMessage(`Please select ${fieldName}!`, "Error!", "error");
                return true;
            }
            if (allowedExtensions.indexOf(extension) === -1) {
                ShowMessage(`Select a valid ${fieldName} file (${allowedExtensions.join(', ')})!`, "Error!", "error");
                return true;
            }
        } else {
            if (fileName && allowedExtensions.indexOf(extension) === -1) {
                ShowMessage(`Select a valid ${fieldName} file (${allowedExtensions.join(', ')})!`, "Error!", "error");
                return true;
            }
        }

        return false;
    };

    /**
     * Binds language options to the dropdown by fetching data from the server.
     * This function sends an AJAX POST request with an anti-forgery token,
     * retrieves language options, and updates the #LanguageId dropdown.
     */
    $.BindLanguage = function () {
        $.easyAjax({
            type: "POST",
            url: ResolveUrl("/Admin/BindLanguage"), // Resolve the URL dynamically
            success: function (res) { // Callback function on successful response
                $("#LanguageId").empty(); // Clear the existing options in the dropdown
                // Iterate over the response data and populate the dropdown
                $.each(res, function (data, value) {
                    $("#LanguageId").append($("<option></option>").val(value.value).html(value.text));
                });
            }
        });
    }

})(jQuery);

(function ($) {
    "use strict";

    /**
     * Performs an AJAX request with predefined settings.
     * @param {object} options - The AJAX request configuration (URL, method, data, success/error handlers, etc.).
     */
    $.easyAjax = function (options) {
        var defaults = {
            type: "GET", // Default HTTP method
            container: "body", // Default container
            dataType: "json", // Expected data type
            blockUI: false, // Whether to block UI during request
            blockUIMessage: false,
            disableButton: false, // Whether to disable button during request
            buttonSelector: "[type='submit']", // Selector for the button
            antiforgeryToken: document.querySelector('input[name="AntiforgeryFieldname"]').value, // CSRF token
            errorPosition: "field", // Where to display errors
            redirect: false, // Whether to redirect on success
            reload: false, // Whether to reload the page after success
            data: {}, // Default data object
            file: false, // Whether request contains file upload
            formReset: false, // Reset form on success
            async: true, // Async request
            historyPush: false, // Whether to push state to history
            appendHtml: false, // Append response HTML
            showModal: false, // Show modal on success
            hideModal: true, // Hide modal after request
            restrictPopupClose: false, // Restrict popup close
            blockUIPopup: false, // Block UI for popups
            datatable: false, // Whether request is related to DataTable
            initSelect2: false, // Initialize Select2 plugin
            confirmation: false, // Whether to show confirmation before request
            statusSwitch: false // Handle toggle switch UI
        };

        var opt = defaults;

        // Merge user-defined options with defaults
        var opt = $.extend(defaults, options || {});
        console.log(opt);

        // ✅ If `blockUI` is true and `opt.container` is still `"body"`, set a new value
        if (opt.blockUI === true) {
            opt.blockUI = opt.container; // Change to your desired container
        }

        // Set default methods if not provided in options
        if (typeof opt.beforeSend != "function") {
            console.log('beforeSend');
            opt.beforeSend = function () {
                if (opt.historyPush) {
                    historyPush(opt.url);
                }

                if (opt.blockUI) {
                    $.easyBlockUI(opt.blockUI, opt.blockUIMessage);
                }

                if (opt.disableButton) {
                    $.loadingButton(opt.buttonSelector);
                }

                if (opt.restrictPopupClose) {
                    $.blockPopupClose(
                        "#" + $(opt.container).parents("div.modal").attr("id")
                    );
                }
            };
        }

        // Set default methods if not provided in options
        if (typeof opt.complete != "function") {
            console.log('complete');
            opt.complete = function (jqXHR, textStatus) {
                if (opt.blockUI) {
                    $.easyUnblockUI(opt.blockUI);
                }

                if (opt.disableButton) {
                    $.unloadingButton(opt.buttonSelector);
                }

                if (opt.restrictPopupClose) {
                    $.unblockPopupClose(
                        "#" + $(opt.container).parents("div.modal").attr("id")
                    );
                }

                if (opt.initSelect2) {
                    if (typeof initSelect2 == "function") {
                        initSelect2(opt.initSelect2);
                    }
                }

                if (opt.showModal) {
                    if (typeof initDatePicker == "function") {
                        initDatePicker();
                    }
                }

            };
        }

        // Set default methods if not provided in options
        if (typeof opt.error !== "function") {
            opt.error = function (jqXHR, textStatus, errorThrown) {
                try {
                    let response = jqXHR.responseText
                        ? (() => {
                            try { return JSON.parse(jqXHR.responseText); }
                            catch { return null; }
                        })()
                        : null;

                    if (response && typeof response === "object") {
                        $.handleFail(response, opt);
                    } else {
                        let msg = "A server-side error occurred. Please try again later.";

                        switch (jqXHR.status) {
                            case 404:
                                msg = "Requested resource not found (404).";
                                break;
                            case 500:
                                msg = "Internal Server Error (500).";
                                break;
                            case 403:
                                msg = "You are not authorized to perform this action (403).";
                                break;
                            default:
                                if (textStatus === "timeout") {
                                    msg = "Connection timed out! Please check your internet connection.";
                                }
                                break;
                        }

                        $.ShowMessage(msg, "Error!", "error");
                    }
                } catch (e) {
                    // When session expires, reload the login page
                    if (jqXHR.status === 401) {
                        window.location.reload();
                    } else {
                        $.ShowMessage("An unexpected error occurred!", "Error!", "error");
                    }
                }
            };
        }

        /**
         * Function to load AJAX request
         * @param {object} options - The AJAX request options
         */
        $.loadAjax = function () {
            console.log('loadAjax');
            //set post data based on file object //if file upload is set to true then it will set to formdata format
            var post_data = {};
            if (typeof opt.data !== "undefined" && Object.keys(opt.data).length > 0) {
                post_data = opt.data;
                // Check if post_data is an object before adding a new property
                if (typeof post_data === "object" && !post_data.AntiforgeryFieldname && opt.antiforgeryToken) {
                    post_data.AntiforgeryFieldname = opt.antiforgeryToken;
                }
            } else {
                if (opt.file === true) {
                    var data = new FormData($(opt.container)[0]); // initialize FormData from the form
                    post_data = data; // set this early in case you use it later

                    // Add any extra fields from opt.data
                    if (opt.data && typeof opt.data === "object") {
                        var keys = Object.keys(opt.data);
                        console.log("Extra fields from opt.data:", keys);

                        for (var i = 0; i < keys.length; i++) {
                            data.append(keys[i], opt.data[keys[i]]);
                        }
                    }

                    // Check if antiforgery token exists, if not, add it
                    if (!data.has("AntiforgeryFieldname") && opt.antiforgeryToken) {
                        data.append("AntiforgeryFieldname", opt.antiforgeryToken);
                        console.log("Antiforgery token appended to FormData.");
                    }
                } else {
                    post_data = $(opt.container).serialize();

                    // Check if antiforgery token exists in serialized data
                    if (!post_data.includes("AntiforgeryFieldname") && opt.antiforgeryToken) {
                        post_data += (post_data ? "&" : "") + "AntiforgeryFieldname=" + encodeURIComponent(opt.antiforgeryToken);
                    }
                }
            }

            console.log("post_data" + post_data)

            $.ajax({
                async: opt.async,
                type: opt.type,
                url: opt.url ? opt.url : $(opt.container).prop("action"),
                dataType: opt.dataType,
                data: post_data,
                beforeSend: opt.beforeSend,
                contentType: opt.file
                    ? false
                    : 'application/x-www-form-urlencoded; charset=UTF-8',
                processData: !opt.file,
                error: opt.error,
                complete: opt.complete,
                cache: false,
                success: function (response) {
                    if (typeof response !== "undefined" && response !== null) {
                        // If a custom success callback is provided, execute it
                        if (typeof opt.success === "function") {
                            opt.success(response);
                        } else {
                            // Check if the response indicates success
                            if (response.success || response.type === "success") {
                                // Handle redirection if a redirect URL is provided
                                if (typeof response.redirect_url !== "undefined" && response.redirect_url) {
                                    window.location.href = response.redirect_url;
                                } else if (opt.redirect && response.url) {
                                    window.location.href = response.url;
                                }

                                // Append response data to the specified element, if applicable
                                if (response.data && opt.appendHtml) {
                                    $(opt.appendHtml).html(response.data);
                                }

                                // Show modal if `opt.showModal` is specified
                                if (opt.showModal) {
                                    console.log('showModal')
                                    $(opt.showModal).modal("show");
                                }

                                // Reset the form if `opt.formReset` is true and the form exists
                                if (opt.formReset && $(opt.container).length) {
                                    $.resetForm(opt.container, {
                                        skipFields: ["IsActive"] // This now merges with Antiforgery token instead of replacing it
                                    })
                                }

                                // Reload the page if `opt.reload` is true
                                if (opt.reload) {
                                    window.location.reload();
                                }

                                // If a DataTable instance is provided, refresh it
                                if (opt.datatable && typeof opt.datatable.ajax.reload === "function") {
                                    //opt.datatable.ajax.reload(null, false); // `false` keeps pagination, `true` resets to page 1
                                    opt.datatable.ajax.reload(function () {
                                        opt.datatable.column(0).nodes().each(function (cell, i) {
                                            cell.innerHTML = i + 1;
                                        });

                                        // Get DataTable ID dynamically
                                        let tableId = opt.datatable.table().node().id;

                                        // Adjust content height after reload
                                        setTimeout(() => $.forceLayoutFix(tableId), 50);
                                    }, false);
                                    $('.modal').modal("hide"); // Hide any open modal after updating DataTable
                                    $.ShowMessage(response.strMessage, "Success!", "success");
                                }
                            }

                            // Handle error messages if the response contains an error
                            if (response.isError || response.error) {
                                $.ShowMessage(response.strMessage, "Error!", "error");
                            }

                            // Display informational messages if present in the response
                            if (response.info) {
                                $.ShowMessage(response.strMessage, "Success!", "info");
                            }
                        }
                    }
                },
            });
        }

        /**
         * Helper function to adjust layout after AJAX load.
         * @param {string} tableId - The ID of the table to fix layout for
         */
        $.forceLayoutFix = function(tableId) {
            let table = $('#' + tableId); // Select table dynamically
            let windowHeight = $(window).height();
            let tableBottom = table.offset().top + table.outerHeight();
            let footerHeight = $('.footer').outerHeight();

            if (tableBottom + footerHeight < windowHeight) {
                $('.footer').css({ position: 'fixed', bottom: '0', width: '100%' });
            } else {
                $('.footer').css({ position: 'absolute' });
            }
        }

        // ✅ Call after defining $.loadAjax
        if (opt.confirmation) {
            if (opt.statusSwitch) {
                $.showConfirmation({
                    statusSwitch: opt.statusSwitch, // ✅ Pass switch element to revert on cancel
                });
            } else {
                $.showConfirmation();
            }
        } else {
            $.loadAjax(opt);
        }
        
    };

    /**
     * Handles AJAX request failures.
     * @param {object} response - The response object from the failed AJAX request.
     * @param {object} opt - Optional additional settings for error handling.
     */
    $.handleFail = function(response, opt) {
        console.log('handleFail');
        if (typeof response.strMessage != "undefined" && response.strMessage != "") {
            $.ShowMessage(response.strMessage + '!', 'Error!', "error");
        } else {
            $.ShowMessage(
                "A server side error occurred. Please try again after sometime" + '!',
                "Error!",
                "error"
            );
        }

        if (typeof response.validationErrors != "undefined") {
            $(opt.container).find(".invalid-feedback").remove(); // Remove old error messages
            $(opt.container).find(".is-invalid").removeClass("is-invalid");
            $(opt.container).find(".error-group").removeClass("error-group"); // Remove old error class

            if (opt.errorPosition === "field") {
                for (var i = 0; i < response.validationErrors.length; i++) {
                    var field = response.validationErrors[i].field;
                    var message = response.validationErrors[i].message;

                    // Escape dot for array fields
                    var key = field.replace(".", "\\.");

                    var ele = $(opt.container).find("[name='" + key + "']");

                    // If cannot find by name, then find by ID
                    if (ele.length === 0) {
                        ele = $(opt.container).find("#" + key);
                    }

                    // Find the closest form group and add error class
                    var grp = ele.closest(".form-group"); // You can customize this if needed
                    grp.addClass("error-group"); // Adding new class for error styling

                    // Remove any previous error messages
                    $(grp).find(".invalid-feedback").remove();

                    // Append error message
                    $(grp).append('<div class="invalid-feedback">' + message + '</div>');

                    // Add invalid class
                    ele.addClass("is-invalid");

                    // Handle select2 & bootstrap-select elements
                    $(grp).find(".select2").parent().addClass("is-invalid");
                    $(grp).find(".bootstrap-select").addClass("is-invalid");
                }

                // Scroll to the first invalid field
                if (response.validationErrors.length > 0) {
                    var firstField = response.validationErrors[0].field;
                    var element = $("[name='" + firstField + "']");
                    if (element.length > 0) {
                        $("html, body").animate(
                            { scrollTop: element.offset().top - 150 },
                            200
                        );
                    }
                }
            } else {
                var errorMsg = "<ul>";
                for (var i = 0; i < response.validationErrors.length; i++) {
                    errorMsg += "<li>" + response.validationErrors[i].message + "</li>";
                }
                errorMsg += "</ul>";

                var errorElement = $(opt.container).find("#alert");
                var html = '<div class="alert alert-danger">' + errorMsg + "</div>";

                if (errorElement.length === 0) {
                    $(opt.container).find(".form-group:first").before('<div id="alert">' + html + "</div>");
                } else {
                    errorElement.html(html);
                }
            }
        }
    }
})(jQuery);

//history pushstate
const historyPush = (url) => {
    window.history.pushState({ id: url }, url, url);
};

// when session expire then it reload user to login page
$(document).ajaxError(function (event, jqxhr, settings, thrownError) {
    if (jqxhr.status == 401) {
        window.location.reload();
    }
});

// Prevent submit of ajax form
$(document).on("click", ".sweet-alert .confirm", function (e) {
    $(".sweet-alert .confirm").addClass("is-loading").prop("disabled", true);
});

$(document).on("ready", function () {
    $(".ajax-form").on("submit", function (e) {
        e.preventDefault();
    });
});

$(document).on("ajaxPageLoad", function () {
    $(".ajax-form").on("submit", function (e) {
        e.preventDefault();
    });
});

!(function () {
    "use strict";
    function e(e) {
        function t(t, n) {
            var s,
                h,
                k = t == window,
                y = n && void 0 !== n.message ? n.message : void 0;
            if (
                ((n = e.extend({}, e.blockUI.defaults, n || {})),
                    !n.ignoreIfBlocked || !e(t).data("blockUI.isBlocked"))
            ) {
                if (
                    ((n.overlayCSS = e.extend(
                        {},
                        e.blockUI.defaults.overlayCSS,
                        n.overlayCSS || {}
                    )),
                        (s = e.extend({}, e.blockUI.defaults.css, n.css || {})),
                        n.onOverlayClick && (n.overlayCSS.cursor = "pointer"),
                        (h = e.extend(
                            {},
                            e.blockUI.defaults.themedCSS,
                            n.themedCSS || {}
                        )),
                        (y = void 0 === y ? n.message : y),
                        k && p && o(window, { fadeOut: 0 }),
                        y && "string" != typeof y && (y.parentNode || y.jquery))
                ) {
                    var m = y.jquery ? y[0] : y,
                        v = {};
                    e(t).data("blockUI.history", v),
                        (v.el = m),
                        (v.parent = m.parentNode),
                        (v.display = m.style.display),
                        (v.position = m.style.position),
                        v.parent && v.parent.removeChild(m);
                }
                e(t).data("blockUI.onUnblock", n.onUnblock);
                var g,
                    I,
                    w,
                    U,
                    x = n.baseZ;
                (g = e(
                    r || n.forceIframe
                        ? '<iframe class="blockUI" style="z-index:' +
                        x++ +
                        ';display:none;border:none;margin:0;padding:0;position:absolute;width:100%;height:100%;top:0;left:0" src="' +
                        n.iframeSrc +
                        '"></iframe>'
                        : '<div class="blockUI" style="display:none"></div>'
                )),
                    (I = e(
                        n.theme
                            ? '<div class="blockUI blockOverlay ui-widget-overlay" style="z-index:' +
                            x++ +
                            ';display:none"></div>'
                            : '<div class="blockUI blockOverlay" style="z-index:' +
                            x++ +
                            ';display:none;border:none;margin:0;padding:0;width:100%;height:100%;top:0;left:0"></div>'
                    )),
                    n.theme && k
                        ? ((U =
                            '<div class="blockUI ' +
                            n.blockMsgClass +
                            ' blockPage ui-dialog ui-widget ui-corner-all" style="z-index:' +
                            (x + 10) +
                            ';display:none;position:fixed">'),
                            n.title &&
                            (U +=
                                '<div class="ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle">' +
                                (n.title || "&nbsp;") +
                                "</div>"),
                            (U +=
                                '<div class="ui-widget-content ui-dialog-content"></div>'),
                            (U += "</div>"))
                        : n.theme
                            ? ((U =
                                '<div class="blockUI ' +
                                n.blockMsgClass +
                                ' blockElement ui-dialog ui-widget ui-corner-all" style="z-index:' +
                                (x + 10) +
                                ';display:none;position:absolute">'),
                                n.title &&
                                (U +=
                                    '<div class="ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle">' +
                                    (n.title || "&nbsp;") +
                                    "</div>"),
                                (U +=
                                    '<div class="ui-widget-content ui-dialog-content"></div>'),
                                (U += "</div>"))
                            : (U = k
                                ? '<div class="blockUI ' +
                                n.blockMsgClass +
                                ' blockPage" style="z-index:' +
                                (x + 10) +
                                ';display:none;position:fixed"></div>'
                                : '<div class="blockUI ' +
                                n.blockMsgClass +
                                ' blockElement" style="z-index:' +
                                (x + 10) +
                                ';display:none;position:absolute"></div>'),
                    (w = e(U)),
                    y &&
                    (n.theme
                        ? (w.css(h), w.addClass("ui-widget-content"))
                        : w.css(s)),
                    n.theme || I.css(n.overlayCSS),
                    I.css("position", k ? "fixed" : "absolute"),
                    (r || n.forceIframe) && g.css("opacity", 0);
                var C = [g, I, w],
                    S = e(k ? "body" : t);
                e.each(C, function () {
                    this.appendTo(S);
                }),
                    n.theme &&
                    n.draggable &&
                    e.fn.draggable &&
                    w.draggable({
                        handle: ".ui-dialog-titlebar",
                        cancel: "li",
                    });
                var O =
                    f &&
                    (!e.support.boxModel ||
                        e("object,embed", k ? null : t).length > 0);
                if (u || O) {
                    if (
                        (k &&
                            n.allowBodyStretch &&
                            e.support.boxModel &&
                            e("html,body").css("height", "100%"),
                            (u || !e.support.boxModel) && !k)
                    )
                        var E = d(t, "borderTopWidth"),
                            T = d(t, "borderLeftWidth"),
                            M = E ? "(0 - " + E + ")" : 0,
                            B = T ? "(0 - " + T + ")" : 0;
                    e.each(C, function (e, t) {
                        var o = t[0].style;
                        if (((o.position = "absolute"), 2 > e))
                            k
                                ? o.setExpression(
                                    "height",
                                    "Math.max(document.body.scrollHeight, document.body.offsetHeight) - (jQuery.support.boxModel?0:" +
                                    n.quirksmodeOffsetHack +
                                    ') + "px"'
                                )
                                : o.setExpression(
                                    "height",
                                    'this.parentNode.offsetHeight + "px"'
                                ),
                                k
                                    ? o.setExpression(
                                        "width",
                                        'jQuery.support.boxModel && document.documentElement.clientWidth || document.body.clientWidth + "px"'
                                    )
                                    : o.setExpression(
                                        "width",
                                        'this.parentNode.offsetWidth + "px"'
                                    ),
                                B && o.setExpression("left", B),
                                M && o.setExpression("top", M);
                        else if (n.centerY)
                            k &&
                                o.setExpression(
                                    "top",
                                    '(document.documentElement.clientHeight || document.body.clientHeight) / 2 - (this.offsetHeight / 2) + (blah = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"'
                                ),
                                (o.marginTop = 0);
                        else if (!n.centerY && k) {
                            var i =
                                n.css && n.css.top
                                    ? parseInt(n.css.top, 10)
                                    : 0,
                                s =
                                    "((document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + " +
                                    i +
                                    ') + "px"';
                            o.setExpression("top", s);
                        }
                    });
                }
                if (
                    (y &&
                        (n.theme
                            ? w.find(".ui-widget-content").append(y)
                            : w.append(y),
                            (y.jquery || y.nodeType) && e(y).show()),
                        (r || n.forceIframe) && n.showOverlay && g.show(),
                        n.fadeIn)
                ) {
                    var j = n.onBlock ? n.onBlock : c,
                        H = n.showOverlay && !y ? j : c,
                        z = y ? j : c;
                    n.showOverlay && I._fadeIn(n.fadeIn, H),
                        y && w._fadeIn(n.fadeIn, z);
                } else
                    n.showOverlay && I.show(),
                        y && w.show(),
                        n.onBlock && n.onBlock.bind(w)();
                if (
                    (i(1, t, n),
                        k
                            ? ((p = w[0]),
                                (b = e(n.focusableElements, p)),
                                n.focusInput && setTimeout(l, 20))
                            : a(w[0], n.centerX, n.centerY),
                        n.timeout)
                ) {
                    var W = setTimeout(function () {
                        k ? e.unblockUI(n) : e(t).unblock(n);
                    }, n.timeout);
                    e(t).data("blockUI.timeout", W);
                }
            }
        }
        function o(t, o) {
            var s,
                l = t == window,
                a = e(t),
                d = a.data("blockUI.history"),
                c = a.data("blockUI.timeout");
            c && (clearTimeout(c), a.removeData("blockUI.timeout")),
                (o = e.extend({}, e.blockUI.defaults, o || {})),
                i(0, t, o),
                null === o.onUnblock &&
                ((o.onUnblock = a.data("blockUI.onUnblock")),
                    a.removeData("blockUI.onUnblock"));
            var r;
            (r = l
                ? e("body").children().filter(".blockUI").add("body > .blockUI")
                : a.find(">.blockUI")),
                o.cursorReset &&
                (r.length > 1 && (r[1].style.cursor = o.cursorReset),
                    r.length > 2 && (r[2].style.cursor = o.cursorReset)),
                l && (p = b = null),
                o.fadeOut
                    ? ((s = r.length),
                        r.stop().fadeOut(o.fadeOut, function () {
                            0 === --s && n(r, d, o, t);
                        }))
                    : n(r, d, o, t);
        }
        function n(t, o, n, i) {
            var s = e(i);
            if (!s.data("blockUI.isBlocked")) {
                t.each(function () {
                    this.parentNode && this.parentNode.removeChild(this);
                }),
                    o &&
                    o.el &&
                    ((o.el.style.display = o.display),
                        (o.el.style.position = o.position),
                        (o.el.style.cursor = "default"),
                        o.parent && o.parent.appendChild(o.el),
                        s.removeData("blockUI.history")),
                    s.data("blockUI.static") && s.css("position", "static"),
                    "function" == typeof n.onUnblock && n.onUnblock(i, n);
                var l = e(document.body),
                    a = l.width(),
                    d = l[0].style.width;
                l.width(a - 1).width(a), (l[0].style.width = d);
            }
        }
        function i(t, o, n) {
            var i = o == window,
                l = e(o);
            if (
                (t || ((!i || p) && (i || l.data("blockUI.isBlocked")))) &&
                (l.data("blockUI.isBlocked", t),
                    i && n.bindEvents && (!t || n.showOverlay))
            ) {
                var a =
                    "mousedown mouseup keydown keypress keyup touchstart touchend touchmove";
                t ? e(document).bind(a, n, s) : e(document).unbind(a, s);
            }
        }
        function s(t) {
            if (
                "keydown" === t.type &&
                t.keyCode &&
                9 == t.keyCode &&
                p &&
                t.data.constrainTabKey
            ) {
                var o = b,
                    n = !t.shiftKey && t.target === o[o.length - 1],
                    i = t.shiftKey && t.target === o[0];
                if (n || i)
                    return (
                        setTimeout(function () {
                            l(i);
                        }, 10),
                        !1
                    );
            }
            var s = t.data,
                a = e(t.target);
            return (
                a.hasClass("blockOverlay") &&
                s.onOverlayClick &&
                s.onOverlayClick(t),
                a.parents("div." + s.blockMsgClass).length > 0
                    ? !0
                    : 0 === a.parents().children().filter("div.blockUI").length
            );
        }
        function l(e) {
            if (b) {
                var t = b[e === !0 ? b.length - 1 : 0];
                t && t.focus();
            }
        }
        function a(e, t, o) {
            var n = e.parentNode,
                i = e.style,
                s =
                    (n.offsetWidth - e.offsetWidth) / 2 -
                    d(n, "borderLeftWidth"),
                l =
                    (n.offsetHeight - e.offsetHeight) / 2 -
                    d(n, "borderTopWidth");
            t && (i.left = s > 0 ? s + "px" : "0"),
                o && (i.top = l > 0 ? l + "px" : "0");
        }
        function d(t, o) {
            return parseInt(e.css(t, o), 10) || 0;
        }
        e.fn._fadeIn = e.fn.fadeIn;
        var c = e.noop || function () { },
            r = /MSIE/.test(navigator.userAgent),
            u =
                /MSIE 6.0/.test(navigator.userAgent) &&
                !/MSIE 8.0/.test(navigator.userAgent),
            f =
                (document.documentMode || 0,
                    e.isFunction(
                        document.createElement("div").style.setExpression
                    ));
        (e.blockUI = function (e) {
            t(window, e);
        }),
            (e.unblockUI = function (e) {
                o(window, e);
            }),
            (e.growlUI = function (t, o, n, i) {
                var s = e('<div class="growlUI"></div>');
                t && s.append("<h1>" + t + "</h1>"),
                    o && s.append("<h2>" + o + "</h2>"),
                    void 0 === n && (n = 3e3);
                var l = function (t) {
                    (t = t || {}),
                        e.blockUI({
                            message: s,
                            fadeIn:
                                "undefined" != typeof t.fadeIn ? t.fadeIn : 700,
                            fadeOut:
                                "undefined" != typeof t.fadeOut
                                    ? t.fadeOut
                                    : 1e3,
                            timeout:
                                "undefined" != typeof t.timeout ? t.timeout : n,
                            centerY: !1,
                            showOverlay: !1,
                            onUnblock: i,
                            css: e.blockUI.defaults.growlCSS,
                        });
                };
                l();
                s.css("opacity");
                s.mouseover(function () {
                    l({ fadeIn: 0, timeout: 3e4 });
                    var t = e(".blockMsg");
                    t.stop(), t.fadeTo(300, 1);
                }).mouseout(function () {
                    e(".blockMsg").fadeOut(1e3);
                });
            }),
            (e.fn.block = function (o) {
                if (this[0] === window) return e.blockUI(o), this;
                var n = e.extend({}, e.blockUI.defaults, o || {});
                return (
                    this.each(function () {
                        var t = e(this);
                        (n.ignoreIfBlocked && t.data("blockUI.isBlocked")) ||
                            t.unblock({ fadeOut: 0 });
                    }),
                    this.each(function () {
                        "static" == e.css(this, "position") &&
                            ((this.style.position = "relative"),
                                e(this).data("blockUI.static", !0)),
                            (this.style.zoom = 1),
                            t(this, o);
                    })
                );
            }),
            (e.fn.unblock = function (t) {
                return this[0] === window
                    ? (e.unblockUI(t), this)
                    : this.each(function () {
                        o(this, t);
                    });
            }),
            (e.blockUI.version = 2.7),
            (e.blockUI.defaults = {
                message: "<h1>Please wait...</h1>",
                title: null,
                draggable: !0,
                theme: !1,
                css: {
                    padding: 0,
                    margin: 0,
                    width: "30%",
                    top: "40%",
                    left: "35%",
                    textAlign: "center",
                    color: "#000",
                    border: "3px solid #aaa",
                    backgroundColor: "#fff",
                    cursor: "wait",
                },
                themedCSS: { width: "30%", top: "40%", left: "35%" },
                overlayCSS: {
                    backgroundColor: "#000",
                    opacity: 0.6,
                    cursor: "wait",
                },
                cursorReset: "default",
                growlCSS: {
                    width: "350px",
                    top: "10px",
                    left: "",
                    right: "10px",
                    border: "none",
                    padding: "5px",
                    opacity: 0.6,
                    cursor: "default",
                    color: "#fff",
                    backgroundColor: "#000",
                    "-webkit-border-radius": "10px",
                    "-moz-border-radius": "10px",
                    "border-radius": "10px",
                },
                iframeSrc: /^https/i.test(window.location.href || "")
                    ? "javascript:false"
                    : "about:blank",
                forceIframe: !1,
                baseZ: 1e3,
                centerX: !0,
                centerY: !0,
                allowBodyStretch: !0,
                bindEvents: !0,
                constrainTabKey: !0,
                fadeIn: 200,
                fadeOut: 400,
                timeout: 0,
                showOverlay: !0,
                focusInput: !0,
                focusableElements: ":input:enabled:visible",
                onBlock: null,
                onUnblock: null,
                onOverlayClick: null,
                quirksmodeOffsetHack: 4,
                blockMsgClass: "blockMsg",
                ignoreIfBlocked: !1,
            });
        var p = null,
            b = [];
    }
    "function" == typeof define && define.amd && define.amd.jQuery
        ? define(["jquery"], e)
        : e(jQuery);
})();
