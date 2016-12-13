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
queue = []
exiting = false
pushing = false
_clear = false


placeHolder = (section) ->

	text = "There are no new messages at this time."

	filler = new TextLayer
		text: text
		name: "filler_text"
		color: Colors.ui.gray_4
		textAlign: "center"
		autoSizeHeight: true
		fontSize: 10
		fontWeight: 400
		lineHeight: 1.15
		fontFamily: "Source Sans Pro"

	filler.parent = section
	filler.width = 124
	filler.x = Align.center
	filler.y = Align.center

	section.height = 168 # Reset section height


# Function to generate announcement based on input from < Notification Generator >
Generate = (container) ->

	# Target view to populate
	sections = container.ƒƒ('section*')

	# For each section, (initially) populate < no messages at this time >
	for section in sections
		placeHolder(section) # Create placehold text

	# container a func that populates the stack
	(content) ->
		console.log('make announcement type: ' + content)


# Clean up layer upon user interaction
resolve = (layer) ->
	console.log('resolve')


# Module Exports ------------------------------------------------------

exports.Generate = Generate




