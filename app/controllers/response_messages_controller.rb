class ResponseMessagesController < ApplicationController
  before_action :set_response_message, only: []

  # GET /response_messages
  # GET /response_messages.json
  def index
    @response_messages = ResponseMessage.all
  end


  # POST /response_messages
  # POST /response_messages.json
  def create
    @response_message = ResponseMessage.new(response_message_params)

    if @response_message.save
      render :show, status: :created, location: @response_message
    else
      render json: @response_message.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response_message
      @response_message = ResponseMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_message_params
      params.fetch(:response_message, {})
    end
end
