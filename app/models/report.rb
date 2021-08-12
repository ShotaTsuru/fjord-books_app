# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :text
  end
end
