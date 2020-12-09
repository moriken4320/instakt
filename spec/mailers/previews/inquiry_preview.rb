# Preview all emails at http://localhost:3000/rails/mailers/inquiry
class InquiryPreview < ActionMailer::Preview
  def inquiry
    user = User.find(1)
   
    InquiryMailer.send_mail(user)
  end
end
