



# Helper scripts for hacking on Framer
# Alex Norton | 2016


# Convert valueless Framer units to pixel space
# (i.e.) "223" => "223px"
pxify = (val) =>
	return val += "px"

exports.pxify = pxify


# Maintain consistency + precision between Sketch and Framer wrt scaling 
# (i.e.) "223" | "2x" => "446"
scalify = (scaleFactor) =>
	(val) => val * scaleFactor

exports.scalify = scalify


# scalify = ( function(scaleFactor) {
# 	return function (val) {
# 		return val * scaleFactor;
# 	}
# }


