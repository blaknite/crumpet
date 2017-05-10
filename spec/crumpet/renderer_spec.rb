require "spec_helper"

RSpec.describe Crumpet::Renderer do
  let(:render) { Crumpet::Renderer.new(render_options).render }
  let(:render_options) { {} }
  let(:crumbs) { [] }
  let(:crumb1) { Crumpet::Crumb.new(name1, url1, options1) }
  let(:crumb2) { Crumpet::Crumb.new(name2, url2, options2) }
  let(:name1) { 'Name' }
  let(:url1) { nil }
  let(:options1) { {} }
  let(:name2) { 'Name' }
  let(:url2) { nil }
  let(:options2) { {} }

  before do
    Crumpet.repository.clear
    crumbs.each do |crumb|
      Crumpet.repository << crumb
    end
  end

  describe '#render' do
    context 'when the format is :html' do
      context 'when the crumbs have a container' do
        let(:render_options) { { container: :ul, container_options: { class: 'something' } } }

        it 'should render the container' do
          expect(render).to eq '<ul class="something"></ul>'
        end
      end

      context 'when there are no crumbs' do
        it 'should return an empty string' do
          expect(render).to eq ''
        end
      end

      context 'when there is one crumb' do
        let(:crumbs) { [crumb1] }

        it 'should render the crumb' do
          expect(render).to eq '<span>Name</span>'
        end

        context 'when the crumb has a url' do
          let(:url1) { 'http://example.com/' }

          it 'should render the crumb' do
            expect(render).to eq '<a href="http://example.com/">Name</a>'
          end
        end

        context 'when the crumb has item options' do
          let(:options1) { { item_options: { class: 'something' } } }

          it 'should render the crumb' do
            expect(render).to eq '<span class="something">Name</span>'
          end
        end

        context 'when the crumb has a wrapper' do
          let(:options1) { { wrapper: :li, wrapper_options: { class: 'something' } } }

          it 'should render the crumb' do
            expect(render).to eq '<li class="something"><span>Name</span></li>'
          end
        end
      end

      context 'when there is more than one crumb' do
        let(:crumbs) { [crumb1, crumb2] }

        it 'should render the crumbs' do
          expect(render).to eq '<span>Name</span> &raquo; <span>Name</span>'
        end

        context 'when the crumbs have a url' do
          let(:url1) { 'http://example.com/one' }
          let(:url2) { 'http://example.com/two' }

          it 'should render the crumbs' do
            expect(render).to eq '<a href="http://example.com/one">Name</a> &raquo; <a href="http://example.com/two">Name</a>'
          end

          context 'when the link_last_crumb is false' do
            let(:render_options) { { link_last_crumb: false } }

            it 'should render the crumbs' do
              expect(render).to eq '<a href="http://example.com/one">Name</a> &raquo; <span>Name</span>'
            end
          end
        end
      end
    end
  end
end
