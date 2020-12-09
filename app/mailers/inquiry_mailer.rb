class InquiryMailer < ActionMailer::Base
  default from: ENV["MANAGER_GOOGLE_MAIL"]

  def send_mail(user)
    @user = user
    mail(
      subject: 'お問い合わせ通知',
      to:   @user.email
    ) do |format|
      format.text
    end
  end
end
