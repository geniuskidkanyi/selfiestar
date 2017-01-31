const animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
$(document).on('ready turbolinks:load', function() {

    $.fn.extend({
        animateCss(animationName, hide = false) {
            $(this).addClass(`animated ${animationName}`).one(animationEnd, e => {
                $(this).removeClass('animated ' + animationName)
                if (hide) $(this).hide()
            });
        }
    });


    $('.show_lightbox').on('click', function(e) {
        e.preventDefault();
        let $selfie_id = $(this).data('selfie-id');
        let src = e.target.src

        $('.lightbox_container_image img').attr('src', src)
         $('.lightbox').show().animateCss('fadeIn')

        $.ajax({
            type: "get",
            url: "/selfies/" + $selfie_id
        });
    })

    $('.lightbox').not($('.lightbox_container')).on('click', function(e) {
        if (e.target !== this) return
        e.preventDefault()
        e.stopPropagation()
        $(this).animateCss('fadeOut', true)
    })
})
