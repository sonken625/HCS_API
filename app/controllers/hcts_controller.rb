class HctsController < ApplicationController
  before_action :set_hct, only: [:show, :update, :destroy]
  authorize_resource

  # GET /hcts
  def index
    @hcts = Hct.all
    render json: @hcts
  end

  # GET /hcts/1
  def show
    render json: @hct
  end

  # POST /hcts
  def create
    @hct = Hct.new(hct_params)

    if @hct.save
      render json: @hct, status: :created, location: @hct
    else
      render json: @hct.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hcts/1
  def update
    if @hct.update(hct_params)
      render json: @hct
    else
      render json: @hct.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hcts/1
  def destroy
    @hct.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hct
      @hct = Hct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hct_params
      params.fetch(:hct, {}).permit(:firm_id)
    end
end
