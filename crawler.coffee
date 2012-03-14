class Crawler
	constructor: (@spiders) ->
	
	start: ->
		spider.start() for spider in @spiders
	
exports.Crawler = Crawler
