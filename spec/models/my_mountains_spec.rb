require 'spec_helper'

describe MyMountain do
	let(:user) { FactoryGirl.create(:user)}
	let(:mountain) {FactoryGirl.create(:mountain)}

  # it { should respond_to(:mountain)}
  # it { should respond_to(:user_id)}
  # it { should respond_to(:type)}

  # it { should be_valid }

	# Can not create without mountain ID
	it 'is valid when created through FactoryGirl with all variables' do
		mymountain = FactoryGirl.create(:my_mountain)
		mymountain.should be_valid
	end

	it 'is invalid without a mountain assigned' do
		mymountain = Factory(:my_mountain, mountain: nil)
	end

	# Can not create without user id

	# Can not create without unique mountain id and user id

	# Can not create without a type reference


end
