crawler = require "./crawler"
spider = require "./spider"

class MySpider extends spider.Spider
	process: (results) ->
		console.log "MySpider processing.............."
		console.log item.getAttribute("title") for item in results
		console.log "MySpider processed.............."
address = "http://stackoverflow.com/"
selectors = ["a.question-hyperlink"]
depth = 3
crawler = new crawler.Crawler([new MySpider(address, selectors, depth)])
crawler.start()
