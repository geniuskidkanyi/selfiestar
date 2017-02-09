class CommentJob < ApplicationJob
  queue_as :default

    def perform(comment)
      ActionCable.server.broadcast "selfie:#{comment.selfie_id}:comments", foo: render_comment(comment)
    end

    private
      def render_comment(comment)
        ApplicationController.renderer.render(partial: 'selfie/comments/comment', locals: { selfie: selfie })
      end
end
