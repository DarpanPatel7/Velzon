$(document).ready(function () {
    var lgLangId = $("#lgLanguageId").val();
    if (lgLangId == "2") {
        $("#lblTotalVisitor").html('કુલ મુલાકાતીઓ');
        $(".lblReadMore").html('વધુ વાંચો');
        $(".lblViewAll").html('વધુ જુઓ');
    }
    else {
        $("#lblTotalVisitor").html('Total Visitors');
        $(".lblReadMore").html('Read More');
        $(".lblViewAll").html('View All');
    }

    BindLanguage();
    BindHeader();
    BindMainLogo();
    BindFooter();
    GetWebSiteVisitorsCount();
    BindHiddenTemplate();

    $("#langId").change(function () {
        var token = $('input[name="AntiforgeryFieldname"]').val();
        $.ajax({
            type: "POST",
            url: ResolveUrl("/UpdateLanguage"),
            contentType: "application/x-www-form-urlencoded",
            data: { "AntiforgeryFieldname": token, "langId": $('option:selected', this).val() },
            dataType: "json",
            success: function (res) {
                $("#lgLanguageId").val(res);
                $("#langId").val(res);
                location.reload();
            }
        });
    });

    var els = document.querySelectorAll("a[href*='/ViewFile?fileName=']");
    for (var i = 0; i < els.length; i++) {
        els[i].href = ResolveUrl(els[i].getAttribute('href'));
    }

});

$(document).ready(function () {
    $('.map-color').click(function () {
        $('.map-color').each(function () {
            $(this).removeClass('active');
        });
        $(this).addClass('active');
    });
});

$(document).ready(function () {
    if ($(".tooltip-map").hasClass("tooltip-map")) {
        $('.tooltip-map').tooltipster({
            anchor: 'left-center',
            //content: 'right',
            delay: 2,
            multiple: true,
            offset: [10, 0],
            interactive: true,
            plugins: ['laa.follower']
        });
    }
});

function BindLanguage() {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindLanguage"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            if (res && !res.isError) {
                $("#langId").empty();
                res.forEach(value => {
                    $("#langId").append($("<option></option>").val(value.value).html(value.text));
                });
                if ($("#lgLanguageId").val() != null && $("#lgLanguageId").val() != undefined) {
                    if ($("#lgLanguageId").val() == "0") {
                        $("#lgLanguageId").val("1");
                    }
                    $("#langId").val($("#lgLanguageId").val());
                }
            }
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindHeader() {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindHeader"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            $("#dvHeader").empty();
            $("#dvHeader").html((res ? res.replace('<p>', '').replace('</p>', '') : ""));
            ResolveUrlHTML();
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindMainLogo() {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindMainLogo"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            if (res) {
                $("#dvMainLogo").empty();
                $("#dvMainLogo").html(res ?? "");
                ResolveUrlHTML();
            } else {
                $("#bkMainLogo").hide();
            }

        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindFooter() {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindFooter"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            $("#dvFooter").empty();
            $("#dvFooter").html(res ?? "");
            ResolveUrlHTML();
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function GetWebSiteVisitorsCount() {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        type: "POST",
        url: ResolveUrl("/GetWebSiteVisitorsCount"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            $("#CounterVisitor").empty();
            $("#CounterVisitor").html(res.result.totalCount ?? 0);
            ResolveUrlHTML();
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindHiddenTemplate() {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindHiddenTemplate"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            $("#dvHiddenTemplate").empty();
            $("#dvHiddenTemplate").html(res ?? "");
            ResolveUrlHTML();
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function ResolveUrlHTML() {
    let elss = document.querySelectorAll("img[src]");
    for (let i = 0; i < elss.length; i++) {
        var src = elss[i].getAttribute('src');
        if (src.includes("java")) {
            src = (src).split(baseUrl.substring(0, (baseUrl.length - 1))).join('').substring(1);
            elss[i].src = (src);
        }
        else if (!src.startsWith("http") && !src.includes("data:") && !src.includes("java") && !src.includes("#") && src.includes(baseUrl.substring(0, (baseUrl.length - 1)) + baseUrl.substring(0, (baseUrl.length - 1)))) {
            src = baseUrl.substring(0, (baseUrl.length - 1)) + ResolveUrl(src).split(baseUrl.substring(0, (baseUrl.length - 1))).join('');
            elss[i].src = (src);
        }
        if (!src.startsWith("#") && !src.includes("data:") && !src.startsWith("mailto") && !src.startsWith("tel:") && !src.includes("embed") && !src.startsWith(baseUrl) && !src.startsWith("User") && !src.startsWith("http") && !src.includes("java") && !src.includes("#")) {
            src = baseUrl.substring(0, (baseUrl.length - 1)) + ResolveUrl(src).split(baseUrl.substring(0, (baseUrl.length - 1))).join('');
            elss[i].src = src;
        }
    }

    let sadasd = document.querySelectorAll("a[href]");
    for (let i = 0; i < sadasd.length; i++) {
        var href = sadasd[i].getAttribute('href');
        if (href.includes("java")) {
            if (!href.startsWith("java")) {
                href = (href).split(baseUrl.substring(0, (baseUrl.length - 1))).join('').substring(1);
                sadasd[i].href = (href);
            }
        }
        else if (!href.startsWith("#") && !href.startsWith("mailto") && !href.startsWith("tel:") && !href.includes("embed") && !href.startsWith(baseUrl) && !href.startsWith("User") && !href.startsWith("http") && !href.startsWith("java") && !href.startsWith("#")) {
            href = baseUrl.substring(0, (baseUrl.length - 1)) + ResolveUrl(href).split(baseUrl.substring(0, (baseUrl.length - 1))).join('');
            sadasd[i].href = (href);
        }
        else if (!href.startsWith("http") && !href.includes("java") && !href.includes("#") && href.includes(baseUrl.substring(0, (baseUrl.length - 1)) + baseUrl.substring(0, (baseUrl.length - 1)))) {
            href = baseUrl.substring(0, (baseUrl.length - 1)) + ResolveUrl(href).split(baseUrl.substring(0, (baseUrl.length - 1))).join('');
            sadasd[i].href = (href);
        }
    }
}