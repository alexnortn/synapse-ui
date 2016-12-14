# Announcement Generator for Framerjs
# Alex Norton | 2016


# Framer Modules
{TextLayer} = require('TextLayer')
{ƒ,ƒƒ} = require ('findModule')
Styles = require("styles")
States = require("states")


# Styles
Colors = Styles.styles.colors
Typography = Styles.styles.typography

# Globals
_scroll_component = ''


# Annoucement Generator
# --------------------------------------------------------------------------------

# Generate Simple { Gray } Notifcation -> Spawn top left, stacking
# header | copy | icon | CTA:bool | elemName
Announce = (content) ->
	header = content.header || "points"
	copy = content.copy || "points"
	icon = content.icon || "points"
	type = content.type || "notice"

	sectionName = "section_" + type
	sectionLookUp = "sidebar_announcements " + sectionName

	section = ƒ(sectionLookUp)

	elem = generateContainer(section)
	elem2 = generateHitboxLeft(elem, type)
	elem3 = generateHitboxRight(elem)
	
	generateHitboxLeftIcon(elem2, icon, type)
	generateHitboxRightIcon(elem3, type)

	if (type == "event")
		elem2 = generateHitboxRight2(elem, icon, type)		
		elem3 = generateHitboxRightIcon2(elem2, type)

	generateHeader(elem, header)
	generateCopy(elem, copy)

	generateElapsed(elem)

	# Push Animations
	fadeInAnnoucement(elem)
	updateLayoutSystem(type)


# Create Annoucement Container 
generateContainer = (parent) ->

	_this = new Layer
		name: "announcement_container"
		x: 0
		y: Align.top(-64)
		width: 320
		height: 64
		backgroundColor: "transparent"
		opacity: 0
		parent: parent

	# Setup States
	States.setupTogglePush(_this)
	States.setupFadeOnce(_this)

	# Event Handlers
	# _this.on Events.MouseOver, (event, layer) ->
	# 	layer.animate('pushRight')

	# _this.on Events.MouseOut, (event, layer) ->
	# 	layer.animate('pushLeft')

	return _this


# Create Annoucement Hitbox, Left 
generateHitboxLeft = (elem, type) ->
	backgroundGradient = ''
	
	if (type == "achievement")
		backgroundGradient = Colors.gradient.gray_1
	else
		backgroundGradient = Colors.gradient.green_0

	# Create Annoucement Hitbox, Left BG
	_this = new Layer
		parent: elem
		name: "hitbox_left_BG"
		width: 32
		height: 32
		borderRadius: 32
		x: 42
		y: Align.center

	_this.style.background = backgroundGradient

	return _this


# Create Annoucement Hitbox, Left Icon
generateHitboxLeftIcon = (elem, icon, type) ->
	icon = 'icons_' + icon.toString()

	_this = ƒ(icon).copy()	
	_this.parent = elem

	_this.x = Align.center
	_this.y = Align.center(1)
	_this.opacity = 0.5

	if (type != "achievement")
		_this.style["mixBlendMode"] = "multiply"


# Create Annoucement Hitbox, Right
generateHitboxRight = (elem) ->

	_this = new Layer
		parent: elem
		name: "hitbox_right"
		backgroundColor: "transparent"

	_this.borderRadius = 32
	_this.width = 32
	_this.height = 32
	_this.x = 268
	_this.y = Align.center

	# Setup States
	States.setupFadeOnce(_this)

	# Event Handlers
	_this.on Events.MouseOver, (event, layer) ->
		layer.children[0].animate('visible')

	_this.on Events.MouseOut, (event, layer) ->
		layer.children[0].animate('translucent')

	_this.on Events.Click, (event, layer) ->
		if (pushing)
			return

		# reFlowAnnoucement(layer.parent)

		layer.parent.animate('translucent')
		# Remove notification element after animtion completes
		layer.parent.onAnimationEnd -> layer.parent.destroy()	

	return _this


# Create Annoucement Hitbox, Right Close Icon
generateHitboxRightIcon = (elem, type) ->
	icon = 'icons_submit'

	_this = ƒ(icon).copy()	
	_this.parent = elem
	_this.x = Align.center
	_this.y = Align.center

	_this.opacity = 0.25

	# Setup States
	States.setupFadeOnce(_this)


