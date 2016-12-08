# Notification Generator for Framerjs
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
queue = []
exiting = false
pushing = false
_clear = false



# Notification Generator
# --------------------------------------------------------------------------------

# Need to generate way to create/access layer for hover states


# Generate Simple { Gray } Notifcation -> Spawn top left, stacking
# header | copy | icon | CTA:bool | elemName
Simple = (content, CTA=false, elemName='element_notification') ->
	header = content.header
	copy = content.copy
	icon = content.icon
	
	elem = ''
	elem2 = ''
	elem3 = ''

	elem = generateContainer(elemName)
	
	elem2 = generateHitboxLeft(elem)
	elem3 = generateHitboxLeftBG(elem2, CTA)

	elem2 = generateHitboxRight(elem)
	
	generateHitboxRightIcon(elem2, CTA)
	generateHitboxLeftIcon(elem3, icon, CTA)
	generateHeader(elem, header)
	generateCopy(elem, copy)

	# Push Animations
	fadeInNotification()
	pushNotification()

	fadeOutNotification(10000) 
# Generate Progress { Green } Progress Notifcation -> Spawn top left, stacking
# header | copy | icon 

Progress = (header, copy, progress) ->
	console.log "something"


# Generate CTA { Green } Notifcation -> Spawn bottom middle, only one at a time
# header | copy | icon | CTA:bool | elemName

CTA = (content) ->
	Simple(content, true, 'element_notification_CTA')


# Create Notification 
generateContainer = (elemName) ->

	_this = new Layer
		name: elemName
		x: Align.left(25)
		y: Align.top(-64)
		width: 238
		height: 64
		backgroundColor: "transparent"
		borderRadius: 32
		opacity: 0

	if (_clear)
		_this.style.background = Colors.gradient.gray_0A25
		_this.style = '-webkit-backdrop-filter': 'blur(30px)'
	else
		_this.style.background = Colors.gradient.gray_0

	# Setup States
	States.setupTogglePush(_this)
	States.setupFadeOnce(_this)

	# Event Handlers
	_this.on Events.MouseOver, (event, layer) ->
		layer.animate('pushRight')

	_this.on Events.MouseOut, (event, layer) ->
		layer.animate('pushLeft')

	return _this


# Create Notification Hitbox, Left
generateHitboxLeft = (elem) ->
	_this = new Layer
		parent: elem
		name: "hitbox_left"
		backgroundColor: "transparent"

	_this.borderRadius = _this.parent.borderRadius
	_this.width = _this.parent.height
	_this.height = _this.parent.height

	return _this


# Create Notification Hitbox, Left BG
generateHitboxLeftBG = (elem, CTA) ->
	backgroundGradient = ''
	
	if (CTA)
		backgroundGradient = Colors.gradient.green_0
	else
		backgroundGradient = Colors.gradient.gray_1

	# Create Notification Hitbox, Left BG
	_this = new Layer
		parent: elem
		name: "hitbox_left_BG"
		width: 48
		height: 48
		borderRadius: 48
		x: Align.center
		y: Align.center

	_this.style.background = backgroundGradient

	return _this


# Create Notification Hitbox, Right
generateHitboxRight = (elem) ->

	_this = new Layer
		parent: elem
		name: "hitbox_right"
		backgroundColor: "transparent"

	_this.borderRadius = _this.parent.borderRadius
	_this.width = _this.parent.height
	_this.height = _this.parent.height
	_this.x = Align.right

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

		# Check current element status
		elems = ƒƒ('element_notification*')

		if (elems.length > 1)
			shift = true
			offset = 12
			for elem, index in elems
				if (elem == layer.parent)
					# offset = index == 0 ? 0 : 24 # If newest element removed, make up for initial offset
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


		layer.parent.animate('translucent')
		# Remove notification element after animtion completes
		layer.parent.onAnimationEnd -> layer.parent.destroy()	

	return _this


# Create Notification Hitbox, Left Icon
generateHitboxLeftIcon = (elem, icon, CTA) ->
	icon = 'icons_' + icon.toString()

	_this = ƒ(icon).copy()	
	_this.parent = elem

	_this.x = Align.center
	_this.y = Align.center
	_this.opacity = 0.5

	if (CTA)
		_this.style["mixBlendMode"] = "multiply"


# Create Notification Hitbox, Right Close Icon
generateHitboxRightIcon = (elem, CTA) ->
	icon = 'icons_'
	
	# if (CTA)
	# 	icon += 'go_alt'
	# else
	icon += 'close'

	_this = ƒ(icon).copy()	
	_this.parent = elem
	_this.x = Align.center
	_this.y = Align.center

	_this.opacity = 0.25

	# Setup States
	States.setupFadeOnce(_this)


