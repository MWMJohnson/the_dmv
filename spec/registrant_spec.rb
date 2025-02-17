require 'spec_helper'

RSpec.describe Registrant do
  before(:each) do
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 15 )
    @registrant_3 = Registrant.new('Tucker', 15 )
    @facility_1 = Facility.new({name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
    @facility_2 = Facility.new({name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
  end

  describe '#initialize' do
    it 'exists' do
      expect(@registrant_1).to be_an_instance_of(Registrant)
    end

    it 'has readable attributes' do
      expect(@registrant_1.name).to eq('Bruce')
      expect(@registrant_1.age).to eq(18)
      expect(@registrant_1.permit?).to eq(true)
      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})

      expect(@registrant_2.name).to eq('Penny')
      expect(@registrant_2.age).to eq(15)
      expect(@registrant_2.permit?).to eq(false)
      expect(@registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end

  describe '#permit?' do
    it 'returns the current permit status' do
      expect(@registrant_1.permit?).to eq(true)

      expect(@registrant_2.permit?).to eq(false)
    end
  end

  describe '#earn_permit' do
    it 'changes permit status from false to true' do
      @registrant_2.earn_permit

      expect(@registrant_2.permit?).to be(true)
    end
  end

  describe '#update_written_test_status' do
    it 'updates the written test status' do
      expect(@registrant_1.license_data).to eq({:license=>false, :renewed=>false, :written=>false})

      expect(@registrant_1.update_written_test_status).to eq(true)
      expect(@registrant_1.license_data).to eq({:license=>false, :renewed=>false, :written=>true})
    end
  end

  describe '#update_license_status' do
    it 'updates the license status' do
      expect(@registrant_1.license_data).to eq({:license=>false, :renewed=>false, :written=>false})

      @registrant_1.update_written_test_status
      expect(@registrant_1.update_license_status).to eq(true)
      expect(@registrant_1.license_data).to eq({:license=>true, :renewed=>false, :written=>true})
    end
  end

  describe '#update_renew_status' do
    it 'updates the renewal status' do
      expect(@registrant_1.license_data).to eq({:license=>false, :renewed=>false, :written=>false})

      @registrant_1.update_written_test_status
      @registrant_1.update_license_status
      expect(@registrant_1.update_renew_status).to eq(true)
      expect(@registrant_1.license_data).to eq({:license=>true, :renewed=>true, :written=>true})
    end
  end

end