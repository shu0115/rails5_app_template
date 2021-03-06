template_path = "#{File.dirname(__FILE__)}/templates"

# ---------- Install Gem ---------- #
# Comment Out
comment_lines 'Gemfile', "gem 'sqlite3'"

# Utilities
gem 'minimum-omniauth-scaffold'
gem 'action_args'
gem 'html5_validators'
gem 'kaminari'
gem 'config'
gem 'tapp-awesome_print'
gem 'i18n_generators'
gem 'exception_notification'
gem 'faml'
gem 'haml-rails'  # For scaffold generate haml template
gem 'ridgepole'

# Markdown & Syntax Highlight
gem 'redcarpet'
gem 'coderay'

# Development
gem_group :development do
  gem 'pry-rails'
#   gem 'better_errors'
#   gem 'binding_of_caller'
  gem 'colorize_unpermitted_parameters'
#   gem 'rails-flog', require: 'flog'
  gem 'bullet'
  gem 'letter_opener'
  gem 'letter_opener_web'
end

# Development and Test
gem_group :development, :test do
  gem 'sqlite3'
  # gem 'rspec-rails'
end

# Production
gem_group :production do
  # gem 'rails_12factor'
  gem 'pg'
  gem 'newrelic_rpm'
  # gem 'heroku-deflater'
end

# ---------- Assets ---------- #
# Replace application.js
# remove_file "app/assets/javascripts/application.js"
# content =  "//= require opal\n"
# content += "//= require opal_ujs\n"
# content += "//= require_tree .\n"
# create_file "app/assets/javascripts/application.js.rb", content.force_encoding('ASCII-8BIT')

# ---------- Config ---------- #
## Procfile
content = "web: bundle exec puma -C config/puma.rb\n"
create_file 'Procfile', content.force_encoding('ASCII-8BIT')

## puma.rb
# content = Net::HTTP.get URI.parse('https://raw.githubusercontent.com/shu0115/rails4_app_template/master/templates/config/puma.rb')
# create_file 'config/puma.rb', content.force_encoding('ASCII-8BIT')

## database_connection.rb
# content = Net::HTTP.get URI.parse('https://raw.githubusercontent.com/shu0115/rails4_app_template/master/templates/config/initializers/database_connection.rb')
# create_file 'config/initializers/database_connection.rb', content.force_encoding('ASCII-8BIT')

## application.rb
#insert_into_file "config/application.rb", "    config.i18n.default_locale     = :ja\n    I18n.enforce_available_locales = false\n", after: "# -- all .rb files in that directory are automatically loaded.\n"
content = "    config.time_zone = 'Tokyo'\n"
insert_into_file "config/application.rb", content.force_encoding('ASCII-8BIT'), after: "# -- all .rb files in that directory are automatically loaded.\n"

# content += "    # For Opal - These are the available options with their default value:\n"
# content += "    config.opal.method_missing      = true\n"
# content += "    config.opal.optimized_operators = true\n"
# content += "    config.opal.arity_check         = false\n"
# content += "    config.opal.const_missing       = true\n"
# content += "\n"
# insert_into_file "config/application.rb", content.force_encoding('ASCII-8BIT'), after: "class Application < Rails::Application\n"

## production.rb
insert_into_file "config/environments/production.rb", "  config.force_ssl = true\n", after: "# config.force_ssl = true\n"  # 強制SSL設定

# ## development.rb
# gsub_file "config/environments/development.rb", /(config.assets.debug = true)+/, "# config.assets.debug = true"                  # コメントアウト追加
# insert_into_file "config/environments/development.rb", "  config.assets.debug = false\n", after: "config.assets.debug = true\n"  # false設定追加
content =  "\n"
content += "  # メーラ設定\n"
content += "  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }\n"
content += "  config.action_mailer.delivery_method     = :letter_opener\n"
insert_into_file "config/environments/development.rb", content.force_encoding('ASCII-8BIT'), after: "config.file_watcher = ActiveSupport::EventedFileUpdateChecker\n"

## Add Strong Parameters config
insert_into_file "config/environments/development.rb",
  "\n  # Strong Parametersエラー例外発生\n  config.action_controller.action_on_unpermitted_parameters = :raise\n",
  after: "# config.action_view.raise_on_missing_translations = true\n"

# ## rails-flog
# create_file 'tmp/no-flog-sql.txt'

## session_store.rb
create_file 'config/initializers/session_store.rb', open(template_path + '/initializers/session_store.rb').read

## routes.rb
insert_into_file "config/routes.rb", "\n  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?\n", after: "  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\n"

# ---------- Gemfile ---------- #
# # Ruby Version Insert
# insert_into_file "Gemfile",
#   "ruby '2.3.3'\n",
#   after: "source 'https://rubygems.org'\n"

# Gem Install
run 'bundle install --without production'

insert_into_file "Gemfile", " \n", after: "gem 'coderay'\n"

# Migration
create_file 'db/Schemafile', open(template_path + '/db/Schemafile').read
create_file 'db/config.yml', open(template_path + '/db/config.yml').read
run 'bundle exec ridgepole --config db/config.yml --file db/Schemafile --apply'

# ---------- RSpec ---------- #
# Generate Command
# run "rails generate rspec:install"

# ---------- Git ---------- #
git :init
git add: '-A'
git commit: '-m "Initial commit"'
