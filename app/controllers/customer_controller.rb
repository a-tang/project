class CustomerController < ApplicationController

  def contests
    @contests = Contest.all
  end

end
