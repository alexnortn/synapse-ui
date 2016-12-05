# CSS-like properties for Framerjs
# Alex Norton | 2016

styles = {}


# Typography --------------------------------------------------------

styles.h4 =  # Works nicely with gray-5
	prop:
		name: "font-family",
		value: "Source Sans Pro"
	prop:
		name: "font-weight",
		value: 600
	prop:
		name: "font-size",
		value: "14px"
	prop:
		name: "text-align",
		value: "left"
	prop:
		name: "text-transform",
		value: "uppercase"
	prop:
		name: "letter-spacing",
		value: "2px"
	prop:
		name: "line-height",
		value: "2em"

styles.p = # Works nicely with gray-5
	prop:
		name: "font-family",
		value: "Source Sans Pro"
	prop:
		name: "font-weight",
		value: 600
	prop:
		name: "font-size",
		value: "9px"
	prop:
		name: "text-align",
		value: "left"
	prop:
		name: "line-height",
		value: "1.1em"


# Color --------------------------------------------------------

styles.colors.ui = 
	"gray-0" : "#16171A",
	"gray-1" : "#181A1E",
	"gray-2" : "#1C1F26",
	"gray-3" : "#262A33",
	"gray-4" : "#303540",
	"gray-5" : "#6F747F",
	"gray-6" : "#8E949B",
	"gray-7" : "#A9AEB5",
	"gray-8" : "#CED4D9",
	"gray-9" : "#EEF1F3",
	"gray-10" : "#FAFEFF"

styles.colors.accent = 
	"green-0" : "#6CD9A7",
	"purple-0" : "#B36CD9",
	"yellow-0" : "#FFE798",
	"yellow-1" : "#FFDF73",
	"red-0" : "#D96C6C",
	"red-1" : "#C85A5A",
	"blue-0" : "#78BEF1",
	"blue-1" : "#5A98C7"

styles.colors.gradient = 
	"gray-0" : "webkit-linear-gradient(0deg, #2A2C34, #24262E)",
	"gray-1" : "webkit-linear-gradient(0deg, #2A2C34, #24262E)",
	"gray-2" : "webkit-linear-gradient(0deg, #5D6574, #303540)",
	"gray-3" : "webkit-linear-gradient(0deg, #9DA2AB, #646873)",
	"green-0" : "webkit-linear-gradient(0deg, #82D99E, #66CC7F)"


# Apply Styles --------------------------------------------------------

applyStyle = (style) -> # Accepts an opject with property objects
	if (style.constructor != Array) # Parse Array
		print "Please pass in an array of properties"
		return
	
	for prop in style
		this.style[prop.name] = prop.value


# Need to build a styles parser
exports.styles = styles
exports.applyStyle = applyStyle














