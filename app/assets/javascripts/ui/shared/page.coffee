window.Page =
	onResize: ->
		console.log "resize"
		documentHeight = $(window).height()
		$(".mobile-wrapper").css('max-height', documentHeight + 'px')
		return
