# global js file
$ ->

    $.tips({

        action: 'focus'
        element: '.error'
        tooltipClass: 'error'

    })

    $.tips({

        action: 'click'
        element: '.clicktips'
        tooltipClass: 'warning'
        preventDefault: true

    })

    $.tips({

        action: 'hover'
        element: '.hover'
        preventDefault: true
        html5: false
    })