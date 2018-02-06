class Tweet
  attr_reader :username, :message
  @@all = []

  def initialize(params)
    @username = params['username']
    @message = params['message']
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end
end
