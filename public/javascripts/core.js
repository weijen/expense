$(document).ready(function() {
    /* stickies */
    $('#stickies .stickies_close_area a')
        .click(function() {
            $(this).parent().parent().fadeOut('slow');
            return false;
        });

    /* form */
    $('.form .field')
        .click(function() {
            $(this)
                .parents('li').addClass('focused')
                .siblings('li').removeClass('focused');
        })
        .focus(function() {
            $(this)
                .parents('li').addClass('focused')
                .siblings('li').removeClass('focused');
        })
        .blur(function() {
            $(this).parents('li').removeClass('focused');
        });
});