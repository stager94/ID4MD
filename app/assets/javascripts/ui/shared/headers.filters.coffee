window.HeadersFilters =
	closeMenus: (event) ->
		if event != undefined
			if event.which == 3
				return

			$target = $(event.target)
			if $target.parents('ul.opened').length > 0 || $target.hasClass 'opened'
				return

		$('.header-filters ul').removeClass 'opened'
		$(document).unbind 'click touchstart', HeadersFilters.closeMenus

	showMenuFor: ($header) ->
		$header.find('ul').addClass 'opened'
		$(document).on 'click touchstart', HeadersFilters.closeMenus

	changeCurrentFilter: ($header, $newFilter) ->
		$header.find("div > span").text $newFilter.text()
		$("li", $header).removeClass "active"
		$newFilter.closest("li").addClass "active"
		HeadersFilters.closeMenus()

$ ->
	$(document).delegate '.header-filters > div', 'click', ->
		$header = $(this).closest '.header-filters'
		HeadersFilters.showMenuFor $header

	$(document).delegate '.header-filters ul.filter-variants li a', 'click', ->
		$header = $(this).closest '.header-filters'
		HeadersFilters.changeCurrentFilter $header, $(this)
