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

# Framer Modules
ViewController = require 'ViewController'

# NPM Modules
# overview = require("npm").overview

# My Modules
Overview = require("overview")
Utils = require("utils")


# Define and set custom device 
# Framer.Device.deviceType = "apple-imac"
# Framer.Device.contentScale = 1

for name, layer of synapse
	layer.visible = true
	layer.opacity = 0
# 	layer.x = 0
# 	layer.y = 0
	layer.scale = 1

# Create a layer that's the same size as the device screen
# Add it above the sketch bg
# But below foreground layers

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

console.log(THREE_Layer.width)
# Initialize our 3D Viewer
# Overview.init(THREE_Layer, canvas_elem)


