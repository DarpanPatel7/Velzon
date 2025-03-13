$(document).ready(function () {
    var lgLangId = $("#lgLanguageId").val();
    if (lgLangId == "2") {
        $("#tlAnnouncement").html('જાહેરાતો');
        $("#tlEducationCorner").html('શિક્ષણ કોર્નર');
        $("#tlScheme").html('યોજનાઓ');
        $("#tlLatestNews").html('સમાચાર અને ઈવેન્ટ્સ');
        $("#tlNotificationCircular").html('સૂચનાઓ / પરિપત્રો');
        $("#tlGovernmentResolution").html('સરકારી ઠરાવો');
        $("#tlTender").html('ટેન્ડરો');
        $("#tlOnlineService").html('ઓનલાઇન સેવાઓ');
        $("#tlSpecialInitiative").html('વિશેષ પહેલ');
        $("#tlAchievement").html('સિદ્ધિઓ');
        $("#tlImportantWebsite").html('મહત્વની વેબસાઇટો');
        $("#tlServiceRate").html('સેવા દર');
        $("#tlProjects").html('પ્રોજેક્ટ');
        $("#tlMedia").html('મીડિયા');
       
    }
    else {
        $("#tlAnnouncement").html('Announcements');
        $("#tlEducationCorner").html('Education Corner');
        $("#tlScheme").html('Schemes');
        $("#tlLatestNews").html('News & Events');
        $("#tlNotificationCircular").html('Notification / Circular');
        $("#tlGovernmentResolution").html('Government Resolutions');
        $("#tlTender").html('Tenders');
        $("#tlOnlineService").html('Online Services');
        $("#tlSpecialInitiative").html('Special Initiatives');
        $("#tlAchievement").html('Achievements');
        $("#tlImportantWebsite").html('Important Websites');
        $("#tlServiceRate").html('Services Rates');
        $("#tlProjects").html('Projects');
        $("#tlMedia").html('Media');
    }

    BindPopup();
    BindBanner();
    BindAnnouncement();
    BindWelComeNote();
    BindMinister();
    BindNewsAndEvent();
    BindProject();
    BindMedia();
    BindServiceRateArea();
    BindBrandLogo();
    
});

