class WithdrawsController < ApplicationController

  before_action :correct_user, only: [:create]

  def new
    @withdraw = Withdraw.new
  end

  def create

    @withdraw = Withdraw.new(amount: params[:amount], user_id: current_user.id)

    if not isPositiveBalance()
      redirect_to '/withdraw'
      return
    end

    @withdraw.amount *= -1 #Saving the withdraw as a negative balance to identify later in the transactions index view

    if @withdraw.save()
      flash[:success] = "successfully withdrew #{@withdraw.amount} in your account"
      redirect_to current_user
    else
      @withdraw.errors.full_messages.each() do |e|
        flash[:danger] = e
      end
      redirect_to '/withdraw'
    end
  end

  def index
    @date = {'Date': '500', '1 Month': '1', '6 Months': '6', '12 Months': '12', 'All Time': '200'}
    date = params.has_key?(:date) ? params[:date] : 500
    amount = params.has_key?(:date) ? params[:date] : 500
    @numeric = {'Amount': 'all', 'Less Than': '<', 'Greater Than': '>', 'Equal': '='}
    @withdraws = Withdraw.findAll(current_user.id, date)
  end

  private
  def correct_user()
    unless current_user && current_user.authenticate(params[:password])
      flash[:danger] = "Wrong password"
      redirect_to '/withdraw'
    end
  end



  def isPositiveBalance()
    newBalance = User.get_cash_available(@withdraw.user_id) - @withdraw.amount
    if newBalance < 0
      flash[:danger] = "Insufficient funds. Will result in a balance of #{newBalance}"
      return false
    end
    return true
  end
end
