class ArticlesController < ApplicationController
	respond_to :html, :json
	def index
		urls = %w[http://topics.nytimes.com/top/news/health/diseasesconditionsandhealthtopics/psychology_and_psychologists/index.html?rss=1 http://www.mindful.org/rss]
		@feeds = Feedjira::Feed.fetch_and_parse urls
	end
end
