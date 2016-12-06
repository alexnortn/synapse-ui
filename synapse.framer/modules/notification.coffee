# Notifcation Generator for Framerjs
# Alex Norton | 2016



# Notification Generator
# --------------------------------------------------------------------------------


# Generate Simple { Gray } Notifcation
# header | copy | icon

Simple = (header, copy, icon) ->
	console.log "something"


# Generate CTA { Green } Notifcation
# header | copy | icon

CTA = (header, copy, icon) ->
	console.log "something"


# Generate CTA { Green } Progress Notifcation
# header | copy | icon 

Progress = (header, copy, icon) ->
	console.log "something"


# Notifcation Generator
generate = 
	Simple: Simple
	CTA: CTA
	Progress: Progress


# Create Notification 
element_notification = new Layer
	x: Align.center
	y: Align.center
	width: 238
	height: 64
	borderRadius: 32

element_notification.style.background = Colors.gradient.gray_0


# Create Notification Hitbox, Left
element_notification_hitbox_left = new Layer
	parent: element_notification
	backgroundColor: "transparent"

element_notification_hitbox_left.borderRadius = element_notification_hitbox_left.parent.borderRadius
element_notification_hitbox_left.width = element_notification_hitbox_left.parent.height
element_notification_hitbox_left.height = element_notification_hitbox_left.parent.height


# Create Notification Hitbox, Left BG
element_notification_hitbox_left_BG = new Layer
	parent: element_notification_hitbox_left
	width: 48
	height: 48
	borderRadius: 48
	x: Align.center
	y: Align.center

element_notification_hitbox_left_BG.style.background = Colors.gradient.gray_1


# Create Notification Hitbox, Left Icon
element_notification_icon = ƒ('icons_points').copy()	
element_notification_icon.parent = element_notification_hitbox_left_BG
element_notification_icon.x = Align.center
element_notification_icon.y = Align.center


# Create Notification Hitbox, Right
element_notification_hitbox_right = new Layer
	parent: element_notification
	backgroundColor: "transparent"

element_notification_hitbox_right.borderRadius = element_notification_hitbox_right.parent.borderRadius
element_notification_hitbox_right.width = element_notification_hitbox_right.parent.height
element_notification_hitbox_right.height = element_notification_hitbox_right.parent.height
element_notification_hitbox_right.x = Align.right


# Create Notification Hitbox, Right Close Icon
element_notification_close = ƒ('icons_close').copy()	
element_notification_close.parent = element_notification_hitbox_right
element_notification_close.x = Align.center
element_notification_close.y = Align.center


# Create Notification Header
element_notification_header = new TextLayer
	text: "Congrats"
	autoSize: true
	color: Colors.ui.gray_5
	textAlign: "left"
	textTransform: "uppercase"
	fontSize: 10
	fontWeight: "Bold"
	lineHeight: 1.15
	letterSpacing: 2
	fontFamily: "Source Sans Pro"

element_notification_header.parent = element_notification
element_notification_header.x = 72
element_notification_header.y = Align.center(-12)


# Create Notification Copy
element_notification_copy = new TextLayer
	text: "Find a merger in the current overview cell."
	autoSize: true
	width: 112
	color: Colors.ui.gray_5
	textAlign: "left"
	fontSize: 9
	fontWeight: "600"
	lineHeight: 1.25
	fontFamily: "Source Sans Pro"

element_notification_copy.parent = element_notification
element_notification_copy.x = 72
element_notification_copy.y = Align.center(4)





# Module Exports ------------------------------------------------------

exports.generate = generate