# Create Notification Header
generateHeader = (elem, headerCopy) ->
	_this = new TextLayer
		text: headerCopy
		autoSize: true
		color: Colors.ui.gray_5
		textAlign: "left"
		textTransform: "uppercase"
		fontSize: 10
		fontWeight: "Bold"
		lineHeight: 1.15
		letterSpacing: 1
		fontFamily: "Source Sans Pro"

	_this.parent = elem
	_this.name = "header"
	_this.x = 72
	_this.y = Align.center(-12)


# Create Notification Copy
generateCopy = (elem, copy) ->
	_this = new TextLayer
		text: copy
		autoSize: true
		width: 112
		color: Colors.ui.gray_5
		textAlign: "left"
		fontSize: 9
		fontWeight: "600"
		lineHeight: 1.25
		fontFamily: "Source Sans Pro"

	_this.parent = elem
	_this.name = "copy"
	_this.x = 72
	_this.y = Align.center(4)


# Notification Animators
# --------------------------------------------------------------------------------


# Fade In notification immediately
fadeInNotification = () ->
	# Fade in notification from top left + push all others
	elems = ƒƒ('element_notification*')

	elems[elems.length - 1].animate
		opacity: 1
		options:
			time: 1


pushNotification = () ->
	elems = ƒƒ('element_notification*')
	padding = ''

	pushing = true

	for elem, index in elems
		if (index == elems.length-1)
			padding = 24
		else
			padding = 12

		offset = elems[0].height + padding

		elem.animate
			y: (elem.y + offset)
			options:
				time: 1
				curve: "spring(250, 25, 0)"

		elem.onAnimationEnd -> pushing = false


# Fade Out notification after timeOut
fadeOutNotification = (timer=10000) ->

	# Animate out 
	animateOut = (CTA=false) ->

		# Target all other notifications
		elems = ƒƒ('element_notification*')

		elem_n = elems[0]
		elem_n.animate # Fadeout the final notification element
			opacity: 0
			options:
	        	time: 1

		# Remove notification element after animtion completes
		elem_n.onAnimationEnd -> elem_n.destroy()	


	$p = new Promise (
		(resolve, reject) ->
			window.setTimeout(
				-> resolve()
				timer
			)
	)

	$p.then(
		() ->
			animateOut(CTA)
			if (!exiting)
				queueCheck(queue)
	)
	.catch(
		(reason) ->
	)



# Stochastic Notification Generators
# --------------------------------------------------------------------------------

# Select notification content
setNotificationContent = (contents) ->
	num = 0
	num2 = 0

	for name, content of contents # Calculate number of object entries
		num++

	num-- # length-1

	key = Utils.round( Utils.randomNumber(0, num) )

	for name, content of contents # Calculate number of object entries
		if (key == num2)
			return content
		num2++


# Switch between Simple/CTA/Progress
setNotificationType = (options) ->
	num = 0
	num2 = 0
	
	for name, option of options # Calculate number of object entries
		num++

	key = Utils.round( Utils.randomNumber(0, num) )

	for name, option of options # Calculate number of object entries
		if (key == num2)
			notification = 
				content: setNotificationContent(option)
				name: name

			return notification
		num2++


# Check notification queue
queueCheck = (queue) ->
	if (!queue.length)
		return
	
	elems = ƒƒ('element_notification*')
	if (elems.length > 3)
		return

	# Notifcation Creation Functions
	makeNotification = 
		Simple: Simple
		Progress: Progress
		CTA: CTA

	queueItem = queue.shift()

	for name, create of makeNotification
		if (name == queueItem.name)	
			create(queueItem.content)


# Recursively generate notifications
Generator = (options, clear=false) ->
	_clear = clear
	# Notifcation Creation Functions
	makeNotification = 
		Simple: Simple
		Progress: Progress
		CTA: CTA

	notificationContents = setNotificationType(options)

	if (notificationContents && !exiting)
		for name, create of makeNotification
			if (name == notificationContents.name)
				elems = ƒƒ('element_notification*')
				
				if (elems.length < 3)
					create(notificationContents.content, clear)
				else					
					if create.name == "CTA" # Priority first queuing
						queue.unshift(notificationContents) # CTA notifications get priority
					else
						queue.push(notificationContents) # over Simple notifications


	recurGen = () ->
		Generator(options, clear)
	
	timeOut = Utils.randomNumber(1000, 6000)
	window.setTimeout(recurGen, timeOut)


# Module Exports ------------------------------------------------------

exports.Generator = Generator






