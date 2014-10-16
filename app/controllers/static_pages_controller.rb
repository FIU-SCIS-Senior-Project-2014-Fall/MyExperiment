class StaticPagesController < ApplicationController
  def home
      @experiment = current_user.experiments.build if signed_in?
  end

  def help
  end

  def about
  end
end
