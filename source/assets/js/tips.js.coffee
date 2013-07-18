#   tips.js
#   jQuery tooltip plugin (https://github.com/slanningGH/tips.js)
#   version 0.1

# Reference jQuery
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend

    # Change pluginName to your plugin's name.
    tips: (options) ->

        # Default settings
        settings =
            action: 'focus'
            debug: false

        # Merge default settings with options.
        settings = $.extend settings, options

        # Simple logger.
        log = (msg) ->

            console?.log msg if settings.debug

        # Show tooltips
        showTooltip = (ele) ->

            # error text
            html = ele.attr("data-tooltip")

            # tooltip direction
            direction = ele.attr("data-tooltip-direction")

            # append tooltip to body
            $("<aside>").addClass("tooltip error").html(html).appendTo "body"

            # element width and height
            elementWidthAdjustment = ele.outerWidth()
            elementHeightAdjustment = ele.outerHeight()

            # tooltip width
            tooltipWidthAdjustment = $(".tooltip.error:last").outerWidth()

            # offset position
            offset = ele.offset()

            # top position
            topPosition = offset.top

            # instantiate blank variables for loggin purposes
            leftPosition = 0
            rightPosition = 0

            # assign tooltips based on data-tooltip-direction
            switch direction

                # left tooltip
                when 'left'

                    # right position (14 px added for tail)
                    rightPosition = offset.left - tooltipWidthAdjustment - 14

                    $(".tooltip.error:last").css(

                        left: rightPosition
                        top: topPosition

                    ).addClass('left').fadeIn "fast"

                # bottom tooltip
                when 'bottom'

                    # add adjustment for element height (14 px added for tail)
                    topPosition = offset.top + elementHeightAdjustment + 14

                    # left position (14 px added for tail)
                    leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


                    $(".tooltip.error:last").css(

                        left: leftPosition
                        top: topPosition

                    ).addClass('bottom').fadeIn "fast"

                # bottom tooltip
                when 'top'

                    # add adjustment for element height (14 px added for tail)
                    topPosition = offset.top - elementHeightAdjustment - 14

                    # left position (14 px added for tail)
                    leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


                    $(".tooltip.error:last").css(

                        left: leftPosition
                        top: topPosition

                    ).addClass('top').fadeIn "fast"

                # otherwise right tooltip
                else

                    # left position (14 px added for tail)
                    leftPosition = offset.left + elementWidthAdjustment + 14

                    $(".tooltip.error:last").css(

                        left: leftPosition
                        top: topPosition

                    ).fadeIn "fast"

            # logging

            # log tooltip text
            log 'Tooltip Content: ' + html

            # log element width
            log 'Element Width: ' + elementWidthAdjustment

            # log element height
            log 'Element Height: ' + elementHeightAdjustment

            # log top position
            log 'Element Top Position: ' + topPosition if topPosition

            # log left position
            log 'Element Left Position: ' + leftPosition if leftPosition

            # log right position
            log 'Element Right Position: ' + rightPosition if rightPosition

        # hide tooltips
        hideTooltip = () ->

            # remove tooltip
            $(".tooltip").fadeOut "fast", ->

                $(@).remove()


        # Logic
        return @each () ->

            switch settings.action

                when 'click'

                    $('body, html').on(

                        click: (e) ->

                            if $(e.target).closest('[data-tooltip]').length

                                showTooltip($(e.target).closest('[data-tooltip]'))

                            else

                                hideTooltip()

                    )

                when 'hover'

                    $(@).on(

                        mouseover: () ->

                            showTooltip($(@))

                        mouseout: () ->

                            hideTooltip()

                    )

                else

                    $(@).on(

                        focusin: () ->

                            showTooltip($(@))

                        focusout: () ->

                            hideTooltip()

                    )