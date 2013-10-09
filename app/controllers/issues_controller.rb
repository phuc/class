class IssuesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # GET /issues
  # GET /issues.json
  def index
    @issues = get_issues

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = get_issue

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = current_user.issues.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = current_user.issues.find(params[:id])
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = current_user.issues.build(params[:issue])

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = get_issue

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        if @issue.status == Issue::STA_RESOLVED
          @issue.update_attribute(:resolved_by, current_user.id)
        end
        
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = current_user.issues.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url }
      format.json { head :no_content }
    end
  end
  
  private
  def get_issues
    (current_user.has_role?(:admin) or current_user.has_role?(:staff)) ? Issue.all : (current_user.has_role?(:super_user) ? current_user.issues : [])
  end
  
  def get_issue
    (current_user.has_role?(:admin) or current_user.has_role?(:staff)) ? Issue.find(params[:id]) : (current_user.has_role?(:super_user) ? current_user.issues.find(params[:id]) : nil)    
  end
end
