class CustomerController < ApplicationController

  def contests
    @contests = Contest.all
    @contests = @contests.page(params[:page]).per(7)
  end



end
