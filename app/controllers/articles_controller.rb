class ArticlesController < ApplicationController
	respond_to :html, :json
	def index
		urls = %w[http://feeds2.feedburner.com/BpsResearchDigest http://daily.psychotherapynetworker.org/feed/ http://www.apa.org/monitor/monitor-rss.xml http://www.apa.org/news/psycport/psycport-rss.xml http://feeds.feedburner.com/PsychologyBlog http://feeds.socialpsychology.org/psychology-headlines http://topics.nytimes.com/top/news/health/diseasesconditionsandhealthtopics/psychology_and_psychologists/index.html?rss=1 http://www.mindful.org/rss]
		@feeds = Feedjira::Feed.fetch_and_parse urls
	end

	def show
		@title = params[:title]
		@link  = params[:url]
		# @share = ShareArticle.new
	end

	def share
		# raise params.inspect
		passed_params = {:title => params[:article_title], :url => params[:article_url], :name => params[:name], :email => params[:email]}
		# raise passed_params.inspect
		if current_user
			Resque.enqueue(ShareArticleJob, current_user.id, passed_params)
			# redirect_path = session[:return_to] || '/articles'
			redirect_to articles_path, notice: "The article has been shared"
		else
			redirect_to articles_path, alert: "Please sign-in to share articles"
		end
	end
end
