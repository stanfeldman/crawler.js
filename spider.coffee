zombie = require "zombie"

class Spider
	constructor: (@start_url, @selectors, @depth=3) ->
		@urls = [@start_url]
		@new_urls = []
		@visited_urls = []
		@document = null
		@current_depth = 0
	
	start: ->
		@urls.push item for item in @new_urls
		@new_urls = []
		for url in @urls
			@fetch url
			
	fetch: (url) ->
		browser = new zombie({ debug: false, loadCSS: false })
		browser.visit url, =>
			console.log "url: #{url}, depth: #{@current_depth}"
			results = []
			for selector in @selectors
				results.push item for item in browser.queryAll selector
			if results and results.length > 0
				@process results
			@visited_urls.push url
			@grab_links browser
			if @visited_urls.length == @urls.length and @current_depth < @depth
				@current_depth += 1
				@start()
		
	grab_links: (browser)->
		for link in browser.queryAll "a"
			hr = link.getAttribute "href"
			if hr and (@is_url hr) and (@visited_urls.indexOf(hr) is -1)
				@new_urls.push hr
				
	is_url: (s) ->
		/(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/.test(s)
	
exports.Spider = Spider
