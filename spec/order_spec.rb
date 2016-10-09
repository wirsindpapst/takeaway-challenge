require 'order'
require 'menu'

describe Order do

  subject{described_class.new(menu, interface)}

  #  let(:menu) {double(:menu, "1" => "Pizza", "2" => "Steak")}
   let(:interface) {double(:interface)}

   subject{described_class.new(Menu.new, interface)}

   menu = Menu.new

   it {is_expected.to respond_to(:add_dish).with(1).argument}

  #  let(:prices) {double(:prices, 1 => 5, 2 => 10)}
  #  let(:selection) {double(:current_selection, [1, 3])}
  # let(:orders_array) {double(:orders_array, [[2, 3, 30], [1, 1, 5]])}



  describe '#initialize' do
    it 'contains an empty order array' do
      expect(subject.orders_array.count).to eq 0
    end
    it 'contains an empty current order array' do
      expect(subject.current_selection.count).to eq 0
    end
    it 'initializes with a running total of 0' do
      expect(subject.running_total).to eq 0
    end
  end

  describe 'add_dish' do
    it 'adds a dish to the current order array' do
      allow(interface).to receive(:select_quantity)
      subject.add_dish(5)
      expect(subject.current_selection).to include 5
    end
  end


  describe 'add_quantity' do
    it 'adds a quantity to the current order array' do
      allow(interface).to receive(:select_quantity).and_return "5"
      # allow(menu).to receive(:prices)
      subject.add_dish(1)
      subject.add_quantity(5)
      expect(subject.current_selection[1]).to eq 5
    end
  end

  describe 'calculate_subtotal' do
    it 'looks in the menu for the price of a dish' do
      allow(interface).to receive(:select_quantity).and_return "5"
      allow(interface).to receive(:add_or_review)
      subject.add_dish(5)
      subject.add_quantity(1)
      expect(menu.prices[subject.current_selection[0]]).to eq 5.50
    end

    it "uses the provided quantity to base its calculation" do
      allow(interface).to receive(:select_quantity).and_return "5"
      allow(interface).to receive(:add_or_review)
      subject.add_dish(5)
      subject.add_quantity(6)
      expect(subject.current_selection[1]).to eq 6
    end
    #
    # it "adds the price to the current selection" do
    #   allow(interface).to receive(:select_quantity).and_return "5"
    #   allow(interface).to receive(:add_or_review)
    #   subject.add_dish(5)
    #   subject.add_quantity(6)
    #   subject.calculate_subtotal
    #   expect(subject.current_selection.count).to eq 3
    # end

    it 'calculates the price of the current_selection' do
      allow(interface).to receive(:select_quantity).and_return "5"
      allow(interface).to receive(:add_or_review)
      allow(interface).to receive(:add_or_review)
      allow(interface).to receive(:return_order)
      # allow(menu).to receive(:prices).and_return "5"
      # allow(menu).to receive(:menu). and_return "2"
      subject.add_dish(5)
      subject.add_quantity(1)
      expect(subject.calculate_subtotal).to eq 5.5
    end
  end

  describe '#reset_order' do
    before do
      allow(interface).to receive(:select_quantity).and_return "5"
      allow(interface).to receive(:add_or_review)
      allow(interface).to receive(:select_dish)
      # allow(menu).to receive(:prices).and_return "5"
      # allow(menu).to receive(:menu).and_return "2"
      subject.add_dish(5)
      subject.add_quantity(1)
      subject.reset_order
    end
    it 'resets the current_selection array' do
      expect(subject.current_selection).to eq []
    end
    it 'resets the orders array' do
      expect(subject.orders_array).to eq []
    end
  it 'resets the running_total value' do
    expect(subject.running_total).to eq 0
  end
end


  context 'selecting more than one dish' do
    it 'allows for multiple dishes to be stored in the orders array' do
      allow(interface).to receive(:select_quantity).and_return "5"
      allow(interface).to receive(:add_or_review)
      allow(interface).to receive(:return_order)
      # allow(menu).to receive(:prices).and_return "5"
      # allow(menu).to receive(:menu)
      subject.add_dish(5)
      subject.add_quantity(1)
      subject.calculate_subtotal
      subject.add_dish(2)
      subject.add_quantity(3)
      subject.calculate_subtotal
      expect(subject.orders_array.count).to eq 2
    end

  end



  # describe '#calculate_subtotal' do
  #   it 'calculates the the cost a single item request (dish * quantity)' do
  #     expect
  #   end
  # end
  #
  # describe '#reset order' do
  #   it 'resets the order' do
  #
  #
  #   end
  # end


end
