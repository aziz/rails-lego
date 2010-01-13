# Install Typus and friends.
plugin 'typus', :git => 'git://github.com/fesplugas/typus.git'
plugin 'acts_as_list', :git => 'git://github.com/rails/acts_as_list.git'
plugin 'acts_as_tree', :git => 'git://github.com/rails/acts_as_tree.git'

# Gems
gem 'paperclip' , :source => "http://gemcutter.org/"
gem "formtastic", :source => "http://gemcutter.org/"

# Run generators.
generate("scaffold", 
         "Asset asset_file_name:string asset_content_type:string asset_file_size:integer asset_updated_at:datetime", 
         "--skip-timestamps")
generate("scaffold", 
        "Category name:string parent_id:integer", 
        "--skip-timestamps")
generate("scaffold", 
         "Page title:string body:text published:boolean position:integer", 
         "--skip-timestamps")
generate("scaffold", 
         "Post title:string body:text published:boolean category_id:integer", 
         "--skip-timestamps")

# Define models.

file 'app/models/asset.rb', <<-CODE
class Asset < ActiveRecord::Base

  has_attached_file :asset, :styles => { :typus_preview => "692x461>", :typus_thumbnail => "100x100>" }
  validates_attachment_presence :asset

end
CODE

file 'app/models/category.rb', <<-CODE
class Category < ActiveRecord::Base

  validates_presence_of :name
  has_many :posts

end
CODE

file 'app/models/page.rb', <<-CODE
class Page < ActiveRecord::Base

  acts_as_list

  validates_presence_of :title

end
CODE

file 'app/models/post.rb', <<-CODE
class Post < ActiveRecord::Base
 
  validates_presence_of :title
  belongs_to :category

  def typus_name
    title
  end

end
CODE

# Run the migrations and set the routes.

rake 'db:migrate'
run "rm public/index.html"
route "map.root :controller => 'posts'"

# Run the Typus generator and migrate.
generate 'typus'
rake 'db:migrate'

# This file is used as a hack to avoid the detection of children and 
# parent relationships.

file 'app/models/category.rb', <<-CODE
class Category < ActiveRecord::Base

  acts_as_tree :order => 'name'

  validates_presence_of :name
  has_many :posts

end
CODE