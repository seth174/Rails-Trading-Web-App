class WithdrawsController < ApplicationController
  def new
    @withdraw = Withdraw.new
  end

  def create

    @withdraw = Withdraw.new(amount: params[:amount], user_id: current_user.id)

    unless isPositiveBalance() and correct_user(params[:password])
      redirect_to '/withdraw'
      return
    end

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

  private
  def correct_user(password)
    unless current_user && current_user.authenticate(password)
      flash[:danger] = "Wrong password"
      return false
    end
    return true;
  end

  def isPositiveBalance()
    newBalance = User.getBalance(@withdraw.user_id) - @withdraw.amount
    if newBalance < 0
      flash[:danger] = "Insufficient funds. Will result in a balance of #{newBalance}"
      return false
    end
    return true
  end
end
