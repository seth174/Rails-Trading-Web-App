class StaticController < ApplicationController
  def about_seth
  end

  def home
  end

  def download_pdf
    send_file "#{Rails.root}/app/assets/images/FagenResume2022.pdf", type: "application/pdf", x_sendfile: true
  end

  def welcome_email
    flash[:success] = 'You will receive an email shortly!'
    InformationMailer.with(user: params[:email]).welcome_email.deliver_now
    redirect_to root_path
  end
end
