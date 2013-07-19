#= require 'libs/jquery-1.9.1.min.js'
#= require 'tips.js'

$ ->

    $('.clicktips').tips({

        action: 'click'
        class: 'warning'

    })

    $('.error').tips({

        action: 'focus'
        class: 'error'

    })