require "spec_helper"

RSpec.describe Crumpet::Crumb do
  let(:crumb) { Crumpet::Crumb.new(name ,url, options) }
  let(:name) { 'Name' }
  let(:url) { nil }
  let(:options) { {} }

  describe '#link?' do
    context 'when no url is provided' do
      it 'should return false' do
        expect(crumb.link?).to eq false
      end

      context 'when the link option is true' do
        it 'should return false' do
          expect(crumb.link?).to eq false
        end
      end
    end

    context 'when a url is provided' do
      let(:url) { 'http://example.com/' }

      it 'should return true' do
        expect(crumb.link?).to eq true
      end

      context 'when the link option is false' do
        let(:options) { { link: false } }

        it 'should return false' do
          expect(crumb.link?).to eq false
        end
      end
    end
  end

  describe '#escape?' do
    it 'should return true' do
      expect(crumb.escape?).to eq true
    end

    context 'when the escape option is true' do
      let(:options) { { escape: true } }

      it 'should return true' do
        expect(crumb.escape?).to eq true
      end
    end

    context 'when the escape option is false' do
      let(:options) { { escape: false } }

      it 'should return false' do
        expect(crumb.escape?).to eq false
      end
    end
  end

  describe '#truncate?' do
    it 'should return false' do
      expect(crumb.truncate?).to eq false
    end

    context 'when the truncate option is set' do
      let(:options) { { truncate: 10 } }

      it 'should return true' do
        expect(crumb.truncate?).to eq true
      end
    end
  end

  describe '#truncate' do
    it 'should return nil' do
      expect(crumb.truncate).to eq nil
    end

    context 'when the truncate option is set' do
      let(:options) { { truncate: 10 } }

      it 'should return true' do
        expect(crumb.truncate).to eq 10
      end
    end
  end

  describe '#wrap?' do
    it 'should return false' do
      expect(crumb.wrap?).to eq false
    end

    context 'when the wrap_with option is set' do
      let(:options) { { wrap_with: :li } }

      it 'should return true' do
        expect(crumb.wrap?).to eq true
      end
    end
  end

  describe '#wrap_with' do
    it 'should return nil' do
      expect(crumb.wrap_with).to eq nil
    end

    context 'when the wrap_with option is set' do
      let(:options) { { wrap_with: :li } }

      it 'should return :li' do
        expect(crumb.wrap_with).to eq :li
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
        expect(crumb.item_options).to eq options[:item_options]
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
        expect(crumb.wrapper_options).to eq options[:wrapper_options]
      end
    end
  end
end
