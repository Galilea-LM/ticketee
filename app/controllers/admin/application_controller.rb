class Admin::ApplicationController < ApplicationController
    before_action :authorize_admin!
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flahs[:notice] = "Project jas been created."
      redirect_to @project
    else
      flahs.now[:alert] = "Project has not been created."
      render "new"
    end
  end

  def index
  end
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flahs[:notice] = "Project has been deleted."
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end


  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to do that."
    end
  end

end
