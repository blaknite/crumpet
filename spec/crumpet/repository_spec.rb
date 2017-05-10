require "spec_helper"

RSpec.describe Crumpet::Repository do
  let(:repository) { Crumpet::Repository.new }

  describe '#add_crumb' do
    it 'should add a crumb to the repository' do
      expect{ repository.add_crumb('Title') }.to change{ repository.count }.by 1
    end
  end

  describe '#<<' do
    let(:crumb) { Crumpet::Crumb.new('Title') }

    it 'should add a crumb to the repository' do
      expect{ repository << crumb }.to change{ repository.count }.by 1
    end

    it 'should not add other objects to the repository' do
      expect{ repository << :not_crumb }.to raise_error ArgumentError, 'crumb must be a Crumpet::Crumb'
    end
  end
end
