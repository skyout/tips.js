((factory) ->

    # Node / CommonJS
    if typeof module is 'object' and module.exports

        module.exports = factory require 'jquery'

    # AMD. Register as an anonymous module.
    else if typeof define is 'function' and define.amd

        define ['jquery'], factory

    # Browser globals
    else

        factory jQuery

) ($) ->

    # extend jquery
    $.extend

        # add tips to jquery prototype
        tips: (options) ->

            # Default settings
            settings =

                # tooltip display event
                action: 'focus'

                # debug console on
                debug: false

                # define selected element with a default of error
                element: '.error'

                # fade speed
                fadeSpeed: 200

                # enable html5 element
                html5: true

                # prevent default when element is clicked on
                preventDefault: false

                # remove all tooltip bindings
                removeAll: false

                # remove specific tooltips
                removeSpecific: false

                # width/length of the tooltip tail for positioning
                tailLength: 14

                # class to add to tooltip
                tooltipClass: ''



            # Merge default settings with options
            settings = $.extend settings, options

            # Simple debug logging function
            log = (msg) ->

                console?.info msg if settings.debug


            replaceCharacters = (txt) ->

                # array to hold location of symbols to later be replaced
                headerArray = []
                strongArray = []
                emArray = []
                liArray = []

                # split the tooltip text into an array so we can easily replace parts
                content = txt.split ""

                # for each letter in the content
                for key, val of content

                    # if ^ then push to headerArray
                    if val is '^' then headerArray.push key

                    # if * then push to strongArray
                    if val is '*' then strongArray.push key

                    # if ~ then push to emArray
                    if val is '~' then emArray.push key

                    # if ^ then push to headerArray
                    if val is '`' then liArray.push key

                    # if | then replace with <br />
                    if val is '|' then content[key] = '<br />'

                    # if { then replace with ul
                    if val is '{' then content[key] = '<ul>'

                    # if { then replace with ul
                    if val is '}' then content[key] = '</ul>'

                # while header array has 2 or more values
                while headerArray.length > 1

                    # replace first with opening h1
                    content[headerArray[0]] = '<h1>'

                    # replace second with closing h1
                    content[headerArray[1]] = '</h1>'

                    # remove those values from the array
                    headerArray.splice(0,2)

                # while strong array has 2 or more values
                while strongArray.length > 1

                    # replace first with opening strong
                    content[strongArray[0]] = '<strong>'

                    # replace second with closing strong
                    content[strongArray[1]] = '</strong>'

                    # remove those values from the array
                    strongArray.splice(0,2)

                # while em array has 2 or more values
                while emArray.length > 1

                    # replace first with opening em
                    content[emArray[0]] = '<em>'

                    # replace second with closing em
                    content[emArray[1]] = '</em>'

                    # remove those values from the array
                    emArray.splice(0,2)

                # while li array has values
                while liArray.length

                    # replace tick with li
                    content[liArray[0]] = '<li>'

                    # remove those values from the array
                    liArray.splice 0,1

                # rejoin array into a string and return
                return content.join ""

            # Show tooltips
            showTooltip = (ele) ->

                # if tooltip element
                if ele.attr('data-tooltip')

                    # remove existing tooltips
                    hideTooltip()

                    # error text
                    html = replaceCharacters ele.attr 'data-tooltip'

                    # tooltip direction
                    direction = ele.attr 'data-tooltip-direction'

                    # if html5 is set to true then use an aside otherwise use a div
                    if settings.html5 then tooltipElement = '<aside>' else tooltipElement = '<div>'

                    # append tooltip to body
                    $(tooltipElement).addClass('tooltip ' + settings.tooltipClass).html(html).appendTo 'body'

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

                    # instantiate blank variables for logging purposes
                    leftPosition = 0
                    rightPosition = 0

                    # assign tooltips based on data-tooltip-direction
                    switch direction

                        # left tooltip
                        when 'left'

                            # right position (14 px added for tail)
                            rightPosition = offset.left - tooltipWidthAdjustment - settings.tailLength

                            # center tooltip tip in element
                            topPosition = topPosition - (tooltipHeightAdjustment / 2) + (elementHeightAdjustment / 2)

                            # fade in tooltip
                            $('.tooltip:last').css(

                                left: rightPosition
                                top: topPosition

                            ).addClass('left').fadeIn settings.fadeSpeed

                        # bottom tooltip
                        when 'bottom'

                            # add adjustment for element height (14 px added for tail)
                            topPosition = offset.top + elementHeightAdjustment + settings.tailLength

                            # left position centered in element
                            leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


                            # fade in tooltip
                            $('.tooltip:last').css(

                                left: leftPosition
                                top: topPosition

                            ).addClass('bottom').fadeIn settings.fadeSpeed

                        # bottom tooltip
                        when 'top'

                            # add adjustment for element height (14 px added for tail)
                            topPosition = offset.top - tooltipHeightAdjustment - settings.tailLength

                            # left position centered in element
                            leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


                            # fade in tooltip
                            $('.tooltip:last').css(

                                left: leftPosition
                                top: topPosition

                            ).addClass('top').fadeIn settings.fadeSpeed

                        # otherwise right tooltip
                        else

                            # left position (14 px added for tail)
                            leftPosition = offset.left + elementWidthAdjustment + settings.tailLength

                            # center tooltip tip in element
                            topPosition = topPosition - (tooltipHeightAdjustment / 2) + (elementHeightAdjustment / 2)

                            # fade in tooltip
                            $('.tooltip:last').css(

                                left: leftPosition
                                top: topPosition

                            ).fadeIn settings.fadeSpeed

                    # log if debug is enabled
                    if settings.debug

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
            hideTooltip = ->

                # remove tooltip
                $('.tooltip').fadeOut settings.fadeSpeed, ->

                    $(@).remove()


            # actions
            return @ ->

                # element
                ele = settings.element

                # if unbind but not removing all
                if settings.removeSpecific and not settings.removeAll

                    # log if debug is enabled
                    log 'unbinding tooltip' if settings.debug

                    # if specified action
                    if settings.action and ele

                        switch settings.action

                            # disable click
                            when 'click'

                                $(document).off 'click.tips.cd', ele
                                $(document).off 'blur.tips.bc', ele

                            # disable hover
                            when 'hover'

                                $(document).off 'click.tips.hc', ele
                                $(document).off 'mouseenter.tips.he', ele
                                $(document).off 'mouseout.tips.ho', ele

                            # disable focus
                            else

                                $(document).off 'click.tips.fc', ele
                                $(document).off 'focus.tips.ff', ele
                                $(document).off 'blur.tips.fb', ele
                                $(document).off 'change.tips.fch', ele

                # if removing all
                if settings.removeAll

                    # log if debug is enabled
                    log 'removing all tooltip binding' if settings.debug

                    $(document).off 'click.tips'
                    $(document).off 'blur.tips'
                    $(document).off 'mouseenter.tips'
                    $(document).off 'mouseout.tips'
                    $(document).off 'change.tips'


                # otherwise enable tooltips
                if not settings.removeAll and not settings.removeSpecific

                    # switch based on user action type (click, hover, focus)
                    switch settings.action

                        # on click
                        when 'click'

                            $(document).on 'click.tips.cc', ele, (e) ->

                                #prevent default action
                                e.preventDefault() if settings.preventDefault

                                # focus on click element if it isnt an input or select box
                                if not $(@).is(':input') and not $(@).attr('tabindex') then $(@).attr('tabindex',0).focus()

                                # show tooltip
                                showTooltip($(@))

                            $(document).on 'blur.tips.bc', ele, (e) ->

                                # when element loses focus (click away, etc) remove tabindex
                                if not $(@).is(':input') and not $(@).attr('tabindex') then $(@).removeAttr 'tabindex'

                                # when element loses focus (click away, etc) hide tooltip
                                hideTooltip()


                        # on hover
                        when 'hover'

                            $(document).on 'click.tips.hc', ele, (e) ->

                                #prevent default action
                                e.preventDefault() if settings.preventDefault

                            $(document).on 'mouseenter.tips.he', ele, (e) ->

                                # when element loses focus (click away, etc) hide tooltip
                                showTooltip $(@)

                            $(document).on 'mouseout.tips.ho', ele, (e) ->

                                # when element loses focus (click away, etc) hide tooltip
                                hideTooltip()


                        # on focus
                        else

                            $(document).on 'click.tips.fc', ele, (e) ->

                                #prevent default action
                                e.preventDefault() if settings.preventDefault

                            $(document).on 'focus.tips.ff', ele, (e) ->

                                # when element loses focus (click away, etc) hide tooltip
                                showTooltip $(@)

                            $(document).on 'blur.tips.fb', ele, (e) ->

                                # when element loses focus (click away, etc) hide tooltip
                                hideTooltip()

                            $(document).on 'change.tips.fch', ele, (e) ->

                                # when element changes(select, etc) hide tooltip
                                hideTooltip()