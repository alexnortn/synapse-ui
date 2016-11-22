



# Helper scripts for hacking on Framer
# Alex Norton | 2016


# Convert valueless Framer units to pixel space
# (i.e.) "223" => "223px"
pxify = (val) =>
	return val += "px"

exports.pxify = pxify