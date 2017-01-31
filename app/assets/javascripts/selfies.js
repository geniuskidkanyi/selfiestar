'use strict';

var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
$(document).on('ready turbolinks:load', function () {

    $.fn.extend({
        animateCss: function animateCss(animationName) {
            var _this = this;

            var hide = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : false;

            $(this).addClass('animated ' + animationName).one(animationEnd, function (e) {
                $(_this).removeClass('animated ' + animationName);
                if (hide) $(_this).hide();
            });
        }
    });

    $('.show_lightbox').on('click', function (e) {
        e.preventDefault();
        var $selfie_id = $(this).data('selfie-id');
        var src = e.target.src;

        $('.lightbox_container_image img').attr('src', src);
        $('.lightbox').show().animateCss('fadeIn');

        $.ajax({
            type: "get",
            url: "/selfies/" + $selfie_id
        });
    });

    $('.lightbox').not($('.lightbox_container')).on('click', function (e) {
        if (e.target !== this) return;
        e.preventDefault();
        e.stopPropagation();
        $(this).animateCss('fadeOut', true);
    });
});
