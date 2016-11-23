



# Consolidated states for hacking on Framer
# Alex Norton | 2016

# Intialized layer states
setup = (layers) ->	
	# Sidebar Open
	layers.Sidebar.states.open =
		x: layers.Sidebar.x
		y: 0
	# Sidebar Close
	layers.Sidebar.states.close = 
		x: layers.Sidebar.x + layers.Sidebar.width
		y: 0	
	# Navbar Open
	layers.Navbar.states.open =
		x: layers.Navbar.x
		y: 0
	# Sidebar Close
	layers.Navbar.states.close = 
		x: layers.Navbar.x + layers.Sidebar.width
		y: 0


exports.setup = setup