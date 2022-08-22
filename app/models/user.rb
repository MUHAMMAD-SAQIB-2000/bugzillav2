class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :bugs

  def self.search(search)
    if search && search != ""
      where('name LIKE ?', "%#{search}%")
    end
  end

end
