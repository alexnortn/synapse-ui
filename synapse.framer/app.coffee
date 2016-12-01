# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info
# 2016 Alex Norton, for Eyewire + Seung Lab

Framer.Info =
	title: "Synapse Design Prototypes"
	author: "alex norton"
	twitter: "@alexnortn"
	description: "Prototypes for Neo Game"


# Framer Modules
ViewController = require('ViewController')
{ƒ,ƒƒ} = require 'findModule'

# NPM Modules
# overview = require("npm").overview

# My Modules
Overview = require("overview")
States = require("states")
Utils = require("utils") 


# Define and set custom device 
Framer.Device.deviceType = "desktop-safari-1440-900"
Framer.Device.background.backgroundColor = "#181A1E"
synapseParameters =
	size: 
		width: 1440
		height: 900


# Use desktop cursor
document.body.style.cursor = "auto"


# Import file "SynapseDesign_V2"
synapse = Framer.Importer.load("imported/SynapseDesign_V2@1x")


# Setup Globals
# --------------------------------------------------------------------------------

# Navbar Elements 
navbarTiles = synapse.container_view_navbar.childrenWithName("view_navbar")[0].childrenWithName("tiles")[0]
navbarIcons = synapse.container_view_navbar.childrenWithName("view_navbar")[0].childrenWithName("icons")[0]
navbarActive = synapse.container_view_navbar.childrenWithName("view_navbar")[0].childrenWithName("active")[0]

# Chat Elements
chatElement = synapse.container_view_chat

# SidebarState Handler
SidebarState = 
	current_view: "overview"
	open: true

# Regex Helpers
regAfter  = /[^_]*$/g 		# regex for matching string after "_"
regBefore = /^([^_]+)/g		# regex for matching string before "_"
prefix = 
	view:		"view_"
	sidebar: 	"sidebar_"
	active: 	"active_"
	icon: 		"icon_"
	tile: 		"tile_"

sidebarViews = []
sidebarContainers = []


# Setup Scroll Components
# --------------------------------------------------------------------------------

# Overview scroll component
scroll_overview = ScrollComponent.wrap(synapse.container_sidebar_overview)
scroll_overview.scrollHorizontal = false
scroll_overview.propagateEvents = false


# Leaderboard scroll component
scroll_leaderboard = ScrollComponent.wrap(synapse.container_sidebar_leaderboard)
scroll_leaderboard.scrollHorizontal = false
scroll_leaderboard.propagateEvents = false

scroll_components = [ scroll_overview, scroll_leaderboard ]


# Setup States
# --------------------------------------------------------------------------------

# Initially hide select elements
# synapse.container_sidebar_leaderboard.visible = false
navbarActive.childrenWithName('active_leaderboard')[0].opacity = 0
navbarActive.childrenWithName('active_overview')[0].opacity = 0 

for child in navbarTiles.subLayers
	child.opacity = 0


# Setup Chat States
activeChatElements = []
activeChatElements.push(ƒ('view_chat_activity'))
activeChatElements.push(ƒ('view_chat_scrollbar'))

States.setupFade(activeChatElements)


# Setup Sidebar States
setupSidebar = (comp) -> 
	# Swap Views
	for name, child of comp
		matchBefore = (child.name).match(regBefore)[0]
		matchAfter = (child.name).match(regAfter)[0]

		if ( matchBefore == "sidebar" )
			sidebarViews.push(child)
			sidebarContainers.push(child.parent.parent)

	sidebarContainers.push(synapse.container_view_navbar) # Add Navbar
	sidebarContainers.push(synapse.container_helper_sidebar_bg) # Add Sidebar BG

	States.setupSlide(sidebarContainers, synapse.container_sidebar_overview.width)
	States.setupFade(sidebarViews)

setupSidebar(synapse)


# Initialize element states
# Pass in reference to @Sketch Imported layers
States.setupFade(navbarTiles.subLayers)
States.setupFade(navbarIcons.subLayers)
States.setupFade(navbarActive.subLayers)


# Setup initial Active SidebarState 
activeTile = navbarTiles.childrenWithName('tile_overview')[0].name
navbarIcons.childrenWithName('icon_overview')[0].stateSwitch('transparent')
navbarTiles.childrenWithName('tile_overview')[0].stateSwitch('visible')
navbarActive.childrenWithName('active_overview')[0].stateSwitch('visible')


# Animate N layers together with similar properties 
animateLayer = (layer, state) ->
	layer.animate(state)


