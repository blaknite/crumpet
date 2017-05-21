require "spec_helper"

RSpec.describe Crumpet::Renderer do
  let(:repository) { Crumpet::Repository.new }
  let(:render) { Crumpet::Renderer.new(repository, render_options).render }
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
    crumbs.each do |crumb|
      repository << crumb
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

        context 'when a container is specified' do
          let(:render_options) { { container: :ul } }

          it 'should return an empty container' do
            expect(render).to eq '<ul></ul>'
          end

          context 'when render_when_blank is false' do
            let(:render_options) { { container: :ul, render_when_blank: false } }

            it 'should return an empty string' do
              expect(render).to eq ''
            end
          end
        end
      end

      context 'when there is one crumb' do
        let(:crumbs) { [crumb1] }

        it 'should render the crumb' do
          expect(render).to eq '<span>Name</span>'
        end

        context 'when the crumb has a url' do
          let(:url1) { 'http://example.com/' }

          it 'should render the crumb as a link' do
            expect(render).to eq '<a href="http://example.com/">Name</a>'
          end
        end

        context 'when the crumb has item options' do
          let(:options1) { { item_options: { class: 'something' } } }

          it 'should render the crumb with options' do
            expect(render).to eq '<span class="something">Name</span>'
          end
        end

        context 'when the crumb has a wrapper' do
          let(:options1) { { wrapper: :li, wrapper_options: { class: 'something' } } }

          it 'should render the crumb with a wrapper' do
            expect(render).to eq '<li class="something"><span>Name</span></li>'
          end
        end

        context 'when the crumb has a url but link is false' do
          let(:url1) { 'http://example.com/' }
          let(:options1) { { link: false } }

          it 'should not render the crumb as a link' do
            expect(render).to eq '<span>Name</span>'
          end
        end

        context 'when html is passed as the name' do
          let(:name1) { '<div>boom</div>' }

          it 'should render the crumb with html escaping' do
            expect(render).to eq '<span>&lt;div&gt;boom&lt;/div&gt;</span>'
          end

          context 'when the crumb is set to escape' do
            let(:options1) { { escape: true } }

            it 'should render the crumb with html escaping' do
              expect(render).to eq '<span>&lt;div&gt;boom&lt;/div&gt;</span>'
            end
          end

          context 'when the crumb is set to not escape' do
            let(:options1) { { escape: false } }

            it 'should render the crumb without html escaping' do
              expect(render).to eq '<span><div>boom</div></span>'
            end
          end
        end

        context 'when a long name is passed' do
          let(:name1) { 'a very long name is very long' }

          it 'should render the crumb with the whole name' do
            expect(render).to eq '<span>a very long name is very long</span>'
          end

          context 'when the truncate option is set' do
            let(:options1) { { truncate: 10 } }

            it 'should render the crumb and truncate the name' do
              expect(render).to eq '<span>a very ...</span>'
            end
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

          it 'should render the crumbs as links' do
            expect(render).to eq '<a href="http://example.com/one">Name</a> &raquo; <a href="http://example.com/two">Name</a>'
          end

          context 'when the link_last_crumb is false' do
            let(:render_options) { { link_last_crumb: false } }

            it 'should render the crumbs as links excpet the last crumb' do
              expect(render).to eq '<a href="http://example.com/one">Name</a> &raquo; <span>Name</span>'
            end
          end
        end
      end
    end
  end
end
