class FirmsController < ApplicationController
  load_and_authorize_resource

  # GET /firms
  def index
    render json: @firms
  end

  # GET /firms/1
  def show
    render json: @firm
  end

  # POST /firms
  def create
    @firm = Firm.new(firm_params)

    if @firm.save
      render json: @firm, status: :created, location: @firm
    else
      render json: @firm.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /firms/1
  def update
    if @firm.update(firm_params)
      render json: @firm
    else
      render json: @firm.errors, status: :unprocessable_entity
    end
  end

  # DELETE /firms/1
  def destroy
    @firm.destroy
  end

  private

    # Only allow a trusted parameter "white list" through.
    def firm_params
      params.require(:firm).permit(:name, :active)
    end
end
