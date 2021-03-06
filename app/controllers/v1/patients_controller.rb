class V1::PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :destroy]

  # GET /patients
  def index
    @patients = Patient.all

    render json: @patients
  end

  # GET /patients/1
  def show
    render json: @patient
  end

  # POST /patients
  def create
    begin
      @patient = Patient.new(patient_params)

      if @patient.save
        render json: {patient: @patient, status: "Patient created successfully"}, status: :ok
      else
        render json: @patient.errors, status: :unprocessable_entity
      end
    rescue => e 
      render json: {status: 422, error: e}, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      render json: {patient: @patient, status: "Patient updated successfully"}, status: :ok
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def patient_params
      params.permit(:name)
    end
end
