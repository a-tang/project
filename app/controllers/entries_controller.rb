class EntriesController < ApplicationController
  before_action :authenticate_user!

  def create
    entry = Entry.new(entered: params[:entry][:entered], contest: contest, user: current_user)

    if entry.save
      redirect_to contest, notice: "Contest Entered!"
    else
      redirect_to contest, alert: "Can't enter contest!"
    end
  end

  def update
    entry = current_user.entries.find params[:id]
    if entry.update(entered: params[:entry][:entered])
      redirect_to contest, notice: "Entry changed"
    else
      redirect_to contest, alert: "Entry wasn't changed"
    end
  end

  def destroy
    entry = current_user.entries.find params[:id]
    entry.destroy
    redirect_to contest, notice: "Left contest!"
  end

  private

  def entry
    @entry ||= current_user.entries.find params[:id]
  end
  
  def contest
    @contest ||= Contest.find params[:contest_id]
  end

end
