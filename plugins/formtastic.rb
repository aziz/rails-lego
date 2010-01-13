gem 'formtastic', :lib => 'formtastic'

rake "gems:install", :sudo => true

generate "formtastic"

git :add => "."
git :commit => "-m 'added formtastic'"