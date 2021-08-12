# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  has_many :comments, as: :commentable, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :memo
    validates :author
  end
end
