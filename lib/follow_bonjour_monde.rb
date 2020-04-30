require 'twitter'
    require 'dotenv'
    require 'pry'

Dotenv.load('.env')

def login_twitter
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    client
end

client = login_twitter
def follow_user(login)
    users=[]
    login.search("#bonjour_monde", :result_type=>"recent").take(100).each do |tweet|
        users << tweet.user.screen_name         
    end
    users = users.uniq
    login.follow(users[0,20])
end
binding.pry