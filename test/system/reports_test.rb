# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:report, user_id: @user.id)
    visit root_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_on 'ログイン'
  end

  test 'visiting the Report' do
    click_on '日報'
    assert_selector 'h1', text: '日報'
  end

  test 'creating a Report' do
    visit reports_path
    click_on '新規作成'

    fill_in 'report[title]', with: 'test title'
    fill_in 'report[content]', with: 'test test content'
    click_on '登録する'

    assert_text '日報が作成されました。'
    click_on '戻る'
    page.assert_text 'test title'
  end

  test 'updating a Report' do
    visit reports_path
    page.assert_text 'test'
    click_on '編集'
    fill_in 'report[title]', with: 'update title'
    fill_in 'report[content]', with: 'update content'
    click_on '更新する'

    assert_text '日報が更新されました'
    click_on '戻る'
    page.assert_text 'update title'
  end

  test 'destroying a Report' do
    visit reports_path
    page.assert_text 'test'
    page.accept_confirm do
      click_on '削除'
    end
    assert_text '日報が削除されました。'
    page.assert_no_text 'test'
  end
end
