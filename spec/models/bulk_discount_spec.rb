require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it { should belong_to :item }
  end

  describe 'validations' do
    it { should validate_presence_of :discount_percentage}
    it { should validate_presence_of :quantity_threshold}
  end
end