function BindPopup() {
    $.ajax({
        type: "GET",
        url: ResolveUrl("/GetPopup"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            if (res && res.result && !res.isError) {
                var strInnerHtml = "";
                res.result.forEach(value => {
                    strInnerHtml += `${value.popupDescription}`;
                });
                $("#DivDescriptionPopup").html(strInnerHtml);
                $('#mdlFront').modal('show');
                ResolveUrlHTML();
            }
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindBanner() {

    $.ajax({
        type: "GET",
        url: ResolveUrl("/GetBanner"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            if (res && !res.isError) {
                var strInnerHtml = "";
                var i = 1;
                res.result.forEach(value => {
                    var strpath = "#";
                    if (value.imagePath) {
                        strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.imagePath));
                    }
                    var active = (i === 1) ? 'active' : '';
                    strInnerHtml += `<div class="item ${active}">
				        <img src="${strpath}" title="${value.title ?? ''}" alt="${value.title ?? 'Image'}">
			        </div>`;
                    i++;
                });
                $('#dvBanner').append(strInnerHtml);
                initializeBannerOwlCarousel('#dvBanner');
            }
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindAnnouncement() {
    $.ajax({
        type: "GET",
        url: ResolveUrl("/GetAnnouncement"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            if (res && res.result && !res.isError) {
                var strInnerHtml = "";
                $("#dvAnnouncement").html("");
                res.result.forEach(value => {
                    let strpath = "#";
                    let link = '';
                    if (!value.isLink) {
                        if (value.imagePath) {
                            strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.imagePath));
                            link = `<a href="${strpath}" target="_blank">${$.sanitizePTag(value.newsTitle)}</a>`;
                        } else {
                            link = `<a href="${strpath}" target="_blank">${$.sanitizePTag(value.newsDesc)}</a>`;
                        }
                    } else {
                        link = `${$.sanitizePTag(value.newsDesc)}`;
                    }
                    strInnerHtml += `<div class="carousel-item">${link}</div>`;
                });
                $("#dvAnnouncement").html(strInnerHtml);
                $("#dvAnnouncement div.carousel-item").first().addClass('active');
            } else {
                var nodata = `<div class="carousel-item active">
                    No Announcement Available
                </div>`;
                $("#dvAnnouncement").html(nodata);
            }
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindWelComeNote() {
    var token = $('input[name="AntiforgeryFieldname"]').val();
    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindWelComeNote"),
        contentType: "application/x-www-form-urlencoded",
        data: { "AntiforgeryFieldname": token },
        dataType: "json",
        success: function (res) {
            $("#dvWelComeNote").empty();
            $("#dvWelComeNote").html(res ?? "");
            ResolveUrlHTML();
        }
    });
}

function BindMinister() {
    $.ajax({
        type: "GET",
        url: ResolveUrl("/GetMinister"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            if (res && !res.isError) {
                var strInnerHtml = "";
                res.result.forEach(value => {
                    var strpath = "#";
                    if (value.imagePath) {
                        strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.imagePath));
                    }
                    strInnerHtml += `<div class="outer-box d-flex align-items-center">
						<div class="outericon">
							<div class="innerimg">
								<img src="${strpath}" title="${value.ministerName ?? ''}" alt="${value.ministerName ?? 'Image'}">
							</div>
						</div>
						<div class="pbminfotech-box-content ministerbox">
							<div class="pbminfotech-box-content-inner">
								<h3 class="pbmit-team-title ministertitle">
									<p>${value.ministerName ?? ''}</p>
								</h3>
								<div class="pbminfotech-team-position">
									<div class="pbminfotech-box-team-position ministerdep">
										${(value.ministerDescription) ? value.ministerDescription.replace('<p>', '').replace('</p>', '') : ''}
									</div>
								</div>
							</div>
						</div>
					</div>`;
                });
                $('#dvMinister').html(strInnerHtml);
            }
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindNewsAndEvent() {
    $.ajax({
        type: "GET",
        url: ResolveUrl("/GetNews"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            if (res && res.result && !res.isError) {
                let strInnerHtml = "";
                res.result.forEach(function (value) {
                    const imagePath = value.imagePath ? ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.imagePath)) : "#";
                    const newsDate = `<div class="ltn__blog-date"><i class="far fa-calendar-alt mr-10"></i> ${value.indexFrontDateDisplay}</div>`;
                    const newsTitle = htmlDecode(value.newsTitle || "");
                    const newsDescription = $.sanitizePTag(value.newsDesc || "No description available");

                    strInnerHtml += `<li class="popular-post-widget-item clearfix">
                        ${value.isLink === false
                        ? `<a href="${imagePath}" target="_blank" class="ltn__blog-meta">
                                    <div class="ltn__blog-date">
									    <span>${newsDate}</span>
								    </div>
                                    <div>${newsTitle}</div>
                                </a>`
                        : `${newsDate}
                                <div class="show-read-moreNews">${newsDescription}</div>`}
                    </li>`;
                });
                $("#dvNews").html(strInnerHtml);
                AddReadMore('News');
            } else {
                const noDataHtml = `
                    <li class="popular-post-widget-item clearfix">
                        <div class="popular-post-widget-brief">
                            <a href="javascript:;" class="ltn__blog-meta">
                                <div class="ltn_desc">No News Available</div>
                            </a>
                        </div>
                    </li>`;
                $("#dvNews").html(noDataHtml);
            }
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindProject() {
    $.ajax({

        type: "get", url: ResolveUrl("/GetProjects"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            var dataList = res.result;

            if (res.isError == true) {
                //ShowMessage(res.strMessage, "", "error");
                HideLoader();
            }
            else {
                var strInnerHtml = "";

                var lgLangId = $("#lgLanguageId").val();
                var readMoreText = "Read More";
                if (lgLangId == "2") {
                    readMoreText = "વધુ જુઓ";
                }
                $.each(dataList, function (data, value) {
                    var lgLangId = $("#lgLanguageId").val();
                    var strSubStr = "";
                    if (value.filePath != null && value.filePath != undefined && value.filePath != '') {
                        var strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.filePath));
                    }


                    strSubStr += `<article class="pbmit-blog-style-1">
						<div class="post-item">
							<div class="pbmit-featured-container">
								<div class="pbmit-featured-wrapper">
									<img src="${strpath}" class="img-fluid" alt="">
								</div>
							</div>
							<div class="pbminfotech-box-content">
								<div class="pbminfotech-box-container">
									<h3 class="pbmit-post-title">
										<a href="${ResolveUrl("/Home/ProjectDetailspage/" + FrontValue(value.projectMasterId))}">${value.projectName}</a>
									</h3>
									<div class="pbminfotech-box-desc">
										<div class="pbminfotech-box-desc-text">
											${value.description.length > 25 ? value.description.substring(0,25) +"..." : value.description}
										</div>
									</div>
									<div class="pbmit-service-btn">
										<a class="btn-arrow" href="${ResolveUrl("/Home/ProjectDetailspage/" + FrontValue(value.projectMasterId))}">Read More</a>
									</div>
								</div>
							</div>
						</div>
					</article>`;

                    strInnerHtml = strInnerHtml + strSubStr;

                });

                $('#dvProject').prepend(strInnerHtml);
                $('.project-slider').owlCarousel('destroy');
                $('.project-slider').owlCarousel({
                    loop: true,
                    autoplay: true,
                    margin: 30,
                    autoplayTimeout: 5000,
                    autoplayHoverPause: true,
                    responsiveClass: true,
                    dots: false,
                    nav: true,
                    navText: ["Prev", "Next"],
                    responsive: {
                        0: {
                            items: 1,
                            nav: false
                        },
                        600: {
                            items: 1,
                            nav: false
                        },
                        1000: {
                            items: 3,
                            nav: true,
                            dots: false,
                            loop: true
                        }
                    }
                })
            }
        }
    });
}


function BindServiceRateArea() {

    $.ajax({

        type: "POST", url: ResolveUrl("/GetServiceRate"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            var dataList = res.result;

            if (res.isError == true) {
                //ShowMessage(res.strMessage, "", "error");
                HideLoader();
            }
            else {
                var strInnerHtml = "";

                var lgLangId = $("#lgLanguageId").val();
                var readMoreText = "Read More";
                if (lgLangId == "2") {
                    readMoreText = "વધુ જુઓ";
                }
                $.each(dataList, function (data, value) {
                    var lgLangId = $("#lgLanguageId").val();
                    var strSubStr = "";
                    if (value.imagePath != null && value.imagePath != undefined && value.imagePath != '') {
                        var strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.imagePath));
                    }


                    strSubStr += `<article class="pbmit-miconheading-style-11 col-lg-3 col-md-6 pbmit-mihbox-hover-active">
					<div class="pbmit-ihbox pbmit-ihbox-style-1">
						<div class="pbmit-ihbox-box">
							<div class="pbmit-ihbox-icon">
								<div class="pbmit-ihbox-icon-wrapper">
									<i class="${value.icon}"></i>
								</div>
							</div>
							<div class="pbmit-ihbox-contents">
								<h2 class="pbmit-element-title">${value.serviceName}</h2>
								<div class="pbmit-heading-desc">${value.shortDescription.length > 25 ? value.shortDescription.substring(0, 25) + '...' : value.shortDescription}
								</div>
							</div>
							<div class="pbmit-ihbox-btn">
								<a href="${ResolveUrl("/Home/ServiceRateDetails/" + FrontValue(value.serviceRateId))}"><span>Read More</span></a>
							</div>
						</div>
					</div>
				</article>`;

                    strInnerHtml = strInnerHtml + strSubStr;

                });

                $('#divServiceRate').prepend(strInnerHtml);
                $(".active-onhover .pbmit-miconheading-style-11").mouseover(function () {
                    var main_row = $(this).closest('.active-onhover');
                    $('.pbmit-miconheading-style-11', main_row).removeClass('pbmit-mihbox-hover-active');
                    $(this).addClass('pbmit-mihbox-hover-active');
                }).mouseout(function () {
                    var main_row = $(this).closest('.active-onhover');
                    $('.pbmit-miconheading-style-11', main_row).removeClass('pbmit-mihbox-hover-active');
                    $('.pbmit-miconheading-style-11:first-child', main_row).addClass('pbmit-mihbox-hover-active');

                });
            }
        }
    });
}

function BindMedia() {
    $.ajax({
        type: "POST",
        url: ResolveUrl("/BindPhotoGalleryFirstData"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {
            if (res && res.resultList && res.pageCount > 0) {
                var strInnerHtml = "";
                res.resultList.forEach(value => {
                    var strpath = "#";
                    var strSubStr = "";
                    if (value.firstImagePath) {
                        strpath = value.firstImagePath ? ResolveUrl(`/ViewFile?fileName=${GreateHashString(value.firstImagePath)}`) : ResolveUrl("/Admin/img/noimage.png");
                    }
                    const strlink = value.id ? ResolveUrl("/PhotoGalleryDetail?" + encodeURIComponent(FrontValue(value.id))) : "#";
                    

                    strSubStr += `<article class="pbmit-portfolio-style-2">
						<div class="pbminfotech-post-content">
							<div class="pbmit-image-wrapper">
								<div class="pbmit-featured-wrapper">
									<img src="${strpath}" class="img-fluid" alt="">
								</div>
							</div>
							<div class="pbminfotech-box-content pbminfotech-overlay">
								<div class="pbminfotech-box-content-wrapper">
									<div class="pbminfotech-titlebox">
										<h3 class="pbmit-portfolio-title">
											<a href="${strlink}">${value.placeName ?? ''}</a>
										</h3>

									</div>
									<div class="pbminfotech-icon-box pbminfotech-media-link">
										<a class="pbmit-lightbox" title="Album"
										   href="${strpath}" data-fancybox="gallery">
											<i class="pbmit-base-icon-plus-symbol-button"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
                    </article>`;

                   
                    strInnerHtml = strInnerHtml + strSubStr;
                });
                $('#dvMedia').prepend(strInnerHtml);
                $('.gallery-slider').owlCarousel('destroy');
                $('.gallery-slider').owlCarousel({
                    loop: true,
                    autoplay: true,
                    autoplayTimeout: 5000,
                    margin: 30,
                    autoplayHoverPause: true,
                    responsiveClass: true,
                    dots: false,
                    nav: true,
                    navText: ["<i class='fas fa-arrow-left'></i>", "<i class='fas fa-arrow-right'></i>"],
                    responsive: {
                        0: {
                            items: 1,
                            nav: false
                        },
                        600: {
                            items: 2,
                            nav: false
                        },
                        1000: {
                            items: 4,
                            nav: false,
                            dots: false,
                            loop: true
                        }
                    }
                })
            } else {
                $(".bkMedia").hide();
            }
        },
        error: function (xhr) {
            $.handleError(this, xhr);
        }
    });
}

function BindBrandLogo() {
    $.ajax({

        type: "get", url: ResolveUrl("/GetAllBrandLogo"),
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        success: function (res) {

            var dataList = res.result;
            if (res.isError == true) {
                ShowMessage(res.strMessage, "", "error");
            }
            else {
                var strInnerHtml = "";
                document.getElementById("BrandLogos").innerHTML = "";
                $.each(dataList, function (data, value) {

                    var strSubStr = "";
                    if (value.imagePath != null && value.imagePath != undefined && value.imagePath != '') {
                        var strpath = ResolveUrl("/ViewFile?fileName=" + GreateHashString(value.imagePath));
                    }
                    else {
                        var strpath = ("#");
                    }


                    strSubStr += `<article class="pbmit-client-style-1">
							<div class="pbmit-client-wrapper pbmit-client-with-hover-img">
								<div class="pbmit-client-hover-img">
									<a href="${value.url}" target="_blank"><img src="${strpath}" class="img-fluid" alt=""></a>
								</div>
								<div class="pbmit-featured-wrapper">
									<a href="${value.url}" target="_blank"><img src="${strpath}" class="img-fluid" alt=""></a>
								</div>
							</div>
						</article>`;


                    strInnerHtml = strInnerHtml + strSubStr;

                });


                document.getElementById("BrandLogos").innerHTML = strInnerHtml;

                $('.gog-slider').owlCarousel('destroy');
                $('.gog-slider').owlCarousel({
                    loop: true,
                    autoplay: true,
                    margin: 30,
                    autoplayTimeout: 5000,
                    autoplayHoverPause: true,
                    responsiveClass: true,
                    dots: false,
                    nav: true,
                    navText: ["<i class='fas fa-arrow-left'></i>", "<i class='fas fa-arrow-right'></i>"],
                    responsive: {
                        0: {
                            items: 1,
                            nav: false
                        },
                        600: {
                            items: 2,
                            nav: false
                        },
                        1000: {
                            items: 5,
                            nav: false,
                            dots: false,
                            loop: true
                        }
                    }
                })


            }
        }
    });
}

// The AddReadMore function
function AddReadMore(slug) {
    var maxLength = 200;

    $(".show-read-more" + slug).each(function () {
        var $this = $(this);
        var myStr = $this.text().trim();

        if (myStr.length > maxLength) {
            // Find the last space within the maxLength to avoid cutting words
            var newStr = myStr.substring(0, maxLength);
            var lastSpace = newStr.lastIndexOf(' ');

            if (lastSpace > 0) {
                newStr = myStr.substring(0, lastSpace); // Trim to the last space
            }

            var removedStr = myStr.substring(newStr.length); // Remaining text

            var ellipsis = '...';
            var readMoreLink = '<a href="javascript:void(0);" class="read-more' + slug + '"><b>Read More</b></a>';

            $this.html(`
                <span class="truncated-text${slug}">${newStr}</span>
                <span class="ellipsis">${ellipsis}</span>
                <span class="more-text${slug}" style="display:none;">${removedStr}</span>
                ${readMoreLink}
            `);
        }
    });

    $(document).on("click", ".read-more" + slug, function () {
        var $this = $(this);
        var moreText = $this.prev(".more-text" + slug);
        var ellipsis = $this.prev().prev(".ellipsis");

        moreText.toggle();
        ellipsis.toggle();

        $this.html($this.html() === '<b>Read More</b>' ? '<b>Read Less</b>' : '<b>Read More</b>');
    });
}