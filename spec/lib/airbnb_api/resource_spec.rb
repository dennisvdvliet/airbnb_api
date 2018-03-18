require 'spec_helper'

describe AirbnbApi::Resource do
  describe 'class methods' do
    let(:flat_data) { { id: 1, foo: 'bar' } }
    let(:nested_data) { { test_resource_with_root: { id: 1, foo: 'bar' } } }

    context 'when no root element is present' do
      let(:test_class) do
        class TestResourceNoRoot
          include AirbnbApi::Resource
          extend AirbnbApi::Resource::ClassMethods
          has_root false
          has_attributes [:id, :foo]
        end
        TestResourceNoRoot
      end
      describe '#root_element' do
        it 'should return nil' do
          expect(test_class.root_element).to be_nil
        end
      end

      describe '#build' do
        context 'with flat data' do
          it 'returns a Test resource that responds to #id' do
            expect(test_class.new(flat_data)).to respond_to(:id)
            expect(test_class.new(flat_data).id).to eq(1)
          end
        end
      end
    end
    context 'when a root element is present' do
      let(:test_class) do
        class TestResourceWithRoot
          include AirbnbApi::Resource
          extend AirbnbApi::Resource::ClassMethods
          has_attributes [:id, :foo]
        end
        TestResourceWithRoot
      end
      describe '#root_element' do
        it 'should return :test_resource_with_root' do
          expect(test_class.root_element).to be_truthy
          expect(test_class.root_element).to eq(:test_resource_with_root)
        end
      end
      describe '#build' do
        context 'with nested data' do
          it 'returns a Test resource that responds to #id' do
            expect(test_class.new(nested_data).id).to eq(1)
          end
        end
      end
    end
  end

  describe 'attributes' do
    context 'when attributes are assigned' do
      let(:subject) do
        class Subject
          include AirbnbApi::Resource
          extend AirbnbApi::Resource::ClassMethods
          has_attributes %i[id foo]
          has_root false
        end
        Subject
      end
      it 'responds to #id' do
        expect(subject.new({})).to respond_to(:id)
      end
      it 'responds to #foo' do
        expect(subject.new({})).to respond_to(:foo)
      end
    end
    context 'when a relation is assigned' do
      let(:subject) do
        class TestMessage
          include AirbnbApi::Resource
          extend AirbnbApi::Resource::ClassMethods
          has_attributes [:id]
          has_root false
        end
        class Subject
          include AirbnbApi::Resource
          extend AirbnbApi::Resource::ClassMethods
          has_many :messages, TestMessage
        end
        Subject
      end

      let(:data) do
        {
          subject: {
            messages: [
              { id: 1 }
            ]
          }
        }
      end

      it 'responds to #messages' do
        expect(subject.new({})).to respond_to(:messages)
      end
      describe '#messages' do
        it 'returns an array' do
          expect(subject.new(data).messages).to be_a(Array)
        end
        it 'returns 1 item' do
          expect(subject.new(data).messages.count).to eq(1)
        end
        it 'returns a TestMessage object' do
          expect(subject.new(data).messages.first).to be_a(TestMessage)
        end
      end
    end
  end
end
