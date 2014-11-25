class ArticlesController < ApplicationController
	respond_to :html, :json
	def index
		urls = %w[http://daily.psychotherapynetworker.org/feed/ http://www.apa.org/monitor/monitor-rss.xml http://www.apa.org/news/psycport/psycport-rss.xml http://content.apa.org/journals/cdp.rss http://content.apa.org/journals/sgd.rss http://feeds.socialpsychology.org/psychology-headlines http://topics.nytimes.com/top/news/health/diseasesconditionsandhealthtopics/psychology_and_psychologists/index.html?rss=1 http://www.mindful.org/rss]
		@feeds = Feedjira::Feed.fetch_and_parse urls
	end
end
