require 'spec_helper'

describe Project do

  it { should validate_presence_of :name }
  it { should have_many(:tickets).dependent(:delete_all) }
  it { should have_many :permissions }

end