class Mail < ActionMailer::Base

  def welcome(user)
    recipients user.email
    subject "Welcome Fellow Douche Spotter"
    from "Douche Admin <admin@spotadouche.com>"
    content_type "text/html"
    body :login => user.login
  end
  
  def newuser(user)
    recipients 'admin@spotadouche.com'
    subject "[Douche] New User - #{user.login}"
    from "Douche Admin <admin@spotadouche.com>"
    body :user => user
  end
  
  def newphoto(email, photo)
    recipients email
    subject "[Douche] There is a new photo"
    from "Douche Admin <admin@spotadouche.com>"
    body :login => photo
  end
  
  def emailchange(user, oldemail)
    recipients [user.email, oldemail]
    subject "Your email has been changed"
    from "Douche Admin <admin@spotadouche.com>"
    content_type "text/html"
    body :user => user, :oldemail => oldemail
  end
  
  def forgot_password(user)
    recipients user.email
    subject 'Request to change your password'
    from "Douche Admin <admin@spotadouche.com>"
    content_type "text/html"
    body :url => "http://spotadouche.com/users/reset_password/#{user.password_reset_token}", :user => user
  end

  def reset_password(user)
    recipients user.email
    subject 'Your password has been reset'
    from "Douche Admin <admin@spotadouche.com>"
    content_type "text/html"
    body :user => user
  end

end
