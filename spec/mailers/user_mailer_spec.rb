# frozen_string_literal: true

RSpec.describe UserMailer do
  describe 'welcome_email' do
    let(:company) { create(:company) }
    let(:user) do
      create(:user, email: 'test@example.com', name: 'Heather McClure', cpf: '68134831613', admin: false,
                    company: company)
    end
    let(:mail) { described_class.welcome_email(user).deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to the system')
      expect(mail.from).to eq(['system@system.com.br'])
    end
  end
end
