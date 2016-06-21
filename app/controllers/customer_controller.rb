class CustomerController < ApplicationController

  def contests
    @contests = Contest.all.order("end_date Desc")
    @live     = @contests.where(published: true).where('end_date >= ?', Time.now).page(params[:live_page]).per(7)
    @draft    = @contests.where(published: false).page(params[:draft_page]).per(7)
    @past     = @contests.where('end_date <= ?', Time.now).page(params[:past_page]).per(7)
  end

  def edit
    @contest  = Contest.find params[:id]
  end

  private

  def contests_params
    contests_params = params.require(:contest).permit(:title, :body, :image, :prize, :end_date, :featured, :category_id, :published, :user_id, {image:[]})
  end

end
