jQuery ($) ->

  class _FrontendNotifier
    
    constructor: () ->
      @block   = $("#frontend_notification")
      @message = $(".message", @block)
      @timer   = $(".closingCounter .number", @block)
      @update_timer = () =>
        unless @stop_timer
          if @timer.text() != "1"
            @timer.text (@timer.text() - 1)
            setTimeout @update_timer, 1000
          else
            this.close()
      $("#close_notification_ico").click () =>
        @stop_timer = true
        this.close()

    show: (message, type) ->
      unless typeof(message) == "string"
        type    = message.type
        message = message.message
      @block.removeClass("error").removeClass("success").addClass(type)
      @timer.text 5
      @message.html(message)
      @block.show()
      @current_timestamp = new Date().getTime()
      this.start_timer(@current_timestamp)

    show_error: () ->
      this.show $("#frontend_notification_error500").text(), "error"

    close: () ->
      @block.slideUp(300)

    start_timer: (timestamp) ->
      @stop_timer = false
      setTimeout () =>
        @update_timer() if timestamp == @current_timestamp
      ,1000

  window.FrontendNotifier = new _FrontendNotifier
  if $("#frontend_notification_content span").size() > 0
    FrontendNotifier.show $("#frontend_notification_content span").text(), $("#frontend_notification_content span").attr("class")
