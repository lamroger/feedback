class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[public_response create sanitize_message]

  # GET /responses or /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1 or /responses/1.json
  def show; end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit; end

  # POST /responses or /responses.json
  def create
    @response = Response.new(response_params.merge(user: guest_user))

    respond_to do |format|
      if @response.save
        format.html { redirect_back_or_to '/', notice: 'Feedback submitted.' }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to response_url(@response), notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sanitize_message
    message = params[:message]
    anon_message = helpers.anonymize(message)

    render turbo_stream: turbo_stream.replace('response_text', partial: 'response_text',
                                                               locals: { message: anon_message })
  end

  def public_response
    @survey = Survey.find_by(public_id: params[:public_id])

    @response = Response.new(survey: @survey)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_response
    @response = Response.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def response_params
    params.require(:response).permit(:user_id, :survey_id, :message)
  end
end
