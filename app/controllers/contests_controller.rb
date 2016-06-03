class ContestsController < ApplicationController
  before_action :find_contest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :filter]

  def new_featured
    @contest = Contest.new
    1.times { @contest.user_images.build }
  end

  def new
    @contest = Contest.new
    1.times { @contest.user_images.build }
  end

  def create
    @contest = Contest.new contest_params
    @contest.user = current_user
    @contest.end_date = DateTime.now + params[:contest][:end_date].to_i.days
    if @contest.save
      redirect_to contest_path(@contest), notice: "Contest created successfully!"
      gen_count = 1 - @contest.user_images.size
      gen_count.times { @contest.user_images.build }
    else
      flash[:alert] = "Problem!"
      render :new
    end

  end

  def show
    @entry = Entry.new
    respond_to do |format|
      format.html { render }
      format.json { render json: @contest.to_json }
      format.xml  { render xml: @contest.to_xml }
    end
  end

  def index
    @contest = Contest.all.order("end_date DESC")
    @contest = @contest.page(params[:page]).per(7)
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

  def publish
    @contest = Contest.find params[:contest_id]
    @contest.update(published: true)
    if @contest.save
      redirect_to customer_contests_path(@contest), notice: "Published!"
    else
      flash[:alert] = "Problem!"
      render @contest
    end

  end

  private

  def contest_params
    contest_params = params.require(:contest).permit(:title, :body, :image, :prize, :end_date, :featured, :category_id, :published, :user_id, {images:[]}, user_images_attributes: [:_destroy, :image])
  end

  def find_contest
    @contest = Contest.find params[:id]
  end


end
