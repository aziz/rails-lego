plugin 'hoptoad_notifier', :git => "git://github.com/thoughtbot/hoptoad_notifier.git"

hoptoad_api_key = ask("Please enter your hoptoad API key:")

initializer 'hoptoad.rb',
%Q{HoptoadNotifier.configure do |config|
  config.api_key = "#{hoptoad_api_key}"
end
}

rake "hoptoad:test"