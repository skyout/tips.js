(function($){

    // focus tooltips on .error
    $.tips({
        action: 'focus',
        element: '.error',
        tooltipClass: 'error'
    });

    // click tooltips on .clicktips
    $.tips({
    action: 'click',
    element: '.clicktips',
    tooltipClass: 'warning',
    preventDefault: true
    });

    // hover tooltip with html5 disabled
    return $.tips({
        action: 'hover',
        element: '.hover',
        preventDefault: true,
        html5: false
    });

})(jQuery);