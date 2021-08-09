# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  test 'User#name_or_email' do
    user = User.new(email: 'foo@example.com', name: '')
    assert_equal 'foo@example.com', user.name_or_email

    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end

  test 'User#following?' do
    user =  User.create(email: 'foo@example.com', name: '', password: '111111', password_confirmation: '111111')
    user2 = User.create(email: 'boo@example.com', name: '', password: '111111', password_confirmation: '111111')
    user2.active_relationships.find_or_create_by!(following_id: user.id)
    assert_equal true, user2.following?(user)
  end

  test 'User#followed_by?' do
    user =  User.create(email: 'foo@example.com', name: '', password: '111111', password_confirmation: '111111')
    user2 = User.create(email: 'boo@example.com', name: '', password: '111111', password_confirmation: '111111')
    user2.passive_relationships.find_or_create_by!(follower_id: user.id)
    assert_equal true, user2.followed_by?(user)
  end

  test 'User#follow' do
    user =  User.create(email: 'foo@example.com', name: '', password: '111111', password_confirmation: '111111')
    user2 = User.create(email: 'boo@example.com', name: '', password: '111111', password_confirmation: '111111')
    assert_equal user.active_relationships.find_or_create_by!(following_id: user2.id), user.follow(user2)
  end

  test 'User#unfollow' do
    user =  User.create(email: 'foo@example.com', name: '', password: '111111', password_confirmation: '111111')
    user2 = User.create(email: 'boo@example.com', name: '', password: '111111', password_confirmation: '111111')
    user.active_relationships.find_or_create_by!(following_id: user2.id)
    user.unfollow(user2)
    assert_nil user.active_relationships.find_by(follower: user2)
  end
end
