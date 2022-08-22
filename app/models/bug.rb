class Bug < ApplicationRecord
  belongs_to :user
  belongs_to :project

  def date_field
    read_attribute(:deadline).to_s.to_date
  end

  mount_uploader :screenshot, ImageUploader

  # enum bug_bug_types: %w[Feature Bug]
  # enum status_bug_enum: %w[New Started Resolved]
  # enum status_feature_enum: %w[New Started Completed]
  #
  validates :title,
            :uniqueness => true,
            :presence => {:message => "Title can't be blank." }

  # validates :deadline,
  #           :presence =>  {:message => "Deadline Must Be Specified." }

  validates :bug_type,
            :presence => true

  validates :bug_status,
            :presence => true
end
