# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  paginates_per 10
  max_paginates_per 100

  belongs_to :user
end
