# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'email_templates/new' do
  before do
    assign(:email_template, EmailTemplate.new(
                              name: 'MyString',
                              label: 'MyString',
                              body: 'MyText',
                              subject: 'MyString',
                              custom_fields: ''
                            ))
  end

  it 'renders new email_template form' do
    render

    assert_select 'form[action=?][method=?]', email_templates_path, 'post' do
      assert_select 'input[name=?]', 'email_template[name]'

      assert_select 'input[name=?]', 'email_template[label]'

      assert_select 'textarea[name=?]', 'email_template[body]'

      assert_select 'input[name=?]', 'email_template[subject]'

      assert_select 'input[name=?]', 'email_template[custom_fields]'
    end
  end
end
