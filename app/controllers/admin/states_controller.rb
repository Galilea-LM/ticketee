class Admin::StatesController < ApplicationController
  def index
    @states = States.all
  end
  def new
    @state = State.new
  end
  def create
    @state = State.new(state_params)
    if @state.update(state_params)
      flash[:notice] = 'State has been created.'
      redirect_to admin_states_path
    else
      flash.now[:alert] = 'State has not been created.'
      render 'new'
    end
  end
  def update  
    if @state.update(state_params)
      flash[:notice] = 'State has been updated.'
      redirect_to admin_states_path
    else
      flash.now[:alert] = 'State has not been updated.'
      render 'edit'
    end
  end
  def make_default
    @state = state.find(params[id])
    @state.make_default!
    flash[:notice] = "'#{@state.name}' is now the default state."
    redirect_to admin_states_path
  end
  def destroy 
  end
  private
  def set_state
    @state = State.find(params[:id])
  end
  def state_params
    params.require(:state).permit(:name, :color)
  end
end
