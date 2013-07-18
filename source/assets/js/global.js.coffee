#= require 'libs/jquery-1.9.1.min.js'
#= require 'tips.js'

$ ->

    $('[data-tooltip]').tips();

#     # error tooltip

#     # To implement tooltip, add an attribute of [data-error] with the tooltip message
#     # Tooltip will be shown when the element has focus and has a class of error
#     # To control direction ad an attribute of [data-position] specificing left or bottom, if left off then the default is right

#     $("body").on(

#         focusin: ->

#             if $(this).hasClass("error") || $(this).hasClass("vc-error")

#                 # error text
#                 html = $(this).attr("data-tooltip")

#                 # tooltip direction
#                 direction = $(this).attr("data-tooltip-position")

#                 # append tooltip to body
#                 $("<aside>").addClass("tooltip error").html(html).appendTo "body"

#                 # element width and height
#                 elementWidthAdjustment = $(this).outerWidth()
#                 elementHeightAdjustment = $(this).outerHeight()

#                 # tooltip width
#                 tooltipWidthAdjustment = $(".tooltip.error:last").outerWidth()

#                 # offset position
#                 offset = $(this).offset()

#                 # top position
#                 topPosition = offset.top


#                 switch direction

#                     # left tooltip
#                     when 'left'

#                         # right position (14 px added for tail)
#                         rightPosition = offset.left - tooltipWidthAdjustment - 14

#                         $(".tooltip.error:last").css(

#                             left: rightPosition
#                             top: topPosition

#                         ).addClass('left').fadeIn "fast"

#                     # bottom tooltip
#                     when 'bottom'

#                         # add adjustment for element height (14 px added for tail)
#                         topPosition = offset.top + elementHeightAdjustment + 14

#                         # left position (14 px added for tail)
#                         leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


#                         $(".tooltip.error:last").css(

#                             left: leftPosition
#                             top: topPosition

#                         ).addClass('bottom').fadeIn "fast"

#                     # bottom tooltip
#                     when 'top'

#                         # add adjustment for element height (14 px added for tail)
#                         topPosition = offset.top - elementHeightAdjustment - 14

#                         # left position (14 px added for tail)
#                         leftPosition = offset.left + (elementWidthAdjustment / 2) - (tooltipWidthAdjustment / 2)


#                         $(".tooltip.error:last").css(

#                             left: leftPosition
#                             top: topPosition

#                         ).addClass('top').fadeIn "fast"

#                     # otherwise right tooltip
#                     else

#                         # left position (14 px added for tail)
#                         leftPosition = offset.left + elementWidthAdjustment + 14

#                         $(".tooltip.error:last").css(

#                             left: leftPosition
#                             top: topPosition

#                         ).fadeIn "fast"




#         focusout: ->

#             if $(this).hasClass("error") || $(this).hasClass("vc-error")

#                 $(".tooltip").fadeOut "fast", ->

#                     $(this).remove()

#     , "[data-tooltip]")