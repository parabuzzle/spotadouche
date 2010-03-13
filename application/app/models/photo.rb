class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  attr_accessor :forceup
  
  acts_as_rated :with_stats_table => true
  acts_as_ferret :fields => [ :title, :description, :location, :status ]  
  
  has_attachment :content_type => :image, 
                 :max_size => 50.megabytes,
                 :storage => :file_system, 
                 :resize_to => '600',
                 :thumbnail_class => PhotoThumb,
                 :thumbnails => { :thumb => '100x100>', :small => '250x250>', :medium => '400' },
                 :partition => true,
                 :processor => 'Rmagick'

  validates_as_attachment
  validates_presence_of :location
  validates_presence_of :title
  validates_presence_of :description
  validate :terms_accepted
  
  def loc
    if location.nil? || location.empty?
      return "Unknown"
    else
      return location
    end
  end
  
  def via
    if source.nil? || source.empty?
      return "Web"
    else
      return source
    end
  end
  
  def terms_accepted
    if terms_acceptence != true
      unless forceup == 'true' then errors.add_to_base("You must accept the terms to upload your photo") end
    end
  end
  
  # Status map
  
  def status?
    if status == 0
      return "pending"
    elsif status == 1
      return "rejected"
    elsif status == 2
      return "deleted"
    elsif status == 5
      return "approved"
    end
  end
  
  # Rating Reference
  # class Book < ActiveRecord::Base
  #   acts_as_rated
  # end
  # 
  # bill = User.find_by_name 'bill'
  # jill = User.find_by_name 'jill'
  # catch22 = Book.find_by_title 'Catch 22'
  # hobbit  = Book.find_by_title 'Hobbit'
  # 
  # catch22.rate 5, bill
  # hobbit.rate  3, bill
  # catch22.rate 1, jill
  # hobbit.rate  5, jill
  # 
  # hobbit.rating_average # => 4
  # hobbit.rated_total    # => 8
  # hobbit.rated_count    # => 2
  # 
  # hobbit.unrate bill
  # hobbit.rating_average # => 5
  # hobbit.rated_total    # => 5
  # hobbit.rated_count    # => 1
  # 
  # bks = Book.find_by_rating 5     # => [hobbit]
  # bks = Book.find_by_rating 1..5  # => [catch22, hobbit]
  # 
  # usr = Book.find_rated_by jill   # => [catch22, hobbit]
  
  
  
end
