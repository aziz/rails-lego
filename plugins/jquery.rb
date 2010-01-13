git :rm => "public/javascripts/*"

file 'public/javascripts/jquery-1.3.2.min.js', 
  open('http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js').read
file 'public/javascripts/jquery-1.3.2.js', 
  open('http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.js').read
file 'public/javascripts/jquery-ui-1.7.2.min.js', 
  open('http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js').read
file 'public/javascripts/jquery-ui-1.7.2.js', 
  open('http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js').read

file "public/javascripts/application.js", <<-JS
$(function() {
  // ...
});
JS

git :add => "."
git :commit => "-a -m 'Added jQuery with UI'"
