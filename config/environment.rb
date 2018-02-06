require 'bundler'
Bundler.require

DB = {
  conn: SQLite3::Database.new('db/twitter.db'),
  name: 'Twitter'
}

# module SQLite3
#   class Database
#     def initialize(argument)
#       @argument = argument
#     end
#
#     def execute
#
#     end
#
#     def results_as_hash
#
#     end
#   end
# end

DB[:conn].results_as_hash = true


require_relative '../lib/tweet.rb'
require_relative '../lib/user.rb'
require_relative '../lib/tweets_app.rb'
