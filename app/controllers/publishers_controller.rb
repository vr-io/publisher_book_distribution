class PublishersController < ApplicationController
  def create
    Publisher.create!
  end

end
