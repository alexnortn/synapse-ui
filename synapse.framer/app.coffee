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
layers = [synapse.view_navbar, synapse.view_overview, synapse.view_leaderboard]

# Navbar Elements 
navbarTiles = synapse.view_navbar.childrenWithName("navbar")[0].childrenWithName("tiles")[0]
navbarIcons = synapse.view_navbar.childrenWithName("navbar")[0].childrenWithName("icons")[0]
navbarActive = synapse.view_navbar.childrenWithName("navbar")[0].childrenWithName("active")[0]


# Initially hide select elements
synapse.view_leaderboard.opacity = 0
navbarActive.childrenWithName('active_leaderboard')[0].opacity = 0
navbarActive.childrenWithName('active_overview')[0].opacity = 0 

for child in navbarTiles.subLayers
	child.opacity = 0


# Initialize element states
# Pass in reference to @Sketch Imported layers
States.setup(layers, synapse.view_overview.width)
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
scrollOverview = ScrollComponent.wrap(synapse.view_overview)
scrollOverview.scrollHorizontal = false
scrollOverview.propagateEvents = false


# Leaderboard scroll component
scrollLeaderboard = ScrollComponent.wrap(synapse.view_leaderboard)
scrollLeaderboard.scrollHorizontal = false
scrollLeaderboard.propagateEvents = false

 
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
			activeTile = layer
			synapse.view_leaderboard.animate('transparent')

			synapse.view_leaderboard.visible = false
			synapse.view_overview.visible = true
		#	Swap >> Icons
			navbarActive.childrenWithName('active_leaderboard')[0].animate('transparent')
			navbarActive.childrenWithName('active_overview')[0].animate('visible')
			navbarIcons.childrenWithName('icon_overview')[0].animate('transparent')
			navbarIcons.childrenWithName('icon_leaderboard')[0].animate('visible')

			scrollOverview.scrollY = 0 # Reset scroll
			synapse.view_overview.animate('visible')

		if (layer.name == "tile_leaderboard")
			activeTile = layer
			synapse.view_overview.animate('transparent')

			synapse.view_overview.visible = false
			synapse.view_leaderboard.visible = true
		#	Swap >> Icons
			navbarActive.childrenWithName('active_overview')[0].animate('transparent')
			navbarActive.childrenWithName('active_leaderboard')[0].animate('visible')
			navbarIcons.childrenWithName('icon_leaderboard')[0].animate('transparent')
			navbarIcons.childrenWithName('icon_overview')[0].animate('visible')

			scrollLeaderboard.scrollY = 0 # Reset scroll
			synapse.view_leaderboard.animate('visible')

# # View Controller
# changeView = (layer) -> 
# 	activeTile = layer


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


