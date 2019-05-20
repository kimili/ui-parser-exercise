require 'json'
require 'ui_parser'

data = File.read './data/SystemViewController.json'
parser = UIParser.new JSON.parse(data)

describe UIParser do
  describe '.parse' do
    describe 'Class Selectors' do
      context 'give `Input`' do
        it "returns an array of 26 matches" do
          expect(parser.parse('Input').length).to eql(26)
        end
      end

      context 'give `StackView`' do
        it "returns an array of 6 matches" do
          expect(parser.parse('StackView').length).to eql(6)
        end
      end

      context 'give `Button`' do
        it "returns an array of 1 match" do
          expect(parser.parse('Button').length).to eql(1)
        end
      end

      context 'give `Foo`' do
        it "returns an array of 0 matches" do
          expect(parser.parse('Foo').length).to eql(0)
        end
      end
    end

    describe 'ClassName Selectors' do
      context 'give `.container`' do
        it "returns an array of 6 matches" do
          expect(parser.parse('.container').length).to eql(6)
        end
      end
      
      context 'give `.column`' do
        it "returns an array of 3 matches" do
          expect(parser.parse('.column').length).to eql(3)
        end
      end      

      context 'give `.foo`' do
        it "returns an array of 0 matches" do
          expect(parser.parse('.foo').length).to eql(0)
        end
      end
    end

    describe 'Identifier Selectors' do
      context 'give `#apply`' do
        it "returns an array of 1 match" do
          expect(parser.parse('#apply').length).to eql(1)
        end
      end

      context 'give `#System`' do
        it "returns an array of 1 match" do
          expect(parser.parse('#System').length).to eql(1)
        end
      end
      
      context 'give `#windowMode`' do
        it "returns an array of 1 match" do
          expect(parser.parse('#windowMode').length).to eql(1)
        end
      end  

      context 'give `#foo`' do
        it "returns an array of 0 matches" do
          expect(parser.parse('#foo').length).to eql(0)
        end
      end
    end

  end
end