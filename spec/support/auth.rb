# frozen_string_literal: true

module Auth
  def as_admin(admin = nil)
    let(:current_administrator) do
      admin ? public_send(admin) : build(:administartor)
    end

    before(:each) do
      allow(@controller).to receive(:current_administrator)
        .and_return(current_administrator)
    end
  end
end

RSpec.configuration.extend Auth, type: :controller