# Create Annoucement Hitbox, Right
generateHitboxRight2 = (elem) ->

	_this = new Layer
		parent: elem
		name: "hitbox_right"
		backgroundColor: "transparent"

	_this.borderRadius = 32
	_this.width = 32
	_this.height = 32
	_this.x = 227
	_this.y = Align.center

	# Setup States
	States.setupFadeOnce(_this)

	# Event Handlers
	_this.on Events.MouseOver, (event, layer) ->
		layer.children[0].animate('visible')

	_this.on Events.MouseOut, (event, layer) ->
		layer.children[0].animate('translucent')

	_this.on Events.Click, (event, layer) ->
		if (pushing)
			return

		# reFlowAnnoucement(layer.parent)

		layer.parent.animate('translucent')
		# Remove notification element after animtion completes
		layer.parent.onAnimationEnd -> layer.parent.destroy()	

	return _this


# Create Annoucement Hitbox, Right Close Icon
generateHitboxRightIcon2 = (elem, type) ->
	icon = 'icons_close'

	_this = ƒ(icon).copy()	
	_this.parent = elem
	_this.x = Align.center
	_this.y = Align.center

	_this.opacity = 0.25

	# Setup States
	States.setupFadeOnce(_this)


# Create Annoucement Header
generateHeader = (elem, headerCopy) ->
	_this = new TextLayer
		text: headerCopy
		autoSize: true
		color: Colors.ui.gray_5
		textAlign: "left"
		fontSize: 9
		fontWeight: "600"
		lineHeight: 1.15
		letterSpacing: 0.25
		fontFamily: "Source Sans Pro"

	_this.parent = elem
	_this.name = "header"
	_this.x = 82
	_this.y = Align.center(-12)


# Create Annoucement Copy
generateCopy = (elem, copy) ->
	_this = new TextLayer
		text: copy
		autoSize: true
		width: 130
		color: Colors.ui.gray_5
		textAlign: "left"
		fontSize: 9
		fontWeight: "400"
		lineHeight: 1.25
		fontFamily: "Source Sans Pro"

	_this.parent = elem
	_this.name = "copy"
	_this.x = 82
	_this.y = Align.center(0)


# Create Annoucement Copy
generateElapsed = (elem) ->
	_this = new TextLayer
		text: "1min"
		autoSize: true
		width: 40
		color: Colors.ui.gray_4
		textAlign: "left"
		fontSize: 9
		fontWeight: "600"
		lineHeight: 1.25
		fontFamily: "Source Sans Pro"

	_this.parent = elem
	_this.name = "elapsed"
	_this.x = 8
	_this.y = Align.center(-10)
	_this.rotation = -90


# Annoucement Animators
# --------------------------------------------------------------------------------

# Fade In annoucement immediately
fadeInAnnoucement = (elem) ->
	elem.animate
		opacity: 1
		options:
			time: 1


