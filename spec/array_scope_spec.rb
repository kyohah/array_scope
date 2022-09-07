# frozen_string_literal: true

require "spec_helper"

describe ArrayScope do
  it "has a version number" do
    expect(ArrayScope::VERSION).not_to be nil
  end

  describe '#class_name_key' do
    subject { obj.send(:class_name_key, class_name) }

    let(:obj) { Class.new { extend ArrayScope }  }

    context do
      let(:class_name) { 'Hoge' }

      it { is_expected.to eq('hoge') }
    end

    context do
      let(:class_name) { 'HogeName' }

      it { is_expected.to eq('hoge_name') }
    end

    context do
      let(:class_name) { 'Foge::Name' }

      it { is_expected.to eq('foge__name') }
    end
  end
end
