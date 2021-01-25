class BooksController < ApplicationController
  def create
    Book.create!
  end
end
