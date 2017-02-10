class Selfies::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_selfie
  def create
  @comment =  @selfie.comments.new(comment_params)
  @comment.user = current_user
  @comment.save
  respond_to do |format|
      format.js
  end
  end
private

  def comment_params
    params.require(:comment).permit(:body)
  end

    private

    def set_selfie
        @selfie = Selfy.find(params[:selfy_id])
    end
end
