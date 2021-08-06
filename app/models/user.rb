# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :icon

  validate :icon_cannot_be_used

  private

  def icon_cannot_be_used
    correct_file = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
    errors.add(:icon, t('models.common.notice_cannot_create') unless correct_file.include?(icon.blob.content_type) # rubocop:disable all
  end
end
