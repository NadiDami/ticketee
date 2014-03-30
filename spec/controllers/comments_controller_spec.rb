require 'spec_helper'

describe CommentsController do

  let(:user) { create(:user) }
  let(:project) { create(:project, name: "Ticketee") }
  let(:ticket) do
    project.tickets.create(title: "State transitions",description: "Can't be hacked", user: user)
  end
  let(:state) { create(:state, name: "New") }


  context 'a user without a permission to set state' do
    before do
      sign_in user
    end

    it 'cannot transition a state by passing through state_id' do
      post :create, { comment: { text: "Hacked!", state_id: state.id }, ticket_id: ticket.id }
      ticket.reload
      expect(ticket.state).to be_nil
    end
  end
end
