class V1::AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :destroy]

  # GET /appointments
  def index
    @appointments = Appointment.all

    render json: @appointments
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    begin
      @appointment = Appointment.new(appointment_params)

      if @appointment.save
        render json: {appointment: @appointment, status: "Appointment created successfully"} status: :ok
      else
        render json: @appointment.errors, status: :unprocessable_entity
      end
    rescue => e 
      render json: {status: 422, error: e}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: {appointment: @appointment, status: "Appointment updated successfully"} status: :ok
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy
    render json: {status: "Appointment deleted successfully"} status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      begin
        @appointment = Appointment.find(params[:id])
      rescue => e 
        render json: {status: 422, error: e}, status: :unprocessable_entity
      end
      
    end

    # Only allow a trusted parameter "white list" through.
    def appointment_params
      params.fetch(:appointment, {})
    end
end
