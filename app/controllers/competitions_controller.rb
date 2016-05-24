class CompetitionsController < ApplicationController
  before_action :find_competition, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:index, :show, :filter]

  def new
    @competition = Competition.new
    1.times { @competition.user_images.build }
  end

  def create
    @competition = Competition.new competition_params
    if @competition.save
      redirect_to competition_path(@competition), notice: "Competition created successfully!"
    else
      gen_count = 1 - @competition.user_images.size
      gen_count.times { @competition.user_images.build }
      flash[:alert] = "Problem!"
      render :new
    end
  end

  def show
  end

  def index
    @competition = Competition.all
  end

  def edit
  end

  def update
    if @competition.update competition_params
      redirect_to competition_path(@competition)
    else
      render :edit
    end
  end

  def destroy
    @competition.destroy
    redirect_to competitions_path
  end

  private

  def competition_params
    competition_params = params.require(:competition).permit(:title, :body, :prize, :end_date, :category_id, user_images_attributes:[:id, :image, :_destroy])
  end

  def find_competition
    @competition = Competition.find params[:id]
  end

end
