class ToDosController < ApplicationController
  before_action :load_to_do, only: [:show, :edit, :update, :destroy]

  def new
    @to_do = ToDo.new
  end

  def create
    @to_do = ToDo.new(to_do_params)
    @to_do.user = current_user

    if @to_do.save
      redirect_to to_dos_path, notice: "Task created!"
    else
      render :new
    end
  end

  def show
  end

  def index
    if !params[:search].blank?
      @upcoming_to_dos = ToDo.search(params[:search]).where(status: 0).order("due_date ASC")
      @completed_to_dos = ToDo.search(params[:search]).where(status: 1).order("due_date ASC")
    elsif current_user
      @upcoming_to_dos = current_user.to_dos.where(status: 0).order("due_date ASC")
      @completed_to_dos = current_user.to_dos.where(status: 1).order("due_date ASC")
    else
      redirect_to new_user_url, notice: "Sign up or log in to manage tasks."
    end
  end

  def edit
    if current_user != @to_do.user
      redirect_to :new, notice: "Not authorized."
    end
  end

  def update
    if @to_do.update_attributes(to_do_params)
      redirect_to to_dos_path, notice: "Task updated!"
    else
      render :edit
    end
  end

  def destroy
    @to_do.destroy

    redirect_to to_dos_url, notice: 'Task deleted.'
  end

  def calendar
    @to_dos = current_user.to_dos
  end

  def history
    if current_user
      @to_dos = current_user.to_dos.where(status: 1)
    else
      redirect_to new_user_url, notice: "Sign up or log in to manage tasks."
    end
  end

  private

  def load_to_do
    @to_do = ToDo.find(params[:id])
  end

  def to_do_params
    params.require(:to_do).permit(
      :title, :description, :due_date, :status, :user_id
    )
  end
end
