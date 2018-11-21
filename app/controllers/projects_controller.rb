class ProjectsController < ApplicationController
    def create
        @project = Project.new(project_params)
        if @project.save
            flash[:notice] = "Project has been created. "
            redirect_to @project       
            # redirect_to @project, flash: { success: "Project has been created."}     
        else
           flash.now[:alert] = "Project has not been created."
           render "new"
        end       
    end
    
    def show
        @project = Project.find(params[:id])
    end

    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
    end
    def edit
        @project = Project.find(params[:id])
    end
    def update
        @project = Project.find(params[:id])
        @project.update(project_params)
        flash[:notice] = "Project has been updated."
        redirect_to @project
    end
    def destroy
        @project = Project.find(params[:id])
        @project.destroy
        flash[:notice] = "Project has been deleted."
        redirect_to projects_path
    end
    def set_project
        @project = Project.find([:id])
    rescue ActiveRecord::RecordNotFound
        flash[:aler] = "The project you were lookinf for could not be found."
        redirect_to projects_path
        
    end
 
    private

    def project_params
        params.require(:project).permit(:name, :description)
    end
end
