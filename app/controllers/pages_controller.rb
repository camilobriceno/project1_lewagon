class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]


  def home

  end

  def landing
    # testpassword = 'test'
    # if params[:landing][:password] == testpassword
    #     redirect_to home_path
    # end
  end

  def options
    # nach dem einlogen komme ich hier rein
    # after

  end

  def overview

  end


end
