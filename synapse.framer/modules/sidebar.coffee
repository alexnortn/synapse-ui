# Sidebar Generator for Framerjs
# Alex Norton | 2016


# Framer Modules
{TextLayer} = require('TextLayer')
{ƒ,ƒƒ} = require ('findModule')
Styles = require("styles")
States = require("states")
Utils = require("utils")


# Styles
Colors = Styles.styles.colors
Typography = Styles.styles.typography

_container_sidebar = ''
_view_sidebar = ''

# Scalify
scaleFactor = 1 # Directly related to Sketch input scale --> Don't forget to update this!!!
scalify = Utils.scalify(scaleFactor)


structure = (header) ->
	# Setup --> create layers + hierarchy
	_container_sidebar = new Layer
		name: "container_sidebar_" + header
		x: 1120
		y: 0
		width: 320 # Standard sidebar width
		height: 900 # Standart sidebar height
		backgroundColor: Colors.ui.gray_5A

	_view_sidebar = new Layer
		name: "sidebar_" + header
		x: 0
		y: 0
		width: 320
		height: 900
		backgroundColor: "transparent"
		parent: _container_sidebar

	sidebar_gradient = new Layer
		name: "sidebar_gradient"
		x: 0
		y: 0
		width: 320
		height: 320 # Const
		parent: _container_sidebar

	sidebar_gradient.style.background = Colors.gradient.gray_0A75 # Tweak the opacity on this guy

	icon_name = "helper_icon_" + header

	header_icon = ƒ(icon_name).copy()	
	header_icon.parent = _container_sidebar
	header_icon.x = Align.center
	header_icon.y = 64
	header_icon.opacity = 0.75

	header_text = new TextLayer
		text: header
		name: "header"
		autoSize: true
		color: Colors.ui.gray_6
		textAlign: "center"
		textTransform: "capitalize"
		fontSize: 18
		fontWeight: "400"
		lineHeight: 1.15
		letterSpacing: 0.25
		fontFamily: "Source Sans Pro"

	header_text.parent = _container_sidebar
	header_text.x = Align.center
	header_text.y = 112


interaction = (elem_sidebar, scroll_components, sidebarViews, sidebarContainers, synapse) ->

	# Populate our App global interaction elements
	sidebarViews.push(_view_sidebar)
	sidebarContainers.push(elem_sidebar)

	# Announcements scroll component
	sidebar = ScrollComponent.wrap(elem_sidebar)
	sidebar.height = scalify(sidebar.height)
	sidebar.scrollHorizontal = false
	sidebar.propagateEvents = false

	scroll_components.push(sidebar)

	# Setup animation states
	States.setupSlideOnce( sidebarContainers[ sidebarContainers.length-1 ], synapse.container_sidebar_overview.width)
	States.setupFade(sidebarViews)


section = (container, name) ->
	# If any other sections exist in <this> container..
	sections = container.ƒƒ('section*')
	max_y = 160 # From Sketch

	if sections.length
		for section in sections
			if section.y >= max_y
				max_y = section.y + section.height
	
	section = new Layer
		name: "section_" + name
		x: 0
		y: max_y
		backgroundColor: "transparent"
		parent: container

	section.width = section.parent.width
	section.height = 160

	section.style.borderTop = "1px solid #262A33"

	sectionHeader = new TextLayer
		text: name
		name: "header"
		autoSize: true
		color: Colors.ui.gray_5
		textAlign: "left"
		textTransform: "uppercase"
		fontSize: 10
		fontWeight: 600
		lineHeight: 1.15
		letterSpacing: 0.75
		fontFamily: "Source Sans Pro"

	sectionHeader.parent = section
	sectionHeader.x = 20
	sectionHeader.y = 14


# Execute methods
Generate = 
	structure: structure
	section: section
	interaction: interaction

# Module Exports ------------------------------------------------------

exports.Generate = Generate







