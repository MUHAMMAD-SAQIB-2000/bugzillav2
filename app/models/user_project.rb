class UserProject < ApplicationRecord
  belongs_to :user
  belongs_to :project

  accepts_nested_attributes_for :user
end
