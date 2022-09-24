# frozen_string_literal: true

require 'spec_helper'

describe Array do
  before do
    ArrayScope.configure do |config|
      config.define_scope = true
    end
  end

  describe '#scope' do
    subject { objects.scope(method_name) }

    before do
      class Hoge
        extend ArrayScope

        array_scope :defined_method, -> { 'Hoge' }
        array_scope :hoge_method, -> { 'Hoge' }
      end

      class Fuga
        extend ArrayScope

        array_scope :defined_method, -> { 'Fuga' }
      end
    end

    context do
      let(:objects) { [Hoge.new] }
      let(:method_name) { :defined_method }

      it { is_expected.to eq('Hoge') }
    end

    context do
      let(:objects) { [Fuga.new] }
      let(:method_name) { :defined_method }

      it { is_expected.to eq('Fuga') }
    end

    context do
      let(:objects) { [Hoge.new, Hoge.new] }
      let(:method_name) { :defined_method }

      it { is_expected.to eq('Hoge') }
    end

    context do
      let(:objects) { [Hoge.new, nil] }
      let(:method_name) { :defined_method }

      it { expect { subject }.to raise_error(ArrayScope::Error) }
    end

    context do
      let(:objects) { [Hoge.new, Fuga.new] }
      let(:method_name) { :defined_method }

      it { expect { subject }.to raise_error(ArrayScope::Error) }
    end

    context do
      let(:objects) { [Fuga.new] }

      it { expect { objects.scope(:hoge_method) }.to raise_error(ArrayScope::Error) }
    end
  end
end
