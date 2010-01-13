gem 'will_paginate', :version => ">= 2.3.11", :source => 'http://gemcutter.org'

file "public/stylesheets/pagination.css",
  open("http://github.com/mislav/will_paginate/raw/master/examples/pagination.css").read
  
git :add => "."
git :commit => "-a -m 'Added will paginate gem'"
