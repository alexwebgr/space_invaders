require_relative 'spec_helper'
require_relative '../app/invaders/mars_invader'

RSpec.describe MarsInvader, type: :service do
  include_context("file_helper")

  describe 'when there is a radar signal with one invader' do
    let(:radar_signal) { file_fixture('mars/one_invader.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [0], :row => 0 }]
    end
  end

  describe 'when there is a radar signal with one invader and noise on the left' do
    let(:radar_signal) { file_fixture('mars/one_invader_w_noise.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [1], :row => 0 }]
    end
  end

  describe 'when there is a radar signal with one invader and noise on the top' do
    let(:radar_signal) { file_fixture('mars/one_invader_top.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [0], :row => 1 }]
    end
  end

  describe 'when there is a radar signal with one invader and noise on the left but misaligned' do
    let(:radar_signal) { file_fixture('mars/one_invader_misaligned.txt').read }

    it 'returns an empty array, nothing found' do
      expect(described_class.new(radar_signal).identify).to eq []
    end
  end

  describe 'when there is a radar signal with two invaders in the same row' do
    let(:radar_signal) { file_fixture('mars/two_invaders_same_row.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [0, 18], :row => 0 }]
    end
  end

  describe 'when there is a radar signal with two invaders in the same column' do
    let(:radar_signal) { file_fixture('mars/two_invaders_w_noise_same_column.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [1], :row => 0 }, { :columns => [1], :row => 8 }]
    end
  end

  describe 'when there is a radar signal with two invaders in the same column and two invaders in the same row' do
    let(:radar_signal) { file_fixture('mars/two_invaders_same_row_two_invaders_same_column.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [0, 18], :row => 0 }, { :columns => [0, 18], :row => 8 }]
    end
  end

  describe 'when there is a radar signal with two invaders in the same column and half invader at the bottom' do
    let(:radar_signal) { file_fixture('mars/two_invaders_same_column_half_invader_bottom.txt').read }

    it 'returns the position for the first two' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [1], :row => 0 }, { :columns => [1], :row => 8 }]
    end
  end

  describe 'when there is a radar signal with two invaders in the same column and half invader at the top' do
    let(:radar_signal) { file_fixture('mars/two_invaders_same_column_half_invader_top.txt').read }

    it 'returns the position for the first two' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [0], :row => 5 }, { :columns => [0], :row => 13 }]
    end
  end

  describe 'when there is a radar signal with two invaders in the same column and half invader in the middle' do
    let(:radar_signal) { file_fixture('mars/two_invaders_same_column_half_invader_middle.txt').read }

    it 'returns the position for the two' do
      expect(described_class.new(radar_signal).identify).to eq [{ :columns => [0], :row => 0 }, { :columns => [0], :row => 11 }]
    end
  end
end