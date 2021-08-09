# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'Report#editable?' do
    user = User.create(email: 'foo@example.com', name: '', password: '111111', password_confirmation: '111111')
    report = user.reports.create(title: 'test', content: 'aaaaaaaa')
    assert_equal true, report.editable?(user)
  end

  test 'Report#created_on' do
    user = User.create(email: 'foo@example.com', name: '', password: '111111', password_confirmation: '111111')
    report = user.reports.create(title: 'test', content: 'aaaaaaaa')
    assert_equal Time.zone.today, report.created_on
  end
end
