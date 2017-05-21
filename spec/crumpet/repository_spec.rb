require "spec_helper"

RSpec.describe Crumpet::Repository do
  let(:repository) { Crumpet::Repository.new }

  describe '#render' do
    before do
      repository.add_crumb('Name')
    end

    it 'should render the crumbs' do
      expect(repository.render).to eq '<span>Name</span>'
    end
  end

  describe '#add_crumb' do
    it 'should add a crumb to the repository' do
      expect{ repository.add_crumb('Name') }.to change{ repository.count }.by 1
    end
  end

  describe '#<<' do
    let(:crumb) { Crumpet::Crumb.new('Name') }

    it 'should add a crumb to the repository' do
      expect{ repository << crumb }.to change{ repository.count }.by 1
    end

    it 'should not add other objects to the repository' do
      expect{ repository << :not_crumb }.to raise_error ArgumentError, 'crumb must be a Crumpet::Crumb'
    end
  end
end
