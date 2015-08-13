require 'rails_helper'

describe Student do
  it 'has a valid factory' do
    expect(create(:student)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:student, name: nil)).not_to be_valid
  end

  it 'is invalid without a register number' do
    expect(build(:student, register_number: nil)).not_to be_valid
  end

  it 'does not allow duplicate register number' do
    student = create(:student)
    expect(build(:student, register_number: student.register_number)).not_to be_valid
  end

end