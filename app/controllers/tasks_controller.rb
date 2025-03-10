class TasksController < ApplicationController
  before_action :get_task, only: [ :show, :update, :destroy ]
  def index
    @tasks = Task.all
    render json: @tasks
  end

  def show
    if @task.nil?
      render json: { message: I18n.t("task.not_found", id: params[:id]) }, status: 404
    else
      render json: @task, status: :ok
    end
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: { message: @task.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @task.nil?
      render json: { message: I18n.t("task.not_found", id: params[:id]) }, status: :not_found
    elsif @task.update(task_params)
      render json: @task
    else
      render json: { message: @task.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.nil?
      render json: { message: I18n.t("task.not_found", id: params[:id]) }, status: :not_found
    elsif @task.destroy
      render json: { message: I18n.t("task.destroy.message") }, status: :ok
    else
      render json: { message: @task.errors }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :expires_at, :status)
  end

  def get_task
    begin
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @task = nil
    end
  end
end
