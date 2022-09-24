# frozen_string_literal: true

require 'spec_helper'

describe ArrayScope do
  describe '#new' do
    subject { ArrayScope.new(objects).defined_method }

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
      it { is_expected.to eq('Hoge') }
    end

    context do
      let(:objects) { [Fuga.new] }
      it { is_expected.to eq('Fuga') }
    end

    context do
      let(:objects) { [Hoge.new, Hoge.new] }
      it { is_expected.to eq('Hoge') }
    end

    context do
      let(:objects) { [Hoge.new, nil] }
      it { expect { subject }.to raise_error(NoMethodError) }
    end

    context do
      let(:objects) { [Hoge.new, Fuga.new] }
      it { expect { subject }.to raise_error(NoMethodError) }
    end

    context do
      let(:objects) { [Fuga.new] }
      it { expect { objects.hoge_method }.to raise_error(NoMethodError) }
    end
  end
end
