window.SwipedPatientsPanels =
	threshold: 80
	minDeltaPercent: 0.5
	detecting: false
	started: false
	touch: undefined
	element: undefined
	coordinates:
		x: undefined
		y: undefined

	detect: (e) ->
		if e.changedTouches[0] != SwipedPatientsPanels.touch
			return

		newX = e.pageX
		newY = e.pageY

		if Math.abs(SwipedPatientsPanels.coordinates.x - newX) >= Math.abs(SwipedPatientsPanels.coordinates.y - newY)
			if Math.abs(SwipedPatientsPanels.coordinates.x - newX) < 20
				e.preventDefault()
				SwipedPatientsPanels.started = true
		
		SwipedPatientsPanels.detecting = false

	draw: (e) ->
		e.preventDefault()

		if e.changedTouches[0] != SwipedPatientsPanels.touch
			return

		newX = e.pageX

		delta = SwipedPatientsPanels.coordinates.x-newX;
		SwipedPatientsPanels.moveTo delta

	moveTo: (delta) ->
		console.log "move to", delta, this

		if delta < 0
			delta = 0

		if delta > SwipedPatientsPanels.threshold
			delta = SwipedPatientsPanels.threshold

		this.element.css
			'transform': "translate(-#{delta}px, 0)"
			'transform': "translate3d(-#{delta}px, 0, 0)"

	onTouchStart: (event) ->
		e = event.originalEvent

		SwipedPatientsPanels.element = $(this)

		if e.touches.length isnt 1 || SwipedPatientsPanels.started
			return

		SwipedPatientsPanels.detecting = true
		SwipedPatientsPanels.touch = e.changedTouches[0]
		SwipedPatientsPanels.coordinates.x = SwipedPatientsPanels.touch.pageX
		SwipedPatientsPanels.coordinates.y = SwipedPatientsPanels.touch.pageY
		$('.patients-panel').css
			'transform': "translate(0, 0)"
			'transform': "translate3d(0, 0, 0)"

	onTouchMove: (event) ->
		e = event.originalEvent

		if !SwipedPatientsPanels.started and !SwipedPatientsPanels.detecting
			return

		if SwipedPatientsPanels.detecting
			SwipedPatientsPanels.detect(e)

		if SwipedPatientsPanels.started
			SwipedPatientsPanels.draw(e)

	onTouchEnd: (event) ->
		e = event.originalEvent

		newX = e.pageX
		delta = newX - SwipedPatientsPanels.coordinates.x
		if delta < -(SwipedPatientsPanels.threshold * SwipedPatientsPanels.minDeltaPercent)
			delta = SwipedPatientsPanels.threshold
		else
			delta = 0

		SwipedPatientsPanels.moveTo delta

		SwipedPatientsPanels.started = false
		SwipedPatientsPanels.detecting = false


$ ->
	$('.patients-panel.ready-to-swipe').on 'touchstart', SwipedPatientsPanels.onTouchStart
	$('.patients-panel.ready-to-swipe').on 'touchmove', SwipedPatientsPanels.onTouchMove
	$('.patients-panel.ready-to-swipe').on 'touchend', SwipedPatientsPanels.onTouchEnd
