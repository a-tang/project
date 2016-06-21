class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message          = Message.new message_params
    if @message.save
      redirect_to root_path, notice: "Message created successfully!"
    else
      flash[:alert] = "There is a problem!"
      render :new
    end
  end

  def show
    @entry = Entry.new
  end

  def index
    @message = Message.all.order("end_date DESC")
  end

  def edit
  end


  private

  def message_params
    message_params = params.require(:message).permit(:name, :email)
  end

end
