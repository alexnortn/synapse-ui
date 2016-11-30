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
layers = [synapse.view_navbar, synapse.sidebar_overview, synapse.sidebar_leaderboard]

# Navbar Elements 
navbarTiles = synapse.view_navbar.childrenWithName("navbar")[0].childrenWithName("tiles")[0]
navbarIcons = synapse.view_navbar.childrenWithName("navbar")[0].childrenWithName("icons")[0]
navbarActive = synapse.view_navbar.childrenWithName("navbar")[0].childrenWithName("active")[0]

# Regex Helpers
prefix = 
	view:		"view_"
	sidebar: 	"sidebar_"
	active: 	"active_"
	icon: 		"icon_"
	tile: 		"tile_"


# Initially hide select elements
synapse.sidebar_leaderboard.opacity = 0
navbarActive.childrenWithName('active_leaderboard')[0].opacity = 0
navbarActive.childrenWithName('active_overview')[0].opacity = 0 

for child in navbarTiles.subLayers
	child.opacity = 0


# Initialize element states
# Pass in reference to @Sketch Imported layers
States.setup(layers, synapse.sidebar_overview.width)
States.setupFade(layers)
States.setupFade(navbarTiles.subLayers)
States.setupFade(navbarIcons.subLayers)
States.setupFade(navbarActive.subLayers)


# Setup initial Active State 
activeTile = navbarTiles.childrenWithName('tile_overview')[0]
navbarIcons.childrenWithName('icon_overview')[0].stateSwitch('transparent')
navbarTiles.childrenWithName('tile_overview')[0].stateSwitch('visible')
navbarActive.childrenWithName('active_overview')[0].stateSwitch('visible')

# Overview scroll component
scroll_overview = ScrollComponent.wrap(synapse.sidebar_overview)
scroll_overview.scrollHorizontal = false
scroll_overview.propagateEvents = false


# Leaderboard scroll component
scroll_leaderboard = ScrollComponent.wrap(synapse.sidebar_leaderboard)
scroll_leaderboard.scrollHorizontal = false
scroll_leaderboard.propagateEvents = false

 
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

		if (layer.name == "tile_overview")
			changeView(layer)
			
			synapse.sidebar_leaderboard.animate('transparent')
			synapse.sidebar_leaderboard.visible = false
			navbarActive.childrenWithName('active_leaderboard')[0].animate('transparent')
			navbarIcons.childrenWithName('icon_leaderboard')[0].animate('visible')
			
			synapse.sidebar_overview.visible = true
			navbarActive.childrenWithName('active_overview')[0].animate('visible')
			navbarIcons.childrenWithName('icon_overview')[0].animate('transparent')
			scroll_overview.scrollY = 0 # Reset scroll
			synapse.sidebar_overview.animate('visible')

		if (layer.name == "tile_leaderboard")
			changeView(layer)
			synapse.sidebar_overview.animate('transparent')

			synapse.sidebar_overview.visible = false
			synapse.sidebar_leaderboard.visible = true
		#	Swap >> Icons
			navbarActive.childrenWithName('active_overview')[0].animate('transparent')
			navbarActive.childrenWithName('active_leaderboard')[0].animate('visible')
			navbarIcons.childrenWithName('icon_leaderboard')[0].animate('transparent')
			navbarIcons.childrenWithName('icon_overview')[0].animate('visible')

			scroll_leaderboard.scrollY = 0 # Reset scroll
			synapse.sidebar_leaderboard.animate('visible')

# # View Controller
changeView = (comp, layer) -> 
	activeTile = layer

	regAfter = /[^_]*$/g 		# regex for matching string after "_"
	regBefore = /^([^_]+)/g	# regex for matching string before "_"
	
	currentAfter  = layer.name.match(regAfter)[0]
	currentBefore = layer.name.match(regBefore)[0]
	
	

	for child in comp.children
		matchBefore = child.name.match(regBefore)[0]
		matchAfter = child.name.match(regBefore)[0]

		if ( matchBefore == "sidebar" )
			if ( matchAfter == currentAfter ) # FadeIn new View
				child.visible = true
				child.animate('visible')
			else
				child.animate('transparent') # Fadeout old View
				child.visible = false

		if ( matchBefore == "navbar" )
			if ( matchAfter == currentAfter ) # FadeIn new Navbar Element
				child.visible = true
				child.animate('visible')
			else
				child.animate('transparent') # Fadeout old Navbar Element
				child.visible = false

# ThreeJs 
THREE_Layer = new Layer
THREE_Layer.name = "THREE_Layer"
THREE_Layer.backgroundColor = "none"
THREE_Layer.width = synapseParameters.size.width
THREE_Layer.height = synapseParameters.size.height


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
synapse.view_bg.sendToBack()


