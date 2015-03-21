class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  # GET /participants/1
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # POST /participants
  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      redirect_to @participant, notice: 'Participant was successfully created.'
    else
      render :new
    end
  end

  # DELETE /participants/1
  def destroy
    @participant.destroy
    redirect_to participants_url, notice: 'Participant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def participant_params
      params.require(:participant).permit(:name, :bill_sheet_id)
    end
end
