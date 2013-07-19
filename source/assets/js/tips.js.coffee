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

            # tooltip display event
            action: 'focus'

            # class to add to tooltip
            class: null

            # debug console on
            debug: false

            # prevent default on click
            preventDefault: true

            # width/length of tooltip tail
            tailLength: 14


        # Merge default settings with options.
        settings = $.extend settings, options

        # Simple logger.
        log = (msg) ->

            console?.info msg if settings.debug

        # Show tooltips
        showTooltip = (ele) ->

            hideTooltip()

            # error text
            html = ele.attr('data-tooltip')

            # tooltip direction
            direction = ele.attr('data-tooltip-direction')

            # append tooltip to body
            $('<aside>').addClass('tooltip ' + settings.class).html(html).appendTo 'body'

            # element width and height
            elementWidthAdjustment = ele.outerWidth()
            elementHeightAdjustment = ele.outerHeight()

            # tooltip width
            tooltipWidthAdjustment = $('.tooltip:last').outerWidth()
            tooltipHeightAdjustment = $('.tooltip:last').outerHeight()

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
                    rightPosition = offset.left - tooltipWidthAdjustment - settings.tailLength

                    $('.tooltip:last').css(

                        left: rightPosition
                        top: topPosition

                    ).addClass('left').fadeIn 'fast'

                # bottom tooltip
                when 'bottom'

                    # add adjustment for element height (14 px added for tail)
                    topPosition = offset.top + elementHeightAdjustment + settings.tailLength

                    # left position (14 px added for tail)
                    leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


                    $('.tooltip:last').css(

                        left: leftPosition
                        top: topPosition

                    ).addClass('bottom').fadeIn 'fast'

                # bottom tooltip
                when 'top'

                    # add adjustment for element height (14 px added for tail)
                    topPosition = offset.top - tooltipHeightAdjustment - settings.tailLength

                    # left position (14 px added for tail)
                    leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


                    $('.tooltip:last').css(

                        left: leftPosition
                        top: topPosition

                    ).addClass('top').fadeIn 'fast'

                # otherwise right tooltip
                else

                    # left position (14 px added for tail)
                    leftPosition = offset.left + elementWidthAdjustment + settings.tailLength

                    $('.tooltip:last').css(

                        left: leftPosition
                        top: topPosition

                    ).fadeIn 'fast'

            # logging

            # log tooltip text
            log 'Tooltip Content: ' + html

            # log element width
            log 'Element Width: ' + elementWidthAdjustment if elementWidthAdjustment

            # log element height
            log 'Element Height: ' + elementHeightAdjustment if elementHeightAdjustment

            # log top position
            log 'Element Top Position: ' + topPosition if topPosition

            # log left position
            log 'Element Left Position: ' + leftPosition if leftPosition

            # log right position
            log 'Element Right Position: ' + rightPosition if rightPosition

            # tooltip width
            log 'Tooltip Width: ' + tooltipWidthAdjustment if tooltipWidthAdjustment

            # tooltip height
            log 'Tooltip Height: ' + tooltipHeightAdjustment if tooltipHeightAdjustment

        # hide tooltips
        hideTooltip = () ->

            # remove tooltip
            $('.tooltip').fadeOut 'fast', ->

                $(@).remove()


        # Logic
        return @each () ->

            # switch based on user action type (click, hover, focus)
            switch settings.action

                # on click
                when 'click'

                    $(@).on(

                        click: (e) ->

                            # prevent default action
                            e.preventDefault() if settings.preventDefault

                            # focus on click element
                            $(@).attr('tabindex',0).focus()

                            # show tooltip
                            showTooltip($(@))

                        focusout: () ->

                            # when element loses focus (click away, etc) remove tabindex
                            $(@).removeAttr('tabindex')

                            # hide tooltip
                            hideTooltip()

                    )

                # on hover
                when 'hover'

                    $(@).on(

                        mouseover: () ->

                            # show tooltip
                            showTooltip($(@))

                        mouseout: () ->

                            # hide tooltip
                            hideTooltip()

                    )

                # on focus
                else

                    $(@).on(

                        focusin: () ->

                            # show tooltip
                            showTooltip($(@))

                        focusout: () ->

                            # hide tooltip
                            hideTooltip()

                    )