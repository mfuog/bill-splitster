class BillSheetsController < ApplicationController
  before_action :set_bill_sheet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :show

  # GET /bill_sheets
  def index
    @bill_sheets = BillSheet.all
  end

  # GET /bill_sheets/1
  def show
    @isCreator = current_user == @bill_sheet.creator
  end

  # GET /bill_sheets/new
  def new
    @bill_sheet = BillSheet.new
  end

  # GET /bill_sheets/1/edit
  def edit
  end

  # POST /bill_sheets
  def create
    @bill_sheet = BillSheet.new(bill_sheet_params)
    @bill_sheet.creator = current_user
    if @bill_sheet.save!
      redirect_to @bill_sheet, notice: 'Bill sheet was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bill_sheets/1
  def update
    if @bill_sheet.update!(bill_sheet_params)
      redirect_to @bill_sheet, notice: 'Bill sheet was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bill_sheets/1
  def destroy
    @bill_sheet.destroy
    redirect_to bill_sheets_url, notice: 'Bill sheet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_sheet
      @bill_sheet = BillSheet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bill_sheet_params
      bills_attributes = [ :id,
                           :amount,
                           :title,
                           :note,
                           :_destroy ]
      participants_attributes = [ :id,
                                  :name,
                                  :_destroy,
                                  bills_attributes: bills_attributes ]
      params.require(:bill_sheet).permit(:title,
                                         :description,
                                         :status,
                                         participants_attributes: participants_attributes)
    end
end
