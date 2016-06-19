window.PatientsPanels =
	onClick: (event) ->
		console.log "PatientsPanels", "click"
		e = event.originalEvent
		if SwipedPatientsPanels.delta > 0
			SwipedPatientsPanels.delta = 0
		else
			$(e.target).closest(SwipedPatientsPanels.panelsSelector).toggleClass "opened"

window.SwipedPatientsPanels =
	panelsSelector: ".patients-panel"
	actionsSelector: ".actions"
	actionSelector: ".patients-panel .actions a"
	threshold: 80
	minDeltaPercent: 0.5
	detecting: false
	started: false
	touch: undefined
	element: undefined
	clickDisabled: false
	delta: 0
	coordinates:
		x: undefined
		y: undefined

	minSwipeDistance: ->
		this.threshold * this.minDeltaPercent

	detect: (e) ->
		newX = e.pageX
		newY = e.pageY

		if Math.abs(SwipedPatientsPanels.coordinates.x - newX) >= Math.abs(SwipedPatientsPanels.coordinates.y - newY)
			e.preventDefault()
			SwipedPatientsPanels.started = true
		
		SwipedPatientsPanels.detecting = false

	draw: (e) ->
		e.preventDefault()

		newX = e.pageX
		delta = SwipedPatientsPanels.coordinates.x-newX

		SwipedPatientsPanels.moveTo delta

	moveTo: (delta) ->
		if SwipedPatientsPanels.element == undefined
			return

		if delta < 0
			delta = 0

		if delta > SwipedPatientsPanels.threshold
			delta = SwipedPatientsPanels.threshold

		SwipedPatientsPanels.delta = delta
		SwipedPatientsPanels.element.css
			'transform': "translate(-#{delta}px, 0)"
			'transform': "translate3d(-#{delta}px, 0, 0)"

	closeAllPanels: ->
		SwipedPatientsPanels.moveTo 0
		this.element = undefined
		SwipedPatientsPanels.started = false
		SwipedPatientsPanels.detecting = false

	# ============
	# Touch events
	# ============
	onTouchStart: (event) ->
		if Page.device.mobile()
			$(document).on 'touchmove', SwipedPatientsPanels.onTouchMove
		else
			$(document).on 'mousemove', SwipedPatientsPanels.onTouchMove
	
		e = event.originalEvent
	
		if $(e.target).parents(SwipedPatientsPanels.actionsSelector).length > 0
			return

		SwipedPatientsPanels.element = $(e.target).closest(SwipedPatientsPanels.panelsSelector)

		SwipedPatientsPanels.detecting = true
		SwipedPatientsPanels.coordinates.x = e.pageX
		SwipedPatientsPanels.coordinates.y = e.pageY
		$(SwipedPatientsPanels.panelsSelector).css
			'transform': "translate(0, 0)"
			'transform': "translate3d(0, 0, 0)"

	onTouchMove: (event) ->

		if SwipedPatientsPanels.started == true and SwipedPatientsPanels.clickDisabled == false
			SwipedPatientsPanels.clickDisabled = true
			$(SwipedPatientsPanels.panelsSelector).off 'click', PatientsPanels.onClick

		e = event.originalEvent

		if !SwipedPatientsPanels.started and !SwipedPatientsPanels.detecting
			return

		if SwipedPatientsPanels.element.hasClass("opened")
			return

		if SwipedPatientsPanels.detecting
			SwipedPatientsPanels.detect(e)

		if SwipedPatientsPanels.started
			SwipedPatientsPanels.draw(e)

	onTouchEnd: (event) ->
		$(document).off 'mousemove touchmove', this.onTouchMove
		# Allow clicking on Patient panel
		if SwipedPatientsPanels.clickDisabled
			SwipedPatientsPanels.clickDisabled = false
			setTimeout -> 
				$(SwipedPatientsPanels.panelsSelector).on 'click', PatientsPanels.onClick
			SwipedPatientsPanels.finishMoving event
			

	finishMoving: (event) ->
		e = event.originalEvent

		if $(e.target).parents(SwipedPatientsPanels.actionsSelector).length > 0
			return

		newX = e.pageX
		delta = newX - SwipedPatientsPanels.coordinates.x
		
		if delta < -(SwipedPatientsPanels.minSwipeDistance())
			delta = SwipedPatientsPanels.threshold
		else
			delta = 0

		if delta == 0
			SwipedPatientsPanels.clickDisabled = false


		if !SwipedPatientsPanels.element.hasClass("opened")
			SwipedPatientsPanels.moveTo delta

		SwipedPatientsPanels.element = undefined
		SwipedPatientsPanels.started = false
		SwipedPatientsPanels.detecting = false
	#

	initialize: ->
		if Page.device.mobile()
			$(this.panelsSelector).on 'touchstart', this.onTouchStart
			$(document).on 'touchend', this.onTouchEnd
		else
			$(this.panelsSelector).on 'mousedown', this.onTouchStart
			$(document).on 'mouseup', this.onTouchEnd

		$(this.actionSelector).off 'click', this.closeAllPanels
		$(this.panelsSelector).off 'click', PatientsPanels.onClick

		$(this.actionSelector).on 'click', this.closeAllPanels
		$(this.panelsSelector).on 'click', PatientsPanels.onClick
