modules = [
  ["basic",       "Do basic setup? (recommended)"],
  ["couchdb",     "Use CouchDB?"],  
  ["rspec",       "Use RSpec instead of test/unit?"],
  ["haml",        "Use haml for views and sass for css?"],
  ["jquery",      "Use jQuery instead of Prototype + Script.aculo.us?"],
  ["chromeframe", "Do you want to install Google chrome frame javascript files?"],  
  ["auth",        "Add authentication module?"],
  ["formtastic",  "Use formtastic to generate forms?"],
  ["willpaginate","Use will_paginate?"],
  ["hoptoad",     "Use Hoptoad error notifier?"],  
  ["rpm",         "Install NewRelic RPM?"],    
  ["misc",        "Add miscellaneous stuff (helpers, basic layout, initializers)?"],
  ["heroku",      "Do you want to deploy to heroku?"],
  ["locale",      "Add specific localizations?"],    
]

#run "sudo gem install term-ansicolor --no-ri --no-rdoc"
require 'term/ansicolor' 
String.send(:include,Term::ANSIColor)

logo = <<-LOGO
   ___              _       _                       _               __ _          
  | _ \\   __ _     (_)     | |     ___      o O O  | |      ___    / _` |   ___   
  |   /  / _` |    | |     | |    (_-<     o       | |__   / -_)   \\__, |  / _ \\  
  |_|_\\  \\__,_|   _|_|_   _|_|_   /__/_   TS__[O]  |____|  \\___|   |___/   \\___/  
_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| {======|_|"""""|_|"""""|_|"""""|_|"""""| 
"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' 
___________________________________________________________________________________
LOGO

tnx = <<-TNX
   Thanks for Using Rails Lego, you can add your own legos and share it with 
   other to play with!

   fork me on github:  http://github.com/aziz/rails-legos  
TNX

# environment options
@lego_options = ENV['LEGOS'] ? ENV['LEGOS'].downcase.split(/[,\s]+/) : false
@used_legos = []

def use_lego?(lego, question)
  use = if @lego_options
    @lego_options.include?(lego)
  else
    yes?(question)
  end
  @used_legos << lego if use
  use
end

# braid helpers
system('clear')
puts logo.red.bold  
if use_lego?("braid", "Use braid for vendor management?")
  def braid(repo, dir, type=nil)
    run "braid add #{"-t #{type} " if type}#{repo} #{dir}"
  end

  def plugin(name, options)
    log "braid plugin", name

    if options[:git] || options[:svn]
      in_root do
        `braid add -p #{options[:svn] || options[:git]}`
      end
    else
      log "! no git or svn provided for #{name}. skipping..."
    end
  end
end

# loading modules
system('clear')
puts logo.red.bold  
if @lego_options or yes?("Do you want to play LEGO?")
  all_yes = @lego_options ? false : yes?("Install everything without question?")

  @base_path = if template =~ %r{^(/|\w+://)}
    File.dirname(template)
  else
    log '', "You used the app generator with a relative template path."
    ask "Please enter the full path or URL where the modules are located:"
  end

  modules.each do |modul, question|
    if all_yes or use_lego?(modul, question)
      tmpl = "#{@base_path}/plugins/#{modul}.rb"
      log "applying", "template: #{tmpl}"
      load_template(tmpl)
      log "applied", tmpl      
    end
    system('clear')
    puts logo.red.bold      
  end
end

# finalizing 
system('clear')
puts logo.red.bold
puts tnx.yellow