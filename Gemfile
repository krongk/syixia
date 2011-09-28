source 'http://rubygems.org'

gem 'rails', '3.1.0'

#==database
  gem 'sqlite3'
# gem 'pg', '0.9.0'
#-- mysql2 on Windows
# 1. download mysql-connector http://dev.mysql.com/downloads/mirror.php?id=377978#mirrors and extract to c:/
# 2. Git bash run > gem i mysql2 -- --with-mysql-dir="c:\mysql-connector-c-noinstall-6.0.2-win32"
# 3. also faild with mysql connection
	# gem 'mysql2', '0.3.7'

#==other
gem 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git'
gem 'htmlentities'

#==forager
gem 'mechanize', '2.0.1'
gem 'hpricot', '0.8.4'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
  gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
