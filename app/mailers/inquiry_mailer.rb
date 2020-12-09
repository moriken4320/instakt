class InquiryMailer < ActionMailer::Base
  default from: ENV["MANAGER_GOOGLE_MAIL"]

  def send_mail(action_user, to_user, subject, message)
    @action_user = action_user
    @to_user = to_user
    @message = message
    mail(
      subject: subject,
      to:   @to_user.email
    ) do |format|
      format.text
    end
  end
end
