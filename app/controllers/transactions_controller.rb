class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def index
    @transactions = Transaction.all
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def edit; end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.author = current_user

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_url, notice: 'Entity was successfully created.' }
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
          redirect_to transactions_path(@transaction.categories.first), notice: 'Entity was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_category }
      end
    end
  end

  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Entity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :author_id, group_ids: [])
  end
end
