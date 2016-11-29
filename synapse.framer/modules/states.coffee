



# Consolidated states for hacking on Framer
# Alex Norton | 2016

# Intialized layer states
setup = (layers, sidebarWidth) ->	
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

exports.setup = setup