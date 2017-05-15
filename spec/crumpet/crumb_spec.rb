require "spec_helper"

RSpec.describe Crumpet::Crumb do
  let(:crumb) { Crumpet::Crumb.new(name, url, options) }
  let(:name) { 'Name' }
  let(:url) { nil }
  let(:options) { {} }

  describe '#name' do
    it 'should return the name' do
      expect(crumb.name).to eq 'Name'
    end
  end

  describe '#url' do
    it 'should return the url' do
      expect(crumb.url).to eq nil
    end

    context 'when a url is provided' do
      let(:url) { 'http://example.com/' }

      it 'should return the url' do
        expect(crumb.url).to eq 'http://example.com/'
      end
    end
  end

  describe '#options' do
    it 'should return an empty hash' do
      expect(crumb.options).to eq({})
    end

    context 'when the options are provided' do
      let(:options) { { truncate: false } }

      it 'should return the options' do
        expect(crumb.options).to eq({ truncate: false })
      end

      context 'when item or wrapper options are provided' do
        let(:options) {
          { item_options: { class: 'something' }, wrapper_options: { class: 'something' } }
        }

        it 'should not include the item or wrapper options' do
          expect(crumb.options[:item_options]).to eq nil
          expect(crumb.options[:wrapper_options]).to eq nil
        end
      end
    end
  end

  describe '#item_options' do
    it 'should return an empty hash' do
      expect(crumb.item_options).to eq({})
    end

    context 'when the item_options option is set' do
      let(:options) { { item_options: { class: 'something' } } }

      it 'should return the options' do
        expect(crumb.item_options).to eq({ class: 'something' })
      end
    end
  end

  describe '#wrapper_options' do
    it 'should return an empty hash' do
      expect(crumb.wrapper_options).to eq({})
    end

    context 'when the wrapper_options option is set' do
      let(:options) { { wrapper_options: { class: 'something' } } }

      it 'should return the options' do
        expect(crumb.wrapper_options).to eq({ class: 'something' })
      end
    end
  end
end
