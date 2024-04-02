require "rails_helper"

RSpec.describe "users/_user" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }

  before do
    sign_in_user(user)
    render locals: { user: user }
  end

  context 'renders correctly' do
    context 'left panel' do
      it 'has pfp' do
        expect(rendered).to have_tag 'img',
                                     alt: 'avatar',
                                     src: user.image.url
      end

      it 'has the user name' do
        expect(rendered).to have_tag 'h5',
                                     text: user.name
      end

      it 'has the user bio' do
        expect(rendered).to have_tag 'div',
                                     inner_text: user.bio,
                                     class: 'text-roboto'
      end
    end

    context 'side table' do
      it 'has the user name' do
        expect(rendered).to have_tag 'p',
                                     text: 'Full Name'

        expect(rendered).to have_tag 'p',
                                     text: user.name,
                                     class: 'text-muted'
      end

      it 'has the user gender' do
        expect(rendered).to have_tag 'p',
                                     text: 'Gender'

        expect(rendered).to have_tag 'p',
                                     text: user.gender,
                                     class: 'text-muted'
      end

      it 'has the user email' do
        expect(rendered).to have_tag 'p',
                                     text: 'Email'

        expect(rendered).to have_tag 'p',
                                     text: user.email,
                                     class: 'text-muted'
      end

      it 'has the user phone' do
        expect(rendered).to have_tag 'p',
                                     text: 'Phone'

        expect(rendered).to have_tag 'p',
                                     text: user.phone || "None provided",
                                     class: 'text-muted'
      end

      it 'has the user address' do
        expect(rendered).to have_tag 'p',
                                     text: 'Address'

        expect(rendered).to have_tag 'p',
                                     text: user.institution.location,
                                     class: 'text-muted'
      end

      it 'has the user class' do
        expect(rendered).to have_tag 'p',
                                     text: 'Class'

        expect(rendered).to have_tag 'p',
                                     text: user.i_class.name,
                                     class: 'text-muted'
      end

      it 'has the user institution' do
        expect(rendered).to have_tag 'p',
                                     text: 'Institution'

        expect(rendered).to have_tag 'p',
                                     text: user.institution.name,
                                     class: 'text-muted'
      end
    end
  end
end
