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
{TextLayer} = require('TextLayer')
{ƒ,ƒƒ} = require 'findModule'

# NPM Modules
# overview = require("npm").overview

# My Modules
Overview = require("overview")
States = require("states")
Utils = require("utils")
Styles = require("styles")
Notification = require("notification")
Sidebar = require("sidebar")
Announcements = require("announcements")
NotificationContent = require 'notificationContent'

# Styles
Colors = Styles.styles.colors
Typography = Styles.styles.typography

# Apply Styles
ApplyStyle = Styles.applyStyle
ApplyProperty = Styles.applyProperty


# Define and set custom device 
Framer.Device.deviceType = "desktop-safari-1440-900"
Framer.Device.background.backgroundColor = "#181A1E"
synapseParameters =
	size: 
		width: 1440
		height: 900


# Use desktop cursor
document.body.style.cursor = "auto"


# Import file "SynapseDesign_V2" (sizes and positions are scaled 1:2)
# synapse = Framer.Importer.load("imported/SynapseDesign_V2@2x")

# Import file "SynapseDesign_V2"
# synapse = Framer.Importer.load("imported/SynapseDesign_V2@1x")

# Import file "SynapseDesign_V2" --> Transparent
# synapse = Framer.Importer.load("imported/SynapseDesign_V2@1x")

# Import file "SynapseDesign_V3"
synapse = Framer.Importer.load("imported/SynapseDesign_V3@1x")
_clear = true # Global for translucency

scaleFactor = 1 # Directly related to Sketch input scale
scalify = Utils.scalify(scaleFactor)

Framer.Device.contentScale = 1 /scaleFactor # Beware, this makes the prototype a bit wonky


# Setup with Webkit Nightly Builds
# --------------------------------------------------------------------------------

	# Set global flags for prototyping locally using the Webkit Nightly Builds
	# Essentially we're getting very stoked about visualizing a *future* where
	# blur-behind is a possibility
	
	# This technique could already be hacked by creating multiple canvases
	# and projecting the background there.
	
	# So not totally impossible to achieve... ;) 


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

_sidebarViews = []
_sidebarContainers = []
_scroll_components = []


# Setup Scroll Components
# --------------------------------------------------------------------------------

# Overview scroll component
scroll_overview = ScrollComponent.wrap(synapse.container_sidebar_overview)
scroll_overview.height = scalify(scroll_overview.height)
scroll_overview.scrollHorizontal = false
scroll_overview.propagateEvents = false


# Leaderboard scroll component
scroll_leaderboard = ScrollComponent.wrap(synapse.container_sidebar_leaderboard)
scroll_leaderboard.height = scalify(scroll_leaderboard.height)
scroll_leaderboard.scrollHorizontal = false
scroll_leaderboard.propagateEvents = false


# Announcements scroll component
scroll_announcements = ScrollComponent.wrap(synapse.static_container_sidebar_announcements)
scroll_announcements.height = scalify(scroll_announcements.height)
scroll_announcements.scrollHorizontal = false
scroll_announcements.propagateEvents = false

_scroll_components = [ scroll_overview, scroll_leaderboard, scroll_announcements ]


# Setup States
# --------------------------------------------------------------------------------

# Initially hide select elements
# synapse.container_sidebar_leaderboard.visible = false
navbarActive.childrenWithName('active_leaderboard')[0].opacity = 0
navbarActive.childrenWithName('active_overview')[0].opacity = 0 
navbarActive.childrenWithName('active_announcements')[0].opacity = 0 

synapse.container_view_chip.visible = false
synapse.container_view_chip2.visible = false

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
			_sidebarViews.push(child)
			_sidebarContainers.push(child.parent.parent)

	_sidebarContainers.push(synapse.container_view_navbar) # Add Navbar
	_sidebarContainers.push(synapse.container_helper_sidebar_bg) # Add Sidebar BG

	States.setupSlide(_sidebarContainers, synapse.container_sidebar_overview.width)
	States.setupFade(_sidebarViews)

setupSidebar(synapse)

# Translucency
if (_clear)
	synapse.container_helper_sidebar_bg.visible = true
	synapse.container_helper_sidebar_bg.style = '-webkit-backdrop-filter': 'blur(30px)'
	
	synapse.container_view_navbar.childrenWithName("view_navbar")[0]
		.childrenWithName("helper_navbar_bg")[0]
			.visible = true
	synapse.container_view_navbar.childrenWithName("view_navbar")[0]
		.childrenWithName("helper_navbar_bg")[0]
			.style = '-webkit-backdrop-filter': 'blur(30px)'

	synapse.container_view_chat.childrenWithName("view_chat")[0]
		.childrenWithName("view_chat_textInput")[0]
			.style = '-webkit-backdrop-filter': 'blur(30px)'

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

synapse.static_container_sidebar_announcements.opacity = 0


# Animate N layers together with similar properties 
animateLayer = (layer, state) ->
	layer.animate(state)


# Event Handlers
# --------------------------------------------------------------------------------

# Sidebar "MouseOver" Interaction
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

# Sidebar "Click" Interaction
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
			
			for layer in _sidebarContainers # Toggle Open/Close containers
				animateLayer(layer, animation)

		changeView(layerAfter)

		for other in navbarTiles.subLayers
			if (other.name != activeTile) # Maintain highlight state
				other.animate('transparent') # Fadeout all other tiles

# Chat "Click" Interaction
chatElement.on Events.Click, (event, layer) ->
	for elem in activeChatElements
		elem.stateCycle()

# View Controller
# --------------------------------------------------------------------------------

# Generalized to work with ƒƒ{•}
changeView = (layerCurrent) -> 

	sidebars = ƒƒ("sidebar_*")

	activeTile = "tile_" + layerCurrent

	for sidebar in sidebars
		matchBefore = (sidebar.name).match(regBefore)[0]
		matchAfter = (sidebar.name).match(regAfter)[0]
		
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

			sidebar.parent.parent.visible = true # FadeIn new View
			sidebar.animate('visible')
		else
			sidebar.animate('transparent') # FadeOut old View
			sidebar.parent.parent.visible = false

	# Reset new scroll component
	currentScroll = "container_sidebar_" + layerCurrent
	for name, scroll of _scroll_components
		if ( scroll.name == currentScroll )
			scroll.scrollY = 0


# Threejs
# --------------------------------------------------------------------------------

THREE_Layer = new Layer
THREE_Layer.name = "THREE_Layer"
THREE_Layer.backgroundColor = "none"
THREE_Layer.width = scalify(synapseParameters.size.width)
THREE_Layer.height = scalify(synapseParameters.size.height)


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


# Sidebar Generator
# --------------------------------------------------------------------------------
	
Sidebar.Generate.structure("announcements")

# Generate sidebar Announcement sections 
Sidebar.Generate.section( ƒ('sidebar_announcements'), "notice" )
Sidebar.Generate.section( ƒ('sidebar_announcements'), "event" )
Sidebar.Generate.section( ƒ('sidebar_announcements'), "achievement" )

Sidebar.Generate.interaction( "announcements", _scroll_components, _sidebarViews, _sidebarContainers, synapse )

# Generate sidebar Announcement section content
# Initialization --> Empty text
Announcements.initialize( ƒ('sidebar_announcements') )



# Notification Generator
# --------------------------------------------------------------------------------

# Kick off recursive notification generator 
Notification.Generator(NotificationContent.content, _clear)
# Announcements.Generate("Hello")
