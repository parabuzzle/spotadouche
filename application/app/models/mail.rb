class Mail < ActionMailer::Base
  
@@mail = SITE_PROPS['admin']['email']

  def welcome(user)
    recipients user.email
    subject "Welcome Fellow Douche Spotter"
    from @@mail['from']
    content_type "text/html"
    body :login => user.login, :footer => @@mail['footer']
  end
  
  def newuser(user)
    recipients @@mail['admins']
    subject "[Douche] New User - #{user.login}"
    from @@mail['from']
    content_type "text/html"
    body :user => user, :footer => @footer
  end
  
  def newphoto(photo, user, host="spotadouche.com")
    recipients @@mail['admins']
    subject "[Douche] There is a new photo"
    from @@mail['from']
    content_type "text/html"
    body :photo => photo, :user => user, :host => host, :footer =>@@mail['footer']
  end
  
  def emailchange(user, oldemail)
    recipients [user.email, oldemail]
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

end
