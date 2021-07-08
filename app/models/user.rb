class User < ApplicationRecord
	has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  # validates :is_gogetter, presence: true

	has_many :jobs, dependent: :destroy

end
