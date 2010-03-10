class Pref < ActiveRecord::Base
  belongs_to :user
  
  
  before_create :make_submission_email
  
  def make_submission_email
    size = 4
    email = email_gen(size)
    exist = Pref.find_by_submission_email(email)
    if exist != nil
      while exist != nil
        size+=size
        email = email_gen(size)
        exist = Pref.find_by_submission_email(email)
      end
    end
    self.submission_email = email
  end
      
  
  def email_gen(size = 4)
    c = %w(b c d f g h j k l m n p qu r s t v w x z ch cr fr nd ng nk nt ph pr rd sh sl sp st th tr)
    v = %w(a e i o u y)
    f, r = true, ''
    (size * 2).times do
      r << (f ? c[rand * c.size] : v[rand * v.size])
      f = !f
    end
    r
  end
  
end
