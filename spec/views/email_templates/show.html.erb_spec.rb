# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'email_templates/show' do
  before do
    assign(:email_template, EmailTemplate.create!(
                              name: 'Name',
                              label: 'Label',
                              body: 'MyText',
                              subject: 'Subject',
                              custom_fields: ''
                            ))
  end

  it 'renders attributes in <p>', :aggregate_failures do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Label/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(//)
  end
end
