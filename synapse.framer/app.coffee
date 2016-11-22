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
three = require("npm").three
controls = require("npm").controls

# Define and set custom device 
# Framer.Device.deviceType = "apple-imac"
# Framer.Device.contentScale = 1

for name, layer of synapse
	layer.visible = true
	layer.opacity = 0
	layer.x = 0
	layer.y = 0
	layer.scale = 1
	
synapse.Overview_Sidebar_Home_Select_1.opacity = 1
