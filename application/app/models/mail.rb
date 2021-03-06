class Mail < ActionMailer::Base
  
@@mail = SITE_PROPS['admin']['email']

  def welcome(user)
    recipients user.email
    subject "Welcome Fellow Douche Spotter"
    from @@mail['from']
    content_type "text/html"
    body :login => user.login, :footer => @@mail['footer'], :user => user
  end
  
  def newuser(user)
    recipients @@mail['admins']
    subject "[Douche] New User - #{user.login}"
    from @@mail['from']
    content_type "text/html"
    body :user => user, :footer => @@mail['footer']
  end
  
  def photo_approved(photo)
    recipients photo.user.email
    subject "Photo Approved"
    from @@mail['from']
    content_type "text/html"
    body :photo => photo, :footer => @@mail['footer'], :host => @@mail['host'], :user => photo.user
  end
  
  def newphoto(photo, user, host="spotadouche.com")
    recipients @@mail['admins']
    subject "[Douche] There is a new photo"
    from @@mail['from']
    content_type "text/html"
    body :photo => photo, :user => user, :host => @@mail['host'], :footer =>@@mail['footer']
  end
  
  def new_comment(photo)
    recipients photo.user.email
    subject "Someone commented on your photo"
    from @@mail['from']
    content_type "text/html"
    body :photo => photo, :user => photo.user, :host => @@mail['host'], :footer => @@mail['footer']
  end
  
  def emailchange(user, oldemail)
    if user.bouncing?
      recipients [user.email]
    else
      recipients [user.email, oldemail]
    end
    subject "Your email has been changed"
    from @@mail['from']
    content_type "text/html"
    body :user => user, :oldemail => oldemail, :footer => @@mail['footer']
  end
  
  def forgot_password(user)
    recipients user.email
    subject 'Request to change your password'
    from @@mail['from']
    content_type "text/html"
    body :url => "http://#{@@mail['host']}/users/reset_password/#{user.password_reset_token}", :user => user, :footer => @@mail['footer']
  end

  def reset_password(user)
    recipients user.email
    subject 'Your password has been reset'
    from @@mail['from']
    content_type "text/html"
    body :user => user, :footer => @@mail['footer']
  end
  
  def newbadge(user, msg)
    recipients user.email
    subject "New badge earned"
    from @@mail['from']
    content_type "text/html"
    body :user => user, :footer => @@mail['footer'], :msg => msg
  end
  
end


