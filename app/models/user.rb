# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  paginates_per 5
  max_paginates_per 100

  has_many :books, dependent: :destroy
  has_one_attached :icon

  validate :icon_cannot_be_used

  def icon_cannot_be_used
    errors.add(:icon, 'に指定の画像は保存できません') unless ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'].include?(icon.blob.content_type)
  end
end
