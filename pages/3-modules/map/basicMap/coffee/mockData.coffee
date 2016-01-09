module.exports = ->
	locationsCount = Math.round 3*Math.random()+1
	locations = for i in [0 .. locationsCount]
		[
			(360*Math.random()-180)*(2*Math.round(Math.random())-1)
			(180*Math.random()-90)*(2*Math.round(Math.random())-1)
		]