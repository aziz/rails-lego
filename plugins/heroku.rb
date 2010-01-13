file '.gems',<<-MAN 
# put your gem list here 
MAN

# do other prepration stuff for Heroku Deployment

git :add => "."
git :commit => "-m 'Added Gem Manifest for Heroku'"