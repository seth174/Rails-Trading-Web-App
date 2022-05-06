class InformationMailer < ApplicationMailer
  default from: 'sethfagen22@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'https://sethstradingapp.herokuapp.com/signup'
    mail(to: @user, subject: 'Hello My Name Is Seth')
  end
end
