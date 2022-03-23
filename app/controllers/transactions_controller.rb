class TransactionsController < ApplicationController
  def index
    @transactions = User.getTransactions(current_user.id)
  end
end
