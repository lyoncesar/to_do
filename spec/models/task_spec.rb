require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:description) }
    it { should define_enum_for(:status).with_values([ :pending, :completed ]) }
    # it { should validate_presence_of(:expires_at) }
    # it { should validate_presence_of(:status) }
  end
end
