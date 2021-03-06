class DepositsController < ApplicationController
  def new()
    @deposit = Deposit.new()
  end

  def create()
    @deposit = Deposit.new(amount: params[:amount], user_id: current_user.id)
    unless current_user && current_user.authenticate(params[:password])
      flash[:danger] = "Wrong password"
      redirect_to '/deposit'
      return
    end
    if @deposit.save()
      flash[:success] = "successfully deposited #{@deposit.amount} in your account"
      redirect_to current_user
    else
      @deposit.errors.full_messages.each() do |e|
        flash[:danger] = e
      end
      redirect_to '/deposit'
    end
  end

  def index()
    date = ""
    if params.has_key?(:date)
      date = params[:date]
    end
    @deposits = Deposit.findAll(current_user.id, date)
  end

  # private
  # def deposit_params
  #   params.require(:moneyDeposit).permit(:name, :email, :password, :password_confirmation, :id, :deposited)
  # end

end
