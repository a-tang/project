class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_contest

  def create
    sleep 2
    @contest        = Contest.find params[:contest_id]
    entry_params    = params.require(:entry).permit(:entered)
    @entry          = Entry.new entry_params
    @entry.contest  = @contest
    @entry.user     = current_user
    # entry = Entry.new(entered: params[:entry][:entered], contest: contest, user: current_user)
    # @entry.contest = @contest
    # @entry.user = current_user
    respond_to do |format|
      if @entry.save
        format.html { redirect_to contest_path(@contest),
          notice: "Contest Entered!" }
        else
          flash[:alert] = "Can't enter contest!"
          format.html { render "/contests/show" }
        end
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
    # @entry ||= current_user.entries.find params[:id]

  end

  def find_contest
    @contest ||= Contest.find params[:contest_id]
  end

end
