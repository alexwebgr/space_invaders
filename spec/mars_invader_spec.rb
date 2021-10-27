require_relative 'spec_helper'
require_relative '../app/invaders/mars_invader'

RSpec.describe MarsInvader, type: :service do
  include_context("file_helper")

  describe 'when there is a radar signal with one invader' do
    let(:radar_signal) { file_fixture('one_invader.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq [0, [0]]
    end
  end

  describe 'when there is a radar signal with one invader and some noise on the left' do
    let(:radar_signal) { file_fixture('one_invader_w_noise.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq  [0, [1]]
    end
  end

  describe 'when there is a radar signal with one invader and noise on the top' do
    let(:radar_signal) { file_fixture('one_invader_top.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq  [1, [0]]
    end
  end

  describe 'when there is a radar signal with one invader with noise on the left but misaligned' do
    let(:radar_signal) { file_fixture('one_invader_one_row_misaligned.txt').read }

    it 'returns an empty array, nothing found' do
      expect(described_class.new(radar_signal).identify).to eq  []
    end
  end

  describe 'when there is a radar signal with two invaders in the same row and some noise around them' do
    let(:radar_signal) { file_fixture('two_invaders_one_row.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq  [0, [0, 18]]
    end
  end

  xdescribe 'when there is a radar signal with two invaders in the same column and some noise around them' do
    let(:radar_signal) { file_fixture('two_invaders_w_noise.txt').read }

    it 'returns its position' do
      expect(described_class.new(radar_signal).identify).to eq  [[0, 0], [9, 0]]
    end
  end
end