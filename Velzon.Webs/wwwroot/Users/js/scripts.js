
"use strict";

/*-------------------------------------
    Animation on scroll: Number rotator
-------------------------------------*/



/*-------------------------------------
  Sticky header wrapper
  -------------------------------------*/
// if (jQuery('.site-header-menu-wrapper').length == 0) {
//   jQuery('.site-header-menu').wrap('<div class="site-header-menu-wrapper"></div>');
// }
// jQuery('.site-header-menu-wrapper').height(jQuery('.site-header-menu-wrapper').height()).css('margin-bottom', jQuery('.site-header-menu').css('margin-bottom'));

// jQuery(window).resize(function () {
//   if (jQuery(window).width() < 1200) {
//     jQuery('.site-header-menu-wrapper').css('height', '');
//     jQuery('.site-header-menu-wrapper').css('margin-bottom', '');
//   } else {
//     jQuery('.site-header-menu-wrapper').height(jQuery('.site-header-menu-wrapper').height()).css('margin-bottom', jQuery('.site-header-menu').css('margin-bottom'));
//   }

// });


/*-------------------------------------
Swiper Slider
-------------------------------------*/

/*-------------------------------------
ProgressBar
-------------------------------------*/

/*-------------------------------------
Scroll To Top
-------------------------------------*/
jQuery('body').append('<a href="#" class="scroll-to-top"><i class="pbmit-base-icon-arrow-right"></i></a>');
var btn = jQuery('.scroll-to-top');
jQuery(window).scroll(function () {
  if (jQuery(window).scrollTop() > 300) {
    btn.addClass('show');
  } else {
    btn.removeClass('show');
  }
});
btn.on('click', function (e) {
  e.preventDefault();
  jQuery('html, body').animate({ scrollTop: 0 }, '300');
});

/*-------------------------------------
Header Search Form
-------------------------------------*/
$(".pbmit-header-search-btn a").on('click', function () {
  $(".pbmit-search-overlay").addClass('st-show');
  $("body").addClass('st-prevent-scroll');
  return false;
});
$(".pbmit-icon-close").on('click', function () {
  $(".pbmit-search-overlay").removeClass('st-show');
  $("body").removeClass('st-prevent-scroll');
  return false;
});
$('.pbmit-site-searchform').on('click', function (event) {
  event.stopPropagation();
});

/*-------------------------------------
    tooltip
  -------------------------------------*/
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})
/*-------------------------------------
Magnific Popup
-------------------------------------*/


/*-------------------------------------
 Accordion
-------------------------------------*/

$('.accordion .accordion-item').on('click', function () {
  var e = $(this);
  $(this).parent().find('.accordion-item').removeClass('active');
  if (!$(this).find('.accordion-button').hasClass('collapsed')) {
    $(this).addClass('active');
  }
});

/*-------------------------------------
Tab
-------------------------------------*/

$('.nav-tabs  .nav-item').on('click', function () {
  $(this).parent().find('.tabactive').removeClass('tabactive');
  $(this).addClass('tabactive');
});



/*-------------------------------------
  Add plus icon in menu
  -------------------------------------*/
$(".main-menu ul.navigation li.dropdown").append("<span class='righticon'><i class='ti-angle-down'></i></span>");

/*-------------------------------------
Responsive Menu
-------------------------------------*/
$('.main-menu ul.navigation li.dropdown .righticon').on('click', function () {
  $(this).siblings().toggleClass('open');
  $(this).find('i').toggleClass('ti-angle-down ti-angle-up');
  return false;
});

/*-------------------------------------
    Mobile Menu
  -------------------------------------*/
$('.navbar-toggler,.closepanel').on('click', function () {
  $("header").toggleClass("active");
});

/*-------------------------------------
Sticky Header
-------------------------------------*/
$(window).scroll(function () {
  var sticky = $('.site-header-menu'),
    scroll = $(window).scrollTop();
  if (scroll >= 150) sticky.addClass('sticky-header');
  else sticky.removeClass('sticky-header');
});

/*-------------------------------------
Circle Progressbar
-------------------------------------*/

/*=============================================
= gallery slider =
=============================================*/
$(document).ready(function () {
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
});
/*=============================================
= gallery slider =
=============================================*/
/*=============================================
= Banner slider =
=============================================*/
function initializeBannerOwlCarousel(selector, options = {}) {
    if ($(selector).length > 0) {
        const defaultOptions = {
            loop: true,
            autoplay: true,
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
                    items: 1,
                    nav: false
                },
                1000: {
                    items: 1,
                    nav: true,
                    dots: false,
                    loop: true
                }
            }
        };
        const settings = $.extend(true, {}, defaultOptions, options);
        $(selector).owlCarousel(settings);
    } else {
        console.log(`Class ${selector} does not exist for initializeBannerOwlCarousel.`);
    }
}
// Ensure the function is accessible globally
window.initializeBannerOwlCarousel = initializeBannerOwlCarousel;
/*=============================================
= Banner slider =
=============================================*/
$(document).ready(function () {
  $('.project-slider').owlCarousel({
    loop: true,
    autoplay: true,
    margin: 30,
    autoplayTimeout: 5000,
    autoplayHoverPause: true,
    responsiveClass: true,
    dots: false,
    nav: true,
    navText: ["Next", "Prev"],
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
});
/*=============================================
= important main web images slider =
=============================================*/
$(document).ready(function () {
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
});
/*-------------------------------------
 Send email via Ajax
Make sure you configure send.php file 
 -------------------------------------*/


/*-------------------------------------
 Stretched Div
 -------------------------------------*/
var document_width = $(document).width();
function pbmit_col_stretched() {
  $('.pbmit-col-stretched-yes').each(function () {
    var this_ele = $(this);
    var window_width = jQuery(window).width();
    var main_width = $('.container').width();
    var extra_width = ((window_width - main_width) / 2);
    if (window_width < 1200) {
      extra_width = 0;
    }
    if (this_ele.hasClass('pbmit-col-right')) {
      $('.pbmit-col-stretched-right', this_ele).css('margin-right', '-' + extra_width + 'px');
    } else {
      $('.pbmit-col-stretched-left', this_ele).css('margin-left', '-' + extra_width + 'px');
    }
  });
}
$(window).resize(function () {
  pbmit_col_stretched();
});
pbmit_col_stretched();

/*-------------------------------------
Count Down
-------------------------------------*/
$(".active-onhover .pbmit-miconheading-style-11:first-child,.pbmit-miconheading-style-11:first-child").addClass('pbmit-mihbox-hover-active');

$(".active-onhover .pbmit-miconheading-style-11").mouseover(function () {
  var main_row = $(this).closest('.active-onhover');
  $('.pbmit-miconheading-style-11', main_row).removeClass('pbmit-mihbox-hover-active');
  $(this).addClass('pbmit-mihbox-hover-active');
}).mouseout(function () {
  var main_row = $(this).closest('.active-onhover');
  $('.pbmit-miconheading-style-11', main_row).removeClass('pbmit-mihbox-hover-active');
  $('.pbmit-miconheading-style-11:first-child', main_row).addClass('pbmit-mihbox-hover-active');

});

$(window).on("load", function (event) {
    $(".js-preloader").delay(800).fadeOut(500);
});