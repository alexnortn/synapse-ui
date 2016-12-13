



# Consolidated states for hacking on Framer
# Alex Norton | 2016

# Sidebar Open/Close
setupSlide = (layers, sidebarWidth) ->	
	for layer in layers
		# Sidebar Open
		layer.states.open =
			x: layer.x
			y: 0
			animationOptions:
				curve: "spring(200, 17.5, 0)"
		# Sidebar Close
		layer.states.close = 
			x: layer.x + sidebarWidth
			y: 0	
			animationOptions:
				curve: "spring(200, 17.5, 0)"


# Sidebar Open/Close
setupSlideOnce = (layer, sidebarWidth) ->	
	# Sidebar Open
	layer.states.open =
		x: layer.x
		y: 0
		animationOptions:
			curve: "spring(200, 17.5, 0)"
	# Sidebar Close
	layer.states.close = 
		x: layer.x + sidebarWidth
		y: 0	
		animationOptions:
			curve: "spring(200, 17.5, 0)"


# Toggle opacity for all Navbar tiles
setupFade = (layers) ->	
	for layer in layers
		# FadeOut
		layer.states.transparent =
			opacity: 0
			animationOptions : curve: "ease", time: 0.25
		# FadeIn
		layer.states.visible = 
			opacity: 1
			animationOptions: curve: "ease", time: 0.25


# Toggle opacity for single layer
setupFadeOnce = (layer) ->	
	# FadeOut
	layer.states.transparent =
		opacity: 0
		animationOptions : curve: "ease", time: 0.25
	# FadeIn
	layer.states.visible = 
		opacity: 1
		animationOptions: curve: "ease", time: 0.25
	# Translucent
	layer.states.translucent = 
		opacity: 0.25
		animationOptions: curve: "ease", time: 0.25


# Push right for single layer
setupTogglePush = (layer) ->	
	offset = 4
	
	layer.states.pushRight =
		x: (offset + layer.x)
		animationOptions : curve: "spring(250, 25, 0)", time: 0.25

	layer.states.pushLeft =
		x: (layer.x - offset)
		animationOptions : curve: "spring(250, 25, 0)", time: 0.25


exports.setupSlide = setupSlide
exports.setupSlideOnce = setupSlideOnce
exports.setupFade = setupFade
exports.setupFadeOnce = setupFadeOnce
exports.setupTogglePush = setupTogglePush















