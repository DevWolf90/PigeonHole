require 'rails_helper'
# require 'spec-helper'

describe Pigeon do
  describe '.create' do
    before do
      @test_pigeon = Pigeon.create(user_id: "2", title: "testing-testing", description: "testing-pigeon-creation", recipient_id: "3")
    end
    it 'creates a new pigeon' do
      expect(Pigeon.all).to include(@test_pigeon)
    end
  end
end
