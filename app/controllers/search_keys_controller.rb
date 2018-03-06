class SearchKeysController < ApplicationController
  before_action :set_query, only: [:update, :destroy]

  def update
      @query_definition.update_search_key
      render json: @query_definition
  end

  private
    def set_query
      logger.debug "test"
      @query_definition = QueryDefinition.find_by_search_key(params[:query_definition_search_key])
      authorize! :update ,@query_definition
    end

end
