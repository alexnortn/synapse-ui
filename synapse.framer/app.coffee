# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

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


# Navbar Elements 
navbarTiles = synapse.container_view_navbar.childrenWithName("view_navbar")[0].childrenWithName("tiles")[0]
navbarIcons = synapse.container_view_navbar.childrenWithName("view_navbar")[0].childrenWithName("icons")[0]
navbarActive = synapse.container_view_navbar.childrenWithName("view_navbar")[0].childrenWithName("active")[0]

# Regex Helpers
prefix = 
	view:		"view_"
	sidebar: 	"sidebar_"
	active: 	"active_"
	icon: 		"icon_"
	tile: 		"tile_"


# Initially hide select elements
synapse.container_sidebar_leaderboard.opacity = 0
navbarActive.childrenWithName('active_leaderboard')[0].opacity = 0
navbarActive.childrenWithName('active_overview')[0].opacity = 0 

for child in navbarTiles.subLayers
	child.opacity = 0


# Setup Sidebar States
setupSidebar = (comp) -> 
	regAfter = /[^_]*$/g 		# regex for matching string after "_"
	regBefore = /^([^_]+)/g	# regex for matching string before "_"

	# Swap Views
	for name, child of comp
		matchBefore = (child.name).match(regBefore)[0]
		matchAfter = (child.name).match(regAfter)[0]
		layers = []

		if ( matchBefore == "sidebar" )
			layer = child.children[0]
			layers.push(layer)

	States.setupScroll(layers, synapse.container_sidebar_overview.width)
	States.setupFade(layers)

setupSidebar(synapse)


# Initialize element states
# Pass in reference to @Sketch Imported layers
States.setupFade(navbarTiles.subLayers)
States.setupFade(navbarIcons.subLayers)
States.setupFade(navbarActive.subLayers)


# Setup initial Active State 
activeTile = navbarTiles.childrenWithName('tile_overview')[0]
navbarIcons.childrenWithName('icon_overview')[0].stateSwitch('transparent')
navbarTiles.childrenWithName('tile_overview')[0].stateSwitch('visible')
navbarActive.childrenWithName('active_overview')[0].stateSwitch('visible')

# Overview scroll component
scroll_overview = ScrollComponent.wrap(synapse.container_sidebar_overview)
scroll_overview.scrollHorizontal = false
scroll_overview.propagateEvents = false


# Leaderboard scroll component
scroll_leaderboard = ScrollComponent.wrap(synapse.container_sidebar_leaderboard)
scroll_leaderboard.scrollHorizontal = false
scroll_leaderboard.propagateEvents = false

scroll_components = 
	overview: scroll_overview
	leaderboard: scroll_leaderboard

 
# Animate N layers together with similar properties 
animateLayer = (layer) ->
	layer.stateCycle()


# Event Handlers
# synapse.view_navbar.on Events.Click, (event, layer) ->
# 	for layer in layers
# 		animateLayer(layer)

# MouseOver
for child in navbarTiles.subLayers
	child.on Events.MouseOver, (event, layer) ->
		for other in navbarTiles.subLayers
			if (other.name != activeTile.name)
				other.animate('transparent') # Fadeout all other tiles
		layer.stateSwitch('transparent')
		layer.animate('visible')
		layer.on Events.MouseOut, (event, layer2) ->
	#	Maintain highlight state
			if (layer2.name != activeTile.name)
				layer2.animate('transparent')

# Click
for child in navbarTiles.subLayers
	child.on Events.Click, (event, layer) ->
		for other in navbarTiles.subLayers
			other.animate('transparent') # Fadeout all other tiles
		layer.stateSwitch('transparent')
		layer.animate('visible')

# 		changeView(layer, synapse)


# View Controller
changeView = (layer, comp) -> 
	activeTile = layer

	regAfter = /[^_]*$/g 		# regex for matching string after "_"
	regBefore = /^([^_]+)/g	# regex for matching string before "_"
	
	currentAfter  = (layer.name).match(regAfter)[0] 	# Layer Name | "flag"
	currentBefore = (layer.name).match(regBefore)[0]	# Layer Type | "tile" 

	# Swap Views
	for name, child of comp
		matchBefore = (child.name).match(regBefore)[0]
		matchAfter = (child.name).match(regAfter)[0]
		if ( matchBefore == "sidebar" )
			if ( matchAfter == currentAfter ) # FadeIn new View
				print(child)
				child.visible = true
				child.animate('visible')
			else
				child.animate('transparent') # Fadeout old View
				child.visible = false

	# Reset new scroll component
	currentScroll = "scroll" + currentAfter
	for scroll in scroll_components
		if ( scroll.name == currentScroll )
			scroll.scrollY = 0

	currentIcon = prefix.icon + currentAfter
	currentActive = prefix.active + currentAfter
	
	# Reset Icons
	for icon in navbarIcons.children
		icon.animate('visible')
	# Reset Active Icons
	for icon in navbarActive.children
		icon.animate('transparent')
		
	# Set current Icons + Active Icons
	navbarIcons.childrenWithName(currentIcon)[0].animate('transparent')
	navbarActive.childrenWithName(currentActive)[0].animate('visible')



# ThreeJs 
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
# Overview.setup(THREE_Layer, THREE_Canvas)
# Overview.animate()

# Reorder layers
THREE_Layer.sendToBack()
synapse.container_view_bg.sendToBack()


