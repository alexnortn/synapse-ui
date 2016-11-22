# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "alex norton"
	twitter: ""
	description: ""


# Import file "SynapseDesign" (sizes and positions are scaled 1:2)
synapse = Framer.Importer.load("imported/SynapseDesign@2x")

ViewController = require 'ViewController'
overview = require("npm").overview

# Define and set custom device 
# Framer.Device.deviceType = "apple-imac"
# Framer.Device.contentScale = 1

for name, layer of synapse
	layer.visible = true
	layer.opacity = 1
# 	layer.x = 0
# 	layer.y = 0
	layer.scale = 1

# Create a layer that's the same size as the device screen
# Add it above the sketch bg
# But below foreground layers
