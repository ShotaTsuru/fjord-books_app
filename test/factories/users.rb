# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name                   { 'John' }
    postal_code            { '111-1111' }
    address                { 'test' }
    self_introduction      { 'testtest' }
    email                  { 'test@example.com' }
    password               { 'aaaaaa1' }
    password_confirmation  { password }
  end
end
