#= require '../js/libs/jquery-1.9.1.min.js'
#= require 'tips.js'

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

    })