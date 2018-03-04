# frozen_string_literal: true

class ResponseMessagesController < ApplicationController
  before_action :set_response_message, only: []
  before_action :set_request_message, only: [:index]

  # GET /response_messages
  # GET /response_messages.json
  def index
    @response_messages = ResponseMessage.limit(100)
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

  def set_request_message
    if response_message_params[:message_id].nil?
      render json: { status: :error, error_code: :bad_request, message: "message_id can't be blank" }
      return
    end

    @request_message = RequestMessage.find_by_message_id(response_message_params[:message_id])

    if @response_message.nil?
      render json: { status: :error, error_code: :bad_request, message: 'invalid message_id' }
      return
    end

    authorize! :read, @request_message
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_response_message
    @response_message = ResponseMessage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def response_message_params
    params.fetch(:response_message, {}).permit(:message_id, :type, :params, :url)
  end
end
