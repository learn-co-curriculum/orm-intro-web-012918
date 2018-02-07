require 'bundler'
Bundler.require

# DB = {
#   conn: SQLite3::Database.new('db/twitter.db'),
#   name: 'Twitter'
# }

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: 'db/twitter.db'
  })


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

# DB[:conn].results_as_hash = true


require_relative '../lib/dynamic_record.rb'
require_relative '../lib/tweet.rb'
require_relative '../lib/user.rb'
require_relative '../lib/tweets_app.rb'
