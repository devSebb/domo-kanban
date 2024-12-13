class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    stream_from "message_channel_#{params[:room]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
