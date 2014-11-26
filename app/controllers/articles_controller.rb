class ArticlesController < ApplicationController
	respond_to :html, :json
	def index
		urls = %w[http://feeds2.feedburner.com/BpsResearchDigest http://daily.psychotherapynetworker.org/feed/ http://www.apa.org/monitor/monitor-rss.xml http://www.apa.org/news/psycport/psycport-rss.xml http://feeds.feedburner.com/PsychologyBlog http://feeds.socialpsychology.org/psychology-headlines http://topics.nytimes.com/top/news/health/diseasesconditionsandhealthtopics/psychology_and_psychologists/index.html?rss=1 http://www.mindful.org/rss]
		@feeds = Feedjira::Feed.fetch_and_parse urls
	end
end
