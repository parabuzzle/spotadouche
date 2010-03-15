class Mail < ActionMailer::Base

  def welcome(user)
    recipients user.email
    subject "Welcome Fellow Douche Spotter"
    from SITE_PROPS['admin']['from']
    content_type "text/html"
    body :login => user.login
  end
  
  def newuser(user)
    recipients SITE_PROPS['admin']['email']
    subject "[Douche] New User - #{user.login}"
    from SITE_PROPS['admin']['from']
    content_type "text/html"
    body :user => user
  end
  
  def newphoto(photo, user, host="spotadouche.com")
    recipients SITE_PROPS['admin']['email']
    subject "[Douche] There is a new photo"
    from SITE_PROPS['admin']['from']
    content_type "text/html"
    body :photo => photo, :user => user, :host => host
  end
  
  def emailchange(user, oldemail)
    recipients [user.email, oldemail]
    subject "Your email has been changed"
    from SITE_PROPS['admin']['from']
    content_type "text/html"
    body :user => user, :oldemail => oldemail
  end
  
  def forgot_password(user)
    recipients user.email
    subject 'Request to change your password'
    from SITE_PROPS['admin']['from']
    content_type "text/html"
    body :url => "http://spotadouche.com/users/reset_password/#{user.password_reset_token}", :user => user
  end

  def reset_password(user)
    recipients user.email
    subject 'Your password has been reset'
    from SITE_PROPS['admin']['from']
    content_type "text/html"
    body :user => user
  end

end