# Event Handlers
# --------------------------------------------------------------------------------

# Sidebar MouseOver Interaction
for child in navbarTiles.subLayers
	child.on Events.MouseOver, (event, layer) ->
		for other in navbarTiles.subLayers
			if (other.name != activeTile)
				other.animate('transparent') # Fadeout all other tiles
		layer.stateSwitch('transparent')
		layer.animate('visible')
		layer.on Events.MouseOut, (event, layer2) ->
			if (layer2.name != activeTile) # Maintain highlight state
				layer2.animate('transparent')

# Sidebar Click Interaction
for child in navbarTiles.subLayers
	child.on Events.Click, (event, layer) ->
		layerAfter = (layer.name).match(regAfter)[0]
		# if Open, Close Sidebar
		if (SidebarState.current_view == layerAfter || !SidebarState.open)
			animation = ""

			if ( SidebarState.open )
				animation = "close"

				# Update current Icons + Active Icons
				currentIcon = "icon_" + SidebarState.current_view
				currentActive = "active_" + SidebarState.current_view

				# Swap Icon --> >> -> [ ]
				navbarActive.childrenWithName(currentActive)[0].animate('transparent')
				navbarIcons.childrenWithName(currentIcon)[0].animate('visible')
				
				for tile in navbarTiles.subLayers
					tile.animate('transparent') # Fadeout all other tiles
			else
				animation = "open"

			SidebarState.open = !SidebarState.open
			for layer in sidebarContainers # Toggle Open/Close containers
				animateLayer(layer, animation)

		changeView(layerAfter, synapse)

		for other in navbarTiles.subLayers
			if (other.name != activeTile) # Maintain highlight state
				other.animate('transparent') # Fadeout all other tiles

# Chat Click Interaction
chatElement.on Events.Click, (event, layer) ->
	for elem in activeChatElements
		elem.stateCycle()

# View Controller
# --------------------------------------------------------------------------------

# Generalized to work with any similarly named Sketch file structure 
changeView = (layerCurrent, comp) -> 

	# Only continue for supported states
	noMatch = true

	for name, child of comp
		matchBefore = (child.name).match(regBefore)[0]
		matchAfter = (child.name).match(regAfter)[0]
		if (matchBefore == "sidebar")
			if (matchAfter == layerCurrent)
				noMatch = false

	# Swap Views
	if (noMatch)
		return

	activeTile = "tile_" + layerCurrent

	for name, child of comp
		matchBefore = (child.name).match(regBefore)[0]
		matchAfter = (child.name).match(regAfter)[0]
		if ( matchBefore == "sidebar" )
			if ( matchAfter == layerCurrent ) # FadeIn new View
				currentIcon = prefix.icon + layerCurrent
				currentActive = prefix.active + layerCurrent

				SidebarState.current_view = layerCurrent # Set Global SidebarState

				# Reset Icons
				for icon in navbarIcons.children
					icon.animate('visible')
				# Reset Active Icons
				for icon in navbarActive.children
					icon.animate('transparent')

				# Update current Icons + Active Icons
				navbarIcons.childrenWithName(currentIcon)[0].animate('transparent')
				navbarActive.childrenWithName(currentActive)[0].animate('visible')

				child.parent.parent.visible = true # FadeIn new View
				child.animate('visible')
			else
				child.animate('transparent') # FadeOut old View
				child.parent.parent.visible = false

	# Reset new scroll component
	currentScroll = "container_sidebar_" + layerCurrent
	for name, scroll of scroll_components
		if ( scroll.name == currentScroll )
			scroll.scrollY = 0


# Threejs
# --------------------------------------------------------------------------------

THREE_Layer = new Layer
THREE_Layer.name = "THREE_Layer"
THREE_Layer.backgroundColor = "none"
THREE_Layer.width = synapseParameters.size.width
THREE_Layer.height = synapseParameters.size.height


# Framer Layers ingore events by default 
THREE_Layer.ignoreEvents = false


# Create canvas element --> For adding 3D
THREE_Canvas = document.createElement("canvas");

THREE_Canvas.style.width = Utils.pxify(THREE_Layer.width)
THREE_Canvas.style.height = Utils.pxify(THREE_Layer.height)


# Add canvas element
THREE_Layer._element.appendChild(THREE_Canvas);

# Initialize 3D Viewer
Overview.setup(THREE_Layer, THREE_Canvas)
Overview.animate()

# Reorder layers
THREE_Layer.sendToBack()
synapse.container_view_bg.sendToBack()


