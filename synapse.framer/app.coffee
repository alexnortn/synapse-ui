# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Synapse Design Prototypes"
	author: "alex norton"
	twitter: "@alexnortn"
	description: "Prototypes for Neo Game"


# Import file "SynapseDesign" (sizes and positions are scaled 1:2)
synapse = Framer.Importer.load("imported/SynapseDesign@2x")
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
# Framer.Device.deviceType = "apple-imac"
# Framer.Device.contentScale = 1

for name, layer of synapse
	layer.visible = true
	layer.opacity = 1
# 	layer.x = 0
# 	layer.y = 0
	layer.scale = 1
	
synapse.Cell.opacity = 0

# Setup scrollable sidebar
scrollSidebar = ScrollComponent.wrap(synapse.Sidebar)
scrollSidebar.width = synapse.Sidebar.width
scrollSidebar.height = Screen.height
# 
# # Allow scrolling with mouse --> Breaks interactivity?
# scrollSidebar.mouseWheelEnabled = true
scrollSidebar.scrollHorizontal = false

	



THREE_Layer = new Layer
THREE_Layer.name = "THREE_Layer"
THREE_Layer.backgroundColor = "none"
THREE_Layer.width = Screen.width
THREE_Layer.height = Screen.height

# Create canvas element --> For adding 3D
THREE_Canvas = document.createElement("canvas");

THREE_Canvas.style.width = Utils.pxify(THREE_Layer.width)
THREE_Canvas.style.height = Utils.pxify(THREE_Layer.height)

# Add canvas element
THREE_Layer._element.appendChild(THREE_Canvas);

# Initialize our 3D Viewer
Overview.setup(THREE_Layer, THREE_Canvas)
Overview.animate()

# Reorder layers
THREE_Layer.sendToBack()
synapse.BG.sendToBack()

# Initialize element states
# Pass in reference to @Sketch Imported layers
States.setup(synapse)
 
# Animate N layers together with similar properties 
animateLayer = (layer) ->
	layer.stateCycle()

# Event Handlers
synapse.Navbar.on Events.Click, (event, layer) ->
	for layer in [synapse.Navbar, synapse.Sidebar]
		animateLayer(layer)
	





