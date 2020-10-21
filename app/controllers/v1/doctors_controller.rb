class V1::DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update, :destroy]

  # GET /doctors
  def index
    @doctors = Doctor.all

    render json: @doctors
  end

  # GET /doctors/1
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    begin
      @doctor = Doctor.new(doctor_params)

      if @doctor.save
        render json: {doctor: @doctor, status: "Doctor created successfully"}, status: :ok
      else
        render json: @doctor.errors, status: :unprocessable_entity
      end
    rescue => e 
      render json: {status: 422, error: e}, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      render json: {doctor: @doctor, status: "Doctor updated successfully"}, status: :ok
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy
    render json: {status: "Doctor deleted successfully"}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      begin
        @doctor = Doctor.find(params[:id])
      rescue => e
        render json: {status: 422, error: e}, status: :unprocessable_entity 
      end
    end

    # Only allow a trusted parameter "white list" through.
    def doctor_params
      params.permit(:name)
    end
end
