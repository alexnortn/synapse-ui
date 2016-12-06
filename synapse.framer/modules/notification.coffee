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
	
	elem = ''
	elem2 = ''
	elem3 = ''

	elem = generateContainer(elemName, CTA)
	
	elem2 = generateHitboxLeft(elem)
	elem3 = generateHitboxLeftBG(elem2)

	elem2 = generateHitboxRight(elem)
	
	generateHitboxRightIcon(elem2, CTA)
	generateHitboxLeftIcon(elem3, icon)
	generateHeader(elem, header)
	generateCopy(elem, copy)

	# # Push Animations
	fadeInNotification(CTA)
	fadeOutNotification(CTA, animateOut, timer = 5)

# Generate Progress { Green } Progress Notifcation -> Spawn top left, stacking
# header | copy | icon 

Progress = (header, copy, progress) ->
	console.log "something"


# Generate CTA { Green } Notifcation -> Spawn bottom middle, only one at a time
# header | copy | icon | CTA:bool | elemName

CTA = (content) ->
	Simple(content, true, 'element_notification_CTA')


# Create Notification 
generateContainer = (elemName, CTA) ->
	x_prop = ''
	y_prop = ''

	if (CTA)
		x_prop = Align.center
		y_prop = Align.bottom(72)
	else
		x_prop = Align.left(72)
		y_prop = Align.top(-72)

	element_notification = new Layer
		name: elemName
		x: x_prop
		y: y_prop
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
		name: "element_notification_hitbox_left"
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
		name: "element_notification_hitbox_left_BG"
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
		name: "generateHitboxRight"
		backgroundColor: "transparent"

	element_notification_hitbox_right.borderRadius = element_notification_hitbox_right.parent.borderRadius
	element_notification_hitbox_right.width = element_notification_hitbox_right.parent.height
	element_notification_hitbox_right.height = element_notification_hitbox_right.parent.height
	element_notification_hitbox_right.x = Align.right

	return element_notification_hitbox_right


# Create Notification Hitbox, Left Icon
generateHitboxLeftIcon = (elem, icon) ->
	icon = 'icons_' + icon.toString()

	element_notification_icon = ƒ(icon).copy()	
	element_notification_icon.parent = elem
	element_notification_icon.x = Align.center
	element_notification_icon.y = Align.center


# Create Notification Hitbox, Right Close Icon
generateHitboxRightIcon = (elem, CTA) ->
	icon = 'icons_'
	
	if (CTA)
		icon += 'close'
	else
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
		letterSpacing: 2
		fontFamily: "Source Sans Pro"

	element_notification_header.parent = elem
	element_notification_header.name = "element_notification_header"
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
	element_notification_copy.name = "element_notification_copy"
	element_notification_copy.x = 72
	element_notification_copy.y = Align.center(4)


# Notification Animators
# --------------------------------------------------------------------------------


# Animate out 
animateOut = (CTA = false) ->
	if (CTA)
		# Target the CTA notifications
		elem = ƒ('element_notification_CTA')

		elem.animate
			opacity: 0
			y: -elem.y # Slide Notification back down 
			options:
            	time: 1

		# Remove notification element after animtion completes
		elem.onAnimationEnd -> elem.destroy()	
	else
		# Target all other notifications
		elems = ƒƒ('element_notification')

		elem_0 = elems[0]

		for elem in elems
			elem.animate
				y: (y + elem_0.y) # Push all notifications downward by height + initial offset
				options:
	            	time: 1

		elem_n = elems[elems.length - 1]
		elem_n.animate # Fadeout the final notification element
			opacity: 0
			options:
            	time: 1

    	# Remove notification element after animtion completes
		elem_n.onAnimationEnd -> elem_n.destroy()	


# Fade In notification immediately
fadeInNotification = (CTA) ->
	if (CTA)
		# Fade In notification from bottom middle
		elem = ƒ('element_notification_CTA')

		padding = 25
		offest = elem.height + padding

		elem.animate
			opacity: 1
			y: Align.bottom(-offest)
	else 
		# Fade in notification from top left + push all others
		elems = ƒƒ('element_notification')
		
		padding = 25
		offest = elems[0].height + padding

		elems[0].animate
			opacity: 1
			options:
				time: 1

		for elem in elems
			elem.animate
				y: (elem.y + offest)
				options:
					time: 1


# Fade Out notification after timeout
fadeOutNotification = (CTA, animateOut, timer = 5) ->
	setTimeout(animateOut(CTA), timer)


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
				create(notificationContents.content)


	recurGen = () ->
		Generator(options)
	
	timeOut = Utils.randomNumber(5000, 20000)
	window.setTimeout(recurGen, timeOut)


# Module Exports ------------------------------------------------------

exports.Generator = Generator






