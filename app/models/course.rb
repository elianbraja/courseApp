class Course < ApplicationRecord
  extend FriendlyId
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user}
  friendly_id :title, use: :slugged

  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { :minimum => 5}
  belongs_to :user

  def to_s
    title
  end

  has_rich_text :description

  LANGUAGES = [:"English", :"Italian", :"French"]
  def self.languages
    LANGUAGES.map{|language| [language, language]}
  end

  LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
  def self.levels
    LEVELS.map{|level| [level, level]}
  end
end