# This will need a bit more logic given the sections
updateLayoutSystem = (type) ->	
	section_elems = ƒƒ('section_*')   # Ref to all sections within <Announcements>
	section_name = "section_" + type  # Ref to current section name
	section_height_initial = 0
	section_height = 0

	displacement = 0
	displacement_queue = 0

	section_elem = ƒ( section_name ) # Reference to each individual section within <Announcements>
	section_height_initial = section_elem.height
	elems = section_elem.ƒƒ('announcement_container')

	push = false
	padding = ''

	# Update section attributes accordingly
	updateHeight = (section_elem, newHeight, initialHeight, padding=0) ->
		section_elem.animate
			height: newHeight
			options:
				time: 1
				curve: "spring(250, 25, 0)"

		displacement = newHeight - initialHeight + padding

		# Update sidebar dimensions
		section_elem.parent.animate
			height: ( ƒ( "sidebar_announcements" ).height + displacement )
			options:
				time: 1
				curve: "spring(250, 25, 0)"

		# If Annoucement added before section, push section down
		for elem, index in section_elems
			if (push)
				elem.y = (elem.y + displacement)

			if (elem.name == section_name)
				push = true

		# section_elem.parent.height += displacement
		section_elem.parent.parent.height += displacement
		section_elem.parent.parent.parent.height += displacement

		# ??????????????????? --> Scroll


	# If there are annoucements present, toggle filler_text
	if (elems.length)
		section_elem.ƒ( "filler_text" ).animate('transparent')
	else
		section_elem.ƒ( "filler_text" ).animate('visible')
		section_elem.height = 168 # Reset section height


	# Animate <push> all annoucements in section
	for elem, index in elems
		if (index == elems.length-1)
			padding = 32
		else
			padding = 0

		offset = elem.height + padding
		section_height += offset # Perhaps this is part of the problem
		
		elem.animate
			y: (elem.y + offset)
			options:
				time: 1
				curve: "spring(250, 25, 0)"

	
	# Update section dimensions
	if (elems.length < 5)
		section_height += 32 # Padding --> This will always be the total height of the section
		updateHeight(section_elem, section_height, section_height_initial)
	else if ( section_elem.parent.ƒƒ( "more_annoucements" ).length == 0 ) # We're adding <more> to the current section's parent, to handle spacing

		console.log "adding more button"
		console.log section_elem.parent.ƒƒ( "more_annoucements" )

		# Create a more section
		button = askForMore(section_elem)
		button.animate('visible')

		padding = 104
		updateHeight(section_elem, section_height, section_height_initial, padding)

		# If user asks for more
		button.on Events.Click, (event, layer) ->
			padding = -104
			updateHeight(section_elem, section_height, section_height_initial, padding)		


# This will need a bit more logic given the sections
reFlowNotification = (current) ->
	# Check current element status
	elems = ƒƒ('element_notification*')

	if (elems.length > 1)
		shift = true
		offset = 12

		for elem, index in elems
			if (elem == current)
				shift = false

			if (shift) # push all remaining elements upwards
				exiting = true # global for managing generator + queue
				elem.animate
					y: (elem.y - elem.height - offset)
					options:
						time: 1
						curve: "spring(250, 25, 0)"

				elem.onAnimationEnd -> 
					exiting = false


# Initialization
# --------------------------------------------------------------------------------

placeHolder = (section) ->

	text = "There are no new messages at this time."

	_this = new TextLayer
		text: text
		name: "filler_text"
		color: Colors.ui.gray_4
		textAlign: "center"
		autoSizeHeight: true
		fontSize: 10
		fontWeight: 400
		lineHeight: 1.15
		fontFamily: "Source Sans Pro"

	_this.parent = section
	_this.width = 124
	_this.x = Align.center
	_this.y = Align.center

	section.height = 168 # Reset section height

	States.setupFadeOnce(_this)


askForMore = (parent) ->

	moreSection = new Layer
		name: "more_annoucements"
		x: 0
		y: (parent.y + 32 + 5 * 64) # generalize this
		width: 320
		height: 72
		backgroundColor: "transparent"
		opacity: 0
		parent: parent.parent

	
	moreButton = new Layer
		parent: moreSection
		width: 90
		height: 24
		borderRadius: 8
		x: Align.center
		y: Align.center
		backgroundColor: "transparent"

	moreButton.style.border = "1px solid #262A33"


	textButton = new TextLayer
		text: "More"
		name: "filler_text"
		color: Colors.ui.gray_4
		textAlign: "center"
		textTransform: "uppercase"
		autoSizeHeight: true
		fontSize: 9
		fontWeight: 600
		letterSpacing: 0.75
		lineHeight: 1.15
		fontFamily: "Source Sans Pro"

	textButton.parent = moreButton
	textButton.width = 72
	textButton.x = Align.center
	textButton.y = Align.center


	States.setupFadeOnce(moreSection)

	return moreSection


initialize = (container) ->
	# Target view to populate
	sections = container.ƒƒ('section*')

	# For each section, (initially) populate < no messages at this time >
	for section in sections
		placeHolder(section) # Create placehold text

	# Global reference for ScrollComponent
	# for scroll in scroll_components
	# 	if (scroll.name = "container_sidebar_annoucements")


# Clean up layer upon user interaction
resolve = (layer) ->
	console.log('resolve')


# Module Exports ------------------------------------------------------

exports.Announce = Announce
exports.initialize = initialize

# Where will this be called from?
# We may not want to funcify this.
# Initialize this in app.coffee --> Call it in notification.coffeee




