class ContestsController < ApplicationController
  before_action :find_contest, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show, :filter]

  def new
    @contest = Contest.new
    1.times { @contest.user_images.build }
  end

  def create
    @contest = Contest.new contest_params
    if @contest.save
      redirect_to contest_path(@contest), notice: "Contest created successfully!"
    else
      gen_count = 1 - @contest.user_images.size
      gen_count.times { @contest.user_images.build }
      flash[:alert] = "Problem!"
      render :new
    end
  end

  def show
  end

  def index
    @contest = Contest.all
  end

  def edit
  end

  def update
    if @contest.update contest_params
      redirect_to contest_path(@contest)
    else
      render :edit
    end
  end

  def destroy
    @contest.destroy
    redirect_to contests_path
  end



  private


  def contest_params
    contest_params = params.require(:contest).permit(:title, :body, :prize, :end_date, :category_id, user_images_attributes: [:id, :image, :_destroy])
  end

  def find_contest
    @contest = Contest.find params[:id]
  end

end
