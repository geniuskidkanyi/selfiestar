class CommentsChannel < ApplicationCable::Channel
  def subscribed
  stream_from "selfie:"
  end

  def unsubscribed
     stop_all_streams
  end
end
