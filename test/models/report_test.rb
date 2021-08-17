# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'Report#editable?' do
    user = FactoryBot.create(:user)
    user2 =  FactoryBot.create(:user)
    report = user.reports.create(title: 'test', content: 'aaaaaaaa')
    assert_not report.editable?(user2)
    assert true, report.editable?(user)
  end

  test 'Report#created_on' do
    user = FactoryBot.create(:user)
    report = user.reports.create(title: 'test', content: 'aaaaaaaa')
    assert_equal Time.zone.today, report.created_on
  end
end
