file 'public/javascripts/chrome-frame/CFInstall-1.0.2.min.js', 
  open('http://ajax.googleapis.com/ajax/libs/chrome-frame/1.0.2/CFInstall.min.js').read
file 'public/javascripts/chrome-frame/CFInstall-1.0.2.js', 
  open('http://ajax.googleapis.com/ajax/libs/chrome-frame/1.0.2/CFInstall.js').read

git :add => "."
git :commit => "-a -m 'Added Google Chrome Frame'"

puts "Note: Check to ensure you're using the lastest version of the javacript files!"
