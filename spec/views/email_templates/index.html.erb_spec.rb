# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'email_templates/index' do
  before do
    assign(:email_templates, [
             EmailTemplate.create!(
               name: 'Name',
               label: 'Label',
               body: 'MyText',
               subject: 'Subject',
               custom_fields: '["abc"]'
             ),
             EmailTemplate.create!(
               name: 'Name',
               label: 'Label',
               body: 'MyText',
               subject: 'Subject',
               custom_fields: '["abc"]'
             )
           ])
  end

  it 'renders a list of email_templates' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Label'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Subject'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('abc'.to_s), count: 2
  end
end
