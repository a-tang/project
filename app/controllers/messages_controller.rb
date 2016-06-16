class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message          = Message.new message_params
    @message.user     = current_user
    @message.end_date = DateTime.now + params[:message][:end_date].to_i.days
    if @message.save
      redirect_to customer_messages_path, notice: "Message created successfully!"
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

  def update
    @message          = Message.new message_params
    @message.user     = current_user
    @message.end_date = DateTime.now + params[:message][:end_date].to_i.days
    if @message.update message_params
      redirect_to customer_messages_path, notice: "Message created successfully!"
    else
      render :edit
    end
  end


end
