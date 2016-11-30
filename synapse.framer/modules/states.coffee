



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


exports.setupSlide = setupSlide
exports.setupFade = setupFade