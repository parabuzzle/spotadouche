class Avatar < ActiveRecord::Base
  belongs_to :user
  
  has_attachment :content_type => :image, 
                 :max_size => 50.megabytes,
                 :storage => :file_system, 
                 :resize_to => '400',
                 :thumbnails => { :thumb => '150x150>' },
                 :partition => true,
                 :processor => 'Rmagick'
                 
  validates_as_attachment
  
  
end
