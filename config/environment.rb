ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
# binding.pry
# Dir[File.join(File.dirname(__FILE__), "app/controllers", "*.rb")].collect {|file| File.basename(file).split(".")[0] }.reject {|file| file == "application_controller" }.each do |file|
#   string_class_name = file.split('_').collect { |w| w.capitalize }.join
#   class_name = Object.const_get(string_class_name)
#   use class_name
# end

# Dir[File.join(File.dirname(__FILE__), "app/controllers", "*.rb")].each{|file| require_relative file}
# require_relative '../app/controllers/application_controller.rb'
# require_relative '../app/controllers/album_controller.rb'
require_all 'app'