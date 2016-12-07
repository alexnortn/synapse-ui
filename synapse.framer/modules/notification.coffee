# Notification Generator for Framerjs
# Alex Norton | 2016


# Framer Modules
{TextLayer} = require('TextLayer')
{ƒ,ƒƒ} = require ('findModule')
Styles = require("styles")


# Styles
Colors = Styles.styles.colors
Typography = Styles.styles.typography



# Notification Generator
# --------------------------------------------------------------------------------

# Need to generate way to create/access layer for hover states


# Generate Simple { Gray } Notifcation -> Spawn top left, stacking
# header | copy | icon | CTA:bool | elemName
Simple = (content, CTA=false, elemName='element_notification') ->
	header = content.header
	copy = content.copy
	icon = content.icon

	console.log header
	
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

	fadeOutNotification(CTA, 10000)

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

	element_notification = new Layer
		name: elemName
		x: Align.left(25)
		y: Align.top(-64)
		width: 238
		height: 64
		borderRadius: 32
		opacity: 0

	element_notification.style.background = Colors.gradient.gray_0

	return element_notification


# Create Notification Hitbox, Left
generateHitboxLeft = (elem) ->
	element_notification_hitbox_left = new Layer
		parent: elem
		name: "hitbox_left"
		backgroundColor: "transparent"

	element_notification_hitbox_left.borderRadius = element_notification_hitbox_left.parent.borderRadius
	element_notification_hitbox_left.width = element_notification_hitbox_left.parent.height
	element_notification_hitbox_left.height = element_notification_hitbox_left.parent.height

	return element_notification_hitbox_left


# Create Notification Hitbox, Left BG
generateHitboxLeftBG = (elem, CTA) ->
	backgroundGradient = ''
	
	if (CTA)
		backgroundGradient = Colors.gradient.green_0
	else
		backgroundGradient = Colors.gradient.gray_1

	# Create Notification Hitbox, Left BG
	element_notification_hitbox_left_BG = new Layer
		parent: elem
		name: "hitbox_left_BG"
		width: 48
		height: 48
		borderRadius: 48
		x: Align.center
		y: Align.center

	element_notification_hitbox_left_BG.style.background = backgroundGradient

	return element_notification_hitbox_left_BG


# Create Notification Hitbox, Right
generateHitboxRight = (elem) ->
	element_notification_hitbox_right = new Layer
		parent: elem
		name: "hitbox_right"
		backgroundColor: "transparent"

	element_notification_hitbox_right.borderRadius = element_notification_hitbox_right.parent.borderRadius
	element_notification_hitbox_right.width = element_notification_hitbox_right.parent.height
	element_notification_hitbox_right.height = element_notification_hitbox_right.parent.height
	element_notification_hitbox_right.x = Align.right

	return element_notification_hitbox_right


# Create Notification Hitbox, Left Icon
generateHitboxLeftIcon = (elem, icon, CTA) ->
	icon = 'icons_' + icon.toString()

	element_notification_icon = ƒ(icon).copy()	
	element_notification_icon.parent = elem

	element_notification_icon.x = Align.center
	element_notification_icon.y = Align.center

	if (CTA)
		element_notification_icon.style["mixBlendMode"] = "multiply"


# Create Notification Hitbox, Right Close Icon
generateHitboxRightIcon = (elem, CTA) ->
	icon = 'icons_'
	
	# if (CTA)
	# 	icon += 'go_alt'
	# else
	icon += 'close'

	element_notification_hitbox_right_icon = ƒ(icon).copy()	
	element_notification_hitbox_right_icon.parent = elem
	element_notification_hitbox_right_icon.x = Align.center
	element_notification_hitbox_right_icon.y = Align.center


# Create Notification Header
generateHeader = (elem, headerCopy) ->
	element_notification_header = new TextLayer
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

	element_notification_header.parent = elem
	element_notification_header.name = "header"
	element_notification_header.x = 72
	element_notification_header.y = Align.center(-12)


# Create Notification Copy
generateCopy = (elem, copy) ->
	element_notification_copy = new TextLayer
		text: copy
		autoSize: true
		width: 112
		color: Colors.ui.gray_5
		textAlign: "left"
		fontSize: 9
		fontWeight: "600"
		lineHeight: 1.25
		fontFamily: "Source Sans Pro"

	element_notification_copy.parent = elem
	element_notification_copy.name = "copy"
	element_notification_copy.x = 72
	element_notification_copy.y = Align.center(4)


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


# Fade Out notification after timeOut
fadeOutNotification = (CTA, timer=10000) ->

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


# Recursively generate notifications
Generator = (options) ->
	
	# Notifcation Creation Functions
	makeNotification = 
		Simple: Simple
		Progress: Progress
		CTA: CTA

	notificationContents = setNotificationType(options)

	if (notificationContents)
		for name, create of makeNotification
			if (name == notificationContents.name)
					# Need to build a queue to deal with this
				elems = ƒƒ('element_notification*')
				if (elems.length < 3)
					console.log "Make Notifcation"
					create(notificationContents.content)
				else
					console.log "queue"


	recurGen = () ->
		Generator(options)
	
	timeOut = Utils.randomNumber(1000, 10000)
	window.setTimeout(recurGen, timeOut)


# Module Exports ------------------------------------------------------

exports.Generator = Generator






