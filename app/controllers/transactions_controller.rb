class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    @transactions = Transaction.all
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.author = current_user

    respond_to do |format|
      if @transaction.save
        format.html do
          if @transaction.categories.any?
            redirect_to category_path(@transaction.categories.first), notice: 'Transaction created.'
          else
            redirect_to transactions_path, notice: 'Transaction created.'
          end
        end
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html do
          if @transaction.categories.any?
            redirect_to category_path(@transaction.categories.first), notice: 'Transaction successfully updated.'
          else
            redirect_to transactions_path, notice: 'Transaction updated but no category was associated.'
          end
        end
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to categories_path, notice: 'Transaction deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find_by(id: params[:id])

    return if @transaction

    redirect_to categories_path, alert: 'Transaction not found.'
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :image, :author_id, category_ids: [])
  end
end
