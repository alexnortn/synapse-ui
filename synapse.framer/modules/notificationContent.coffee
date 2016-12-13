# Content for Notification Generator for Framerjs
# Alex Norton | 2016

content =
	CTA: {}
	Simple: {}
	# Progress: {}


content.CTA =
	complete1:
		header: "Complete"
		copy: "We need some players to help us finish cell 10001."
		icon: "points"
		duration: 30000
		type: "event"
	complete4:
		header: "Complete"
		copy: "We need some players to help us finish cell 10004."
		icon: "points"
		duration: 30000
		type: "event"
	complete5:
		header: "Complete"
		copy: "We need some players to help us finish cell 10005."
		icon: "points"
		duration: 30000
		type: "event"
	complete5:
		header: "Compete"
		copy: "Join this new competition."
		icon: "reward"
		duration: 30000
		type: "event"
	complete5:
		header: "Announcement"
		copy: "Remember to keep it all-ages in chat!  Chat rules here."
		icon: "help"
		duration: 30000
		type: "notice"
	complete5:
		header: "Announcement"
		copy: "Watch here to improve your accuracy to perfection!"
		icon: "help"
		duration: 30000
		type: "event"
	bigNews1:
		header: "Big News"
		copy: "Eyewire just published a paper on xyz."
		icon: "explore"
		duration: 30000
		type: "notice"
	bigNews2:
		header: "Big News"
		copy: "We just completed sector 5 in The Dig."
		icon: "explore"
		duration: 30000
		type: "notice"
	# bigNews3:
	# 	header: "Big News"
	# 	copy: "The NYT features Eyewire in their article on how citizen science is changing the world."
	# 	icon: "explore"
	# 	duration: 30000
	type: "notice"
	forScience:
		header: "For Science!"
		copy: "Scientists disvoer a new planet"
		icon: "explore"
		duration: 30000
		type: "notice"


content.Simple =
	# maintenance:
	# 	header: "Maintenance"
	# 	copy: "Eyewire is currently performing maintenance.  You may experience some downtime during the next xx minutes."
	# 	icon: "settings"
	# 	duration: 10000
	type: "notice"
	# technicaDifficulties:
	# 	header: "Technical Difficulties"
	# 	copy: "Grim got stuck in the servers again!  We’ll get this sorted in a jiffy. In the meantime panda cam should keep you entertained."
	# 	icon: "settings"
	duration: 10000
	type: "notice"
	update:
		header: "Update"
		copy: "A newer, shinier version of Eyewire is coming your way!"
		icon: "settings"
		duration: 10000
		type: "notice"
	welcomeBack:
		header: "Welcome Back"
		copy: "While you were gone, you earned xx retro points."
		icon: "reward"
		duration: 10000
		type: "achievement"
	welcomeBack:
		header: "Welcome Back"
		copy: "Your current accuracy is xx."
		icon: "reward"
		duration: 10000
		type: "achievement"
	topPlayer:
		header: "Top Player"
		copy: "You were yesterday’s top player with xxxxx points!"
		icon: "reward"
		duration: 10000
		type: "achievement"
	topTen:
		header: "Top Ten"
		copy: "You were in the top 10 players for this month at #7!"
		icon: "reward"
		duration: 10000
		type: "achievement"
	badge1:
		header: "Badge Awarded"
		copy: "For tracing faster than you can say OMCS."
		icon: "badge"
		duration: 10000
		type: "achievement"
	badge2:
		header: "Promotion"
		copy: "You have been promoted to the role of scout."
		icon: "reward"
		duration: 10000
		type: "achievement"




# Module Exports ------------------------------------------------------

exports.content = content