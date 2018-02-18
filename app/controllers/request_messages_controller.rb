class RequestMessagesController < ApplicationController
  before_action :set_request_message, only: [:show, :update, :destroy]

  # GET /request_messages
  def index
    @request_messages = RequestMessage.all

    render json: @request_messages
  end

  # GET /request_messages/1
  def show
    render json: @request_message
  end

  # POST /request_messages
  def create
    @request_message = RequestMessage.new(request_message_params)

    if @request_message.save
      render json: @request_message, status: :created, location: @request_message
    else
      render json: @request_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /request_messages/1
  def update
    if @request_message.update(request_message_params)
      render json: @request_message
    else
      render json: @request_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /request_messages/1
  def destroy
    @request_message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_message
      @request_message = RequestMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def request_message_params
      params.fetch(:request_message, {})
    end
end
