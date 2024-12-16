class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
    if params[:user_id]
      @messages = Message.between_users(current_user.id, params[:user_id])
                        .order(created_at: :desc)
                        .page(params[:page])
                        .per(20)
                        .reverse

      @other_user = User.find(params[:user_id])

      respond_to do |format|
        format.html
        format.json {
          render json: {
            messages: render_to_string(partial: "messages/message",
                                     collection: @messages,
                                     formats: [:html]),
            has_more: @messages.total_pages > @messages.current_page
          }
        }
      end
    end
  end

  def create
    @message = current_user.sent_messages.build(message_params)

    if @message.save
      # Broadcast to recipient's personal channel
      MessageChannel.broadcast_to(
        @message.recipient,
        {
          message: render_to_string(partial: "messages/message", locals: { message: @message }),
          sender_id: current_user.id
        }
      )

      # Broadcast to sender's channel
      MessageChannel.broadcast_to(
        current_user,
        {
          message: render_to_string(partial: "messages/message", locals: { message: @message }),
          sender_id: current_user.id
        }
      )

      # Also broadcast to the room
      ActionCable.server.broadcast(
        "message_channel_#{@message.recipient_id}",
        {
          message: render_to_string(partial: "messages/message", locals: { message: @message }),
          sender_id: current_user.id
        }
      )

      head :ok
    else
      render json: { error: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :recipient_id)
  end
end
