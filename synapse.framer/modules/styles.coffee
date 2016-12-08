# CSS-like properties for Framerjs
# Alex Norton | 2016

# Top level objects
styles =
	typography: {}
	colors: {}


# Typography --------------------------------------------------------

styles.typography.h4 =  # Works nicely with gray-5
	"font-family": "Source Sans Pro",
	"font-weight": 600,
	"font-size": "14px",
	"text-align": "left",
	"text-transform": "uppercase",
	"letter-spacing": "2px",
	"line-height": "2em"

styles.typography.p = # Works nicely with gray-5
	"font-family": "Source Sans Pro",
	"font-weight": 600,
	"font-size": "9px",
	"text-align": "left",
	"line-height": "1.1em"


# Color --------------------------------------------------------

styles.colors.ui = 
	gray_0 : "#16171A",
	gray_1 : "#181A1E",
	gray_2 : "#1C1F26",
	gray_3 : "#262A33",
	gray_4 : "#303540",
	gray_5 : "#6F747F",
	gray_6 : "#8E949B",
	gray_7 : "#A9AEB5",
	gray_8 : "#CED4D9",
	gray_9 : "#EEF1F3",
	gray_10 : "#FAFEFF"

styles.colors.accent = 
	green_0 : "#6CD9A7",
	purple_0 : "#B36CD9",
	yellow_0 : "#FFE798",
	yellow_1 : "#FFDF73",
	red_0 : "#D96C6C",
	red_1 : "#C85A5A",
	blue_0 : "#78BEF1",
	blue_1 : "#5A98C7"

styles.colors.gradient = 
	gray_0 : "-webkit-linear-gradient( top, #1F2126, #1C1E23 )",
	gray_1 : "-webkit-linear-gradient( top, #282A2E, #1F2123 )",
	gray_2 : "-webkit-linear-gradient( top, #5D6574, #303540 )",
	gray_3 : "-webkit-linear-gradient( top, #9DA2AB, #646873 )",
	gray_0A025 : "-webkit-linear-gradient( top, rgba(157,162,171,0.025), rgba(100,105,115,0.025) )",
	gray_0A75 : "-webkit-linear-gradient( top, rgba(31,33,38,0.75), rgba(28,30,35,0.75) )",
	green_0 : "-webkit-linear-gradient( top, #82D99E, #66CC7F )"


# Apply Styles --------------------------------------------------------

applyStyle = (layer, style) -> # Accepts an opject with property objects

	for name, prop of style
		layer.style[name] = prop


# Apply Propertry -----------------------------------------------------

applyProperty = (layer, property, value) -> # Accepts an opject with property objects
	layer.style[property] = value # Need to get name of object


# Module Exports ------------------------------------------------------

exports.styles = styles
exports.applyStyle = applyStyle
exports.applyProperty = applyProperty









