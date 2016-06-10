class Api::V1::MessagesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!


  def read
  	@message = Message.find(params.require(:message_id))
  	@message.mark_as_read!
  	render json: JSONAPI::ResourceSerializer.new(Api::V1::MessageResource)
  		.serialize_to_hash(Api::V1::MessageResource.new(@message, nil))
  end

end
