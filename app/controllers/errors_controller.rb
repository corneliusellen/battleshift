class ErrorsController < ApplicationController

  def invalid_coordinates
    render :status => 400, body: {"message" => turn_processor.message}
  end
end
