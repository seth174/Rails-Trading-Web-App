class StaticController < ApplicationController
  def about_seth
  end

  def home
  end

  def download_pdf
    send_file "#{Rails.root}/app/assets/images/FagenResume2022.pdf", type: "application/pdf", x_sendfile: true
  end
end
