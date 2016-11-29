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
synapseParameters =
	size: 
		width: 1440
		height: 900


# Initially hide Leaderboard
synapse.Overview.opacity = 0 


# Setup scrollable sidebar => Overview
# scrollOverview = ScrollComponent.wrap(synapse.Overview)
# scrollOverview.width = synapse.Overview.width
# scrollOverview.height = synapse.Navbar.height
# # # Allow scrolling with mouse --> Breaks interactivity?
# # scrollOverview.mouseWheelEnabled = true
# scrollOverview.scrollHorizontal = false

# Setup scrollable sidebar => Leaderboard
scrollLeaderboard = ScrollComponent.wrap(synapse.Leaderboard)
scrollLeaderboard.width = synapse.Leaderboard.width
scrollLeaderboard.height = synapse.Navbar.height
# # Allow scrolling with mouse --> Breaks interactivity?
# scrollLeaderboard.mouseWheelEnabled = true
scrollLeaderboard.scrollHorizontal = false


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
 
# Animate N layers together with similar properties 
animateLayer = (layer) ->
	layer.stateCycle()

# Event Handlers
synapse.Navbar.on Events.Click, (event, layer) ->
	for layer in layers
		animateLayer(layer)
	





