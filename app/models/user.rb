class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  has_many :courses

  after_create :assign_default_role

  def username
    email.split(/@/).first
  end

  def assign_default_role
    if User.count == 1
      add_role(:admin) if self.roles.blank?
      add_role(:teacher)
      add_role(:student)
    else
      add_role(:student) if self.roles.blank?
      add_role(:teacher)
    end
  end

  validate :must_have_a_role, on: :update

  private

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have at least one role")
    end
  end

end
