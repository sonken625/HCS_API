class QueryDefinitionsController < ApplicationController
  load_resource :only => [:index]
  authorize_resource
  before_action :set_query, only: [:show, :update, :destroy]

  # GET /queries
  def index
    render json: @query_definitions
  end

  # GET /queries/1
  def show
    render json: @query_definition
  end

  # POST /queries
  def create
    @query_definition = QueryDefinition.new
    @query_definition.hct = current_hct unless current_hct.admin?

    if @query_definition.save
      render json: @query_definition, status: :created, location: @query_definition
    else
      render json: @query_definition.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /queries/1
  def update
    @query_definition.hct = current_hct unless can? :manage, QueryDefinition
    if @query_definition.update(query_params)
      render json: @query_definition
    else
      render json: @query_definition.errors, status: :unprocessable_entity
    end
  end

  # DELETE /queries/1
  def destroy
    @query_definition.destroy
    head :no_content
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query_definition = QueryDefinition.find_by_search_key(params[:search_key])
    end

    # Only allow a trusted parameter "white list" through.
    def query_params
      params.fetch(:query_definition, {}).permit(:hct_id)
    end
end
