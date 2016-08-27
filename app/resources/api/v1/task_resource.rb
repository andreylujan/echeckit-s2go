# -*- encoding : utf-8 -*-
class Api::V1::TaskResource < BaseResource
  has_many :dealers
  has_many :stores
  has_many :zones
  has_many :promoters, class_name: "User"
  has_many :reports

  attributes :title, :description, :task_start, :task_end, :result

  before_create :set_creator

  def set_creator(task = @model, context = @context)
    user = context[:current_user]
    task.creator = user
  end
end
