require 'twitter'
    require 'dotenv'
    require 'pry'

Dotenv.load('.env')

def login_twitter
    client = Twitter::Streaming::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    client
end

client=login_twitter

def like_user(client)
    client.search('#bonjour_monde', result_type:"recent").take(25).each do |tweet|
    client.fav tweet
end

def follow_user(client)
    users=[]
    client.search("#bonjour_monde", :result_type=>"recent").each do |tweet|
        users << tweet.user.screen_name         
    end
    users = users.uniq
    login.follow(users)
end

def stream_like_follow(client)
    client.filter(track: "#bonjour_monde") do |object|
        like_user(client) && follow_user(client) if object.is_a?(Twitter::Tweet) end 
    end
end
binding.pry