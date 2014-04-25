class CommentsController < ApplicationController
  before_filter :require_signin!
  before_filter :set_ticket

  def create
    sanitize_parameters!

    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      @states = State.all
      flash[:alert] = "Comment has not been created."
      render template: "tickets/show"
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :state_id)
  end

  def sanitize_parameters!
    if cannot?(:"change states", @ticket.project)
      params[:comment].delete(:state_id)
    end
  end

end
