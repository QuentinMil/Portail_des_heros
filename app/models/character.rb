require 'faraday'
require 'json'
require 'open-uri'

class Character < ApplicationRecord
  belongs_to :user
  belongs_to :universe
  belongs_to :race, optional: true
  belongs_to :univers_class, optional: true

  has_many :notes, dependent: :destroy
  has_many :party_characters, dependent: :destroy
  has_many :parties, through: :party_characters

  has_one_attached :photo

  before_destroy :destroy_notes

  def generate_backstory_async
    GenerateBackstoryJob.perform_later(id) if completion_rate == 10
  end

  private

  def destroy_notes
    notes.destroy_all
  end
end
