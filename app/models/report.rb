class Report
  include Mongoid::Document

  field :organization_id
  field :text
  field :title
end
