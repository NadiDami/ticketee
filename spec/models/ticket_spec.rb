require 'spec_helper'

describe Ticket do
  
  it { should belong_to :project }
  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }

end
