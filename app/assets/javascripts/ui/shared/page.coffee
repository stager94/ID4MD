window.Page =
	onResize: ->
		console.log "resize"
		documentHeight = $(window).height()
		headerHeight   = $('.fixed-header').innerHeight()

		wrapperHeight = documentHeight - headerHeight

		$(".scrollable").css
			'margin-top': headerHeight + 'px'
		return

	checkScroll: ->
		scrolled = $('.scrollable').scrollTop();
		if scrolled > 10
			$('.fixed-header').addClass 'with-border'
		else
			$('.fixed-header').removeClass 'with-border'
