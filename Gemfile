source "https://rubygems.org"

gem 'fastlane', '~>2.55.0'
gem 'xcpretty-json-formatter', '~>0.1.0'
gem 'danger', '~>5.3.3'
gem 'danger-swiftlint', '~>0.6.0'
gem 'danger-commit_lint', '~>0.0.6'
gem 'danger-xcode_summary', "~>0.3.0"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
