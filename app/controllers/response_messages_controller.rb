# frozen_string_literal: true

class ResponseMessagesController < ApplicationController
  before_action :set_request_message, only: [:index]

  # GET /response_messages
  # GET /response_messages.json
  def index
    @response_messages = ResponseMessage.joins(:request_message).where(:request_messages=>{id: @request_message.id}).after_from_the_id(params[:latest_id]).limit(100)
    render json:@response_messages
  end

  # POST /response_messages
  # POST /response_messages.json
  def create
    @response_message = ResponseMessage.new(response_message_params)

    if @response_message.save
      render json:@response_message, status: :created
    else
      render json: @response_message.errors, status: :unprocessable_entity
    end
  end

  private

  def set_request_message
    if params[:message_unique_id].nil?
      render json: { status: :error, error_code: :bad_request, message: "message_id can't be blank" }
      return
    end

    @request_message = RequestMessage.find_by_message_unique_id(params[:message_unique_id])

    if @request_message.nil?
      render json: { status: :error, error_code: :bad_request, message: 'invalid message_id' }
      return
    end

    authorize! :read, @request_message
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def response_message_params
    params.fetch(:response_message, {}).permit(:message_unique_id, :response_type, :params_string)
  end
end
