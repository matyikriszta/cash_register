require_relative 'spec_helper'
require_relative '../register.rb'
require 'pry-byebug'

describe Register do

  let(:register) { Register.new({2 => 4, 1 => 1}) }

  describe '.new' do
    it 'creates a new register' do
      expect(register).to_not eql nil
    end
  end

  describe '#denominations' do
    it 'should return the denominations' do
      register = Register.new({2 => 4})
      expect(register.denominations).to eql({2 => 4})
    end
  end

  describe "#change_given" do
    it 'should return 1 x £2 for £2' do
      register = Register.new({2 => 4})
      expect(register.change_given(2)).to eql({2 => 1})
    end

    it 'should return 2 x £2 for £4' do
      register = Register.new({2 => 4})
      expect(register.change_given(4)).to eql({2 => 2})
    end

    it 'should return 1 x £2, 1 x £1 for £3' do
      register = Register.new({2 => 2, 1 => 1})
      expect(register.change_given(3)).to eql({2 => 1, 1 => 1})
    end

    it 'should return 1 x £2, 1 x £1, 1 x 50p for £3.50' do
      register = Register.new({2 => 2, 1 => 1, 0.5 => 1})
      expect(register.change_given(3.50)).to eql({2 => 1, 1 => 1, 0.5 => 1})
    end

    it 'should return 1 x £2, 1 x £1, 1 x 50p, 1 x 20p for £3.70' do
      register = Register.new({2 => 2, 1 => 1, 0.5 => 1, 0.2 => 1})
      expect(register.change_given(3.70)).to eql({2 => 1, 1 => 1, 0.5 => 1, 0.2 => 1})
    end
  end

  describe '#transaction' do
    it "accept balance due and payment amount" do
      expect(register.transaction(10, 10)).to_not eql nil
    end

    it "should return the correct change denominations" do
      register = Register.new({0.2 => 2, 0.05 => 1, 0.02 => 2})
      expect(register.transaction(4.51, 5)).to eql({0.2 => 2, 0.05 => 1, 0.02 => 2})
    end

  it "should return the correct change denominations" do
      register = Register.new({2 => 2, 0.5 => 1, 0.1 => 1, 0.02 => 2})
      expect(register.transaction(15.36, 20)).to eql({2 => 2, 0.5 => 1, 0.1 => 1, 0.02 => 2})
    end

    it "should return the correct change with limited coins" do
      register = Register.new({2 => 1, 1 => 2, 0.5 => 1, 0.1 => 1, 0.02 => 2})
      expect(register.transaction(15.36, 20)).to eql({2 => 1, 1 => 2, 0.5 => 1, 0.1 => 1, 0.02 => 2})
    end

    it "should return the correct change with limited coins" do
      register = Register.new({2 => 1, 1 => 1, 0.5 => 2, 0.1 => 1, 0.02 => 2})
      expect(register.transaction(15.36, 20)).to eql({2 => 1, 1 => 1, 0.5 => 2, 0.1 => 1, 0.02 => 2})
    end
  end

end