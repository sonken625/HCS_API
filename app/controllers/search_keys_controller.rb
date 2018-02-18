class QueryDifinitions::SearchKeysController < ApplicationController
  authorize_resource
  before_action :set_query, only: [:update, :destroy]

  def update
      @query_definition.update_serch_key
      render json: @query_definition
  end

  private
    def set_query
      @query_definition = QueryDefinition.find_by_search_key(param[:search_key])
    end

end
