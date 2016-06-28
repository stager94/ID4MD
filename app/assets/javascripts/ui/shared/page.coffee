window.Page =
	filterOpened: false
	onResize: ->
		console.log "resize"
		documentHeight = $(window).height()
		headerHeight   = $('.fixed-header:visible').innerHeight() || 0

		wrapperHeight = documentHeight - headerHeight
		console.log "Page resize, header height is ", headerHeight
		$(".scrollable").css
			'margin-top': headerHeight + 'px'
		return

	checkScroll: ->
		scrolled = $('.scrollable').scrollTop();
		if scrolled > 10 && Page.filterOpened == false
			$('.fixed-header').addClass 'with-border'
		else
			$('.fixed-header').removeClass 'with-border'

	device:
		ios: ->
			['iPad', 'iPhone', 'iPod'].indexOf(navigator.platform) >= 0
		mobile: ->
			/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
