class ResponsesController < ApplicationController
  before_filter :authenticate_user!, :set_issue
  load_and_authorize_resource
  
  # GET /responses
  # GET /responses.json
  def index
    @responses = @issue.reponses

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
    @response = @issue.responses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.json
  def new
    @response = @issue.responses.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response }
    end
  end

  # GET /responses/1/edit
  def edit
    @response = @issue.responses.find(params[:id])
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = @issue.responses.build(params[:response])
    @response.user = current_user
    respond_to do |format|
      if @response.save
        format.html { redirect_to @issue, notice: 'Response was successfully created.' }
        format.json { render json: @response, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /responses/1
  # PUT /responses/1.json
  def update
    @response = @issue.responses.find(params[:id])
    @response.user = current_user
    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response = @issue.responses.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url }
      format.json { head :no_content }
    end
  end
  
  private
  def set_issue
    @issue = (current_user.has_role?(:admin) or current_user.has_role?(:staff)) ? Issue.find(params[:issue_id]) : (current_user.has_role?(:super_user) ? current_user.issues.find(params[:issue_id]) : nil)
  end
end
