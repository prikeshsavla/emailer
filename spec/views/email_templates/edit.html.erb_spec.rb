# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'email_templates/edit' do
  let(:email_template) do
    EmailTemplate.create!(
      name: 'MyString',
      label: 'MyString',
      body: 'MyText',
      subject: 'MyString',
      custom_fields: ''
    )
  end

  before do
    assign(:email_template, email_template)
  end

  it 'renders the edit email_template form' do
    render

    assert_select 'form[action=?][method=?]', email_template_path(email_template), 'post' do
      assert_select 'input[name=?]', 'email_template[name]'

      assert_select 'input[name=?]', 'email_template[label]'

      assert_select 'textarea[name=?]', 'email_template[body]'

      assert_select 'input[name=?]', 'email_template[subject]'

      assert_select 'input[name=?]', 'email_template[custom_fields]'
    end
  end
end
