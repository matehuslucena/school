require 'rails_helper'

describe Course do
  it 'has a valid factory' do
    expect(create(:course)).to be_valid
  end
  it 'is invalid without a name'do
    expect(build(:course, name: nil)).not_to be_valid
  end
  it 'is invalid without a description' do
    expect(build(:course, description: nil)).not_to be_valid
  end
end