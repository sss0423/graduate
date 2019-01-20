class DeviseMailer < Devise::Mailer #Devise::Mailer

  default from: 'from@example.com'

  def devise_mail(current_user)
    #@title = picture.title
    #@content = picture.content
    mail to: @email , subject: "登録確認"
  end


end
