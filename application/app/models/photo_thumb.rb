class PhotoThumb < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :storage => :file_system, 
                 :partition => true,
                 :processor => 'Rmagick'

  validates_as_attachment
  
  def watermark
    return "75button.png"
  end
  
end
