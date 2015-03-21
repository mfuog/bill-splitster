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
    3.times do
      participant = @bill_sheet.participants.build
      2.times { participant.bills.build }
    end
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
      params.require(:bill_sheet).permit(:creator_id,
                                         :title,
                                         :description,
                                         :status,
                                         participants_attributes: [ :name,
                                                                    :_destroy,
                                                                    bills_attributes: [ :amount,
                                                                                        :title,
                                                                                        :note,
                                                                                        :_destroy ]
                                                                  ] )
    end
end
