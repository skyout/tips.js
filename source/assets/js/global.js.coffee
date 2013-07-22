#= require '../js/libs/jquery-1.9.1.min.js'
#= require 'tips.js'

$ ->

    $('.clicktips').tips({

        action: 'click'
        preventDefault: true
        tooltipClass: 'warning'

    })

    $('.error').tips({

        action: 'focus'
        tooltipClass: 'error'

    })

    $('.hover').tips({

        action: 'hover'
        preventDefault: true

    })