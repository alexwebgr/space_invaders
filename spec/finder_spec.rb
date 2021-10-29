require_relative 'spec_helper'
require_relative '../app/finder'

RSpec.describe Finder, type: :service do
  include_context("file_helper")

  describe 'checking for MarsInvader' do
    describe 'when there is a radar signal with one invader' do
      let(:radar_signal) { file_fixture('mars/one_invader.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [0], :row => 0 }] })
      end
    end

    describe 'when there is a radar signal with one invader and some noise on the left' do
      let(:radar_signal) { file_fixture('mars/one_invader_w_noise.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [1], :row => 0 }] })
      end
    end

    describe 'when there is a radar signal with one invader and noise on the top' do
      let(:radar_signal) { file_fixture('mars/one_invader_top.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [0], :row => 1 }] })
      end
    end

    describe 'when there is a radar signal with one invader with noise on the left but misaligned' do
      let(:radar_signal) { file_fixture('mars/one_invader_misaligned.txt').read }

      it 'returns an empty array, nothing found' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ 'MarsInvader' => [] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same row' do
      let(:radar_signal) { file_fixture('mars/two_invaders_same_row.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [0, 18], :row => 0 }] })
      end
    end

    describe 'when there is a radar signal with a lot of noise' do
      let(:radar_signal) { file_fixture('valid_radar_signal.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ 'MarsInvader' => [] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column' do
      let(:radar_signal) { file_fixture('mars/two_invaders_w_noise_same_column.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [1], :row => 0 }, { :columns => [1], :row => 8 }] })
      end
    end
  end
end