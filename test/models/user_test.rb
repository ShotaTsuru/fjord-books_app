# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User#name_or_email' do
    user = FactoryBot.create(:user, name: '')
    assert_equal '1111@example.com', user.name_or_email

    user.name = 'Foo Bar'
    assert_equal 'Foo Bar', user.name_or_email
  end

  test 'User#following?' do
    user =  FactoryBot.create(:user, email: 'foo@example.com')
    user2 = FactoryBot.create(:user, email: 'boo@example.com')
    
    assert_not user2.following?(user)
    user2.active_relationships.find_or_create_by!(following_id: user.id)
    assert_equal true, user2.following?(user)
  end

  test 'User#followed_by?' do
    user =  FactoryBot.create(:user, email: 'foo@example.com')
    user2 = FactoryBot.create(:user, email: 'boo@example.com')

    assert_not user2.followed_by?(user)
    user2.passive_relationships.find_or_create_by!(follower_id: user.id)
    assert_equal true, user2.followed_by?(user)
  end

  test 'User#follow' do
    user =  FactoryBot.create(:user, email: 'foo@example.com')
    user2 = FactoryBot.create(:user, email: 'boo@example.com')
    user.follow(user2)
    assert_equal user2.followers[0], user
  end

  test 'User#unfollow' do
    user =  FactoryBot.create(:user, email: 'foo@example.com')
    user2 = FactoryBot.create(:user, email: 'boo@example.com')
    user.active_relationships.find_or_create_by!(following_id: user2.id)
    user.unfollow(user2)
    assert_nil user.active_relationships.find_by(follower: user2)
  end
end
