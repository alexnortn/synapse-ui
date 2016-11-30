# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Synapse Design Prototypes"
	author: "alex norton"
	twitter: "@alexnortn"
	description: "Prototypes for Neo Game"

# Import file "SynapseDesign_V2"
synapse = Framer.Importer.load("imported/SynapseDesign_V2@1x")
layers = [synapse.Navbar, synapse.Overview, synapse.Leaderboard]
navbarTiles = synapse.Navbar.childrenWithName("_Navbar")[0].childrenWithName("tiles")[0]

# Reset opacity for Navbar Tiles 
for child in navbarTiles.subLayers
	child.opacity = 0

scaleFactor = 2

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


# Initially hide Leaderboard
synapse.Leaderboard.opacity = 0 


# Setup scrollable sidebar => Overview
scrollOverview = ScrollComponent.wrap(synapse.Overview)
scrollOverview.width = synapse.Overview.width
scrollOverview.height = synapse.Navbar.height
# # Allow scrolling with mouse --> Breaks interactivity?
# scrollOverview.mouseWheelEnabled = true
scrollOverview.scrollHorizontal = false


# Setup scrollable sidebar => Leaderboard
scrollLeaderboard = new ScrollComponent
	wrap: synapse.Leaderboard, scrollHorizontal: false, width: synapse.Leaderboard.width, height: synapse.Navbar.height


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

# Initialize our 3D Viewer
# Overview.setup(THREE_Layer, THREE_Canvas)
# Overview.animate()

# Reorder layers
THREE_Layer.sendToBack()
synapse.BG.sendToBack()

# Initialize element states
# Pass in reference to @Sketch Imported layers
States.setup(layers, synapse.Overview.width)
States.setupFade(layers)
States.setupFade(navbarTiles.subLayers)
 
# Animate N layers together with similar properties 
animateLayer = (layer) ->
	layer.stateCycle()

# Event Handlers
# synapse.Navbar.on Events.Click, (event, layer) ->
# 	for layer in layers
# 		animateLayer(layer)

# MouseOver
for child in navbarTiles.subLayers
	child.on Events.MouseOver, (event, layer) ->
		for other in navbarTiles.subLayers
			other.animate('transparent') # Fadeout all other tiles
		layer.stateSwitch('transparent')
		layer.animate('visible')
		layer.on Events.MouseOut, (event, layer2) ->
			layer2.animate('transparent')

# Click
for child in navbarTiles.subLayers
	child.on Events.Click, (event, layer) ->
		for other in navbarTiles.subLayers
			other.animate('transparent') # Fadeout all other tiles
		layer.stateSwitch('transparent')
		layer.animate('visible')

		if (layer.name == "logo_tile")
			synapse.Leaderboard.animate('transparent')
			scrollOverview.scrollY = 0 # Reset scroll
			synapse.Overview.animate('visible')

		if (layer.name == "leaderboard_tile")
			synapse.Overview.animate('transparent')
			scrollLeaderboard.scrollY = 0 # Reset scroll
			synapse.Leaderboard.animate('visible')


