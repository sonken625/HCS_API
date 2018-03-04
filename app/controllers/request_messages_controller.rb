# frozen_string_literal: true

class RequestMessagesController < ApplicationController

  before_action :set_request_message, only: %i[show update destroy count_new_record]
  before_action :set_query_definition, only: [:index]

  # GET /request_messages
  def index
    @request_messages = RequestMessage.search_with_query_definition(@query_definition).after_from_the_message_id(@request_message&.id).limit(1000).all

    render json: @request_messages
  end

  def count_record
    @count = RequestMessage.after_from_the_message_id(@request_message&.id).count
    render json:{ message_id: @request_message.id, count: @count }
  end

  # GET /request_messages/1
  def show
    render json: @request_message
  end

  # POST /request_messages
  def create
    @request_message = RequestMessage.new(request_message_params)
    @request_message.sender_hct= current_hct
    if @request_message.save
      render json: @request_message, status: :created, location: @request_message
    else
      render json: @request_message.errors, status: :unprocessable_entity
    end
  end

  private

  def set_query_definition
    @query_definition = QueryDefinition.find_by_search_key(param[:search_key])
    if @query_definition.nil?
      render json:{status: :error, error_code: :bad_request, message: "invalid search key"}
      return
    end
    authorize! :read ,@query_definition
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_request_message
    @request_message = RequestMessage.find_by(message_unique_id: params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def request_message_params
    params.fetch(:request_message, {}).permit(:search_key)
  end
end
