class Project < ApplicationRecord
  has_many :bugs, dependent: :delete_all


  has_many :user_projects, dependent: :delete_all
  has_many :users, through: :user_projects
  accepts_nested_attributes_for :user_projects, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true


  def self.search(search)
    if search && search != ""
      where('name LIKE ?', "%#{search}%")
    end
  end

  def find_or_create_users
    self.user_projects.each do |user_project|
      user_project.user = User.find(name: user_project.user.name)
    end
  end
end
