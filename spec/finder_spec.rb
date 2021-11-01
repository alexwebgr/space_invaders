require_relative 'spec_helper'
require_relative '../app/finder'

RSpec.describe Finder, type: :service do
  include_context("file_helper")

  describe 'checking JupiterInvader and MarsInvader' do
    describe 'when there is a radar signal with one mars and one jupiter invader' do
      let(:radar_signal) { file_fixture('one_mars_one_jupiter.txt').read }
      let(:expected_output) { {
        "MarsInvader" => [{ :columns => [0], :row => 0 }],
        "JupiterInvader" => [{ :columns => [0], :row => 9 }]
      } }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader, JupiterInvader]).identify_invaders).to eq(expected_output)
      end
    end

    describe 'when there is an unknown invader supplied' do
      let(:radar_signal) { file_fixture('one_mars_one_jupiter.txt').read }

      it 'raises an exception' do
        expect { described_class.new(radar_signal, [UnknownInvader]).identify_invaders }.to raise_error NameError
      end
    end

    describe 'when there is a radar signal with a lot of noise' do
      let(:radar_signal) { file_fixture('valid_radar_signal.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader, JupiterInvader]).identify_invaders).to eq({ "MarsInvader" => [], "JupiterInvader" => [] })
      end
    end
  end

  describe 'checking for MarsInvader' do
    describe 'when there is a radar signal with one invader' do
      let(:radar_signal) { file_fixture('mars/one_invader.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [0], :row => 0 }] })
      end
    end

    describe 'when there is a radar signal with one invader and noise on the left' do
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

    describe 'when there is a radar signal with one invader and noise on the left but misaligned' do
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

    describe 'when there is a radar signal with two invaders in the same column' do
      let(:radar_signal) { file_fixture('mars/two_invaders_w_noise_same_column.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [1], :row => 0 }, { :columns => [1], :row => 8 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and half invader at the bottom' do
      let(:radar_signal) { file_fixture('mars/two_invaders_same_column_half_invader_bottom.txt').read }

      it 'returns the position for the first two' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [1], :row => 0 }, { :columns => [1], :row => 8 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and half invader at the top' do
      let(:radar_signal) { file_fixture('mars/two_invaders_same_column_half_invader_top.txt').read }

      it 'returns the position for the first two' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [0], :row => 5 }, { :columns => [0], :row => 13 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and two invaders in the same row' do
      let(:radar_signal) { file_fixture('mars/two_invaders_same_row_two_invaders_same_column.txt').read }

      it 'returns the position for the first two' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [0, 18], :row => 0 }, { :columns => [0, 18], :row => 8 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and half invader in the middle' do
      let(:radar_signal) { file_fixture('mars/two_invaders_same_column_half_invader_middle.txt').read }

      it 'returns the position for the two' do
        expect(described_class.new(radar_signal, [MarsInvader]).identify_invaders).to eq({ "MarsInvader" => [{ :columns => [0], :row => 0 }, { :columns => [0], :row => 11 }] })
      end
    end
  end

  describe 'checking JupiterInvader' do
    describe 'when there is a radar signal with one invader' do
      let(:radar_signal) { file_fixture('jupiter/one_invader.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0], :row => 0 }] })
      end
    end

    describe 'when there is a radar signal with one invader and noise on the left' do
      let(:radar_signal) { file_fixture('jupiter/one_invader_w_noise.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [1], :row => 0 }] })
      end
    end

    describe 'when there is a radar signal with one invader and noise on the top' do
      let(:radar_signal) { file_fixture('jupiter/one_invader_top.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0], :row => 1 }] })
      end
    end

    describe 'when there is a radar signal with one invader and noise on the left but misaligned' do
      let(:radar_signal) { file_fixture('jupiter/one_invader_misaligned.txt').read }

      it 'returns an empty array, nothing found' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same row' do
      let(:radar_signal) { file_fixture('jupiter/two_invaders_same_row.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0, 11], :row => 0 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column' do
      let(:radar_signal) { file_fixture('jupiter/two_invaders_w_noise_same_column.txt').read }

      it 'returns its position' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0], :row => 0 }, { :columns => [0], :row => 10 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and half invader at the bottom' do
      let(:radar_signal) { file_fixture('jupiter/two_invaders_same_column_half_invader_bottom.txt').read }

      it 'returns the position for the first two' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0], :row => 0 }, { :columns => [0], :row => 10 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and half invader at the top' do
      let(:radar_signal) { file_fixture('jupiter/two_invaders_same_column_half_invader_top.txt').read }

      it 'returns the position for the first two' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0], :row => 4 }, { :columns => [0], :row => 14 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and two invaders in the same row' do
      let(:radar_signal) { file_fixture('jupiter/two_invaders_same_row_two_invaders_same_column.txt').read }

      it 'returns the position for the first two' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0, 11], :row => 0 }, { :columns => [0, 11], :row => 8 }] })
      end
    end

    describe 'when there is a radar signal with two invaders in the same column and half invader in the middle' do
      let(:radar_signal) { file_fixture('jupiter/two_invaders_same_column_half_invader_middle.txt').read }

      it 'returns the position for the two' do
        expect(described_class.new(radar_signal, [JupiterInvader]).identify_invaders).to eq({ "JupiterInvader" => [{ :columns => [0], :row => 0 }, { :columns => [0], :row => 14 }] })
      end
    end
  end
end