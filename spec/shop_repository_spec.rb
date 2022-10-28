require 'shop_repository'
require_relative '../lib/item'
require_relative '../lib/order'

def reset_table
  seed_sql = File.read('spec/seeds_shop.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_library_test' })
  connection.exec(seed_sql)
end

describe ShopRepository do
  before(:each) do 
    reset_table
  end

  it "can list all items" do
    repo = ShopRepository.new

    items = repo.all_items

    expect(items.length).to eq 5
    expect(items[0].name).to eq 'Apple'
    expect(items[4].id).to eq '5'
    expect(items[2].quantity).to eq '10'
  end

  it "can list all orders" do
    repo = ShopRepository.new

    orders = repo.all_orders

    expect(orders.length).to eq 3
    expect(orders[2].id).to eq '3'
    expect(orders[1].customer_name).to eq 'Bob'
    expect(orders[0].date_placed).to eq '2022-10-25'
    expect(orders[0].item_id).to eq '1'
  end
  it "can create a new item" do
    repo = ShopRepository.new
    item = Item.new
    item.name = 'Frying Pan'
    item.price = '1500'
    item.quantity = '13'

    repo.create_item(item)
    items = repo.all_items
    expect(items.length).to eq 6
    expect(items[-1].name).to eq "Frying Pan"
  end

  it "can create a new order" do
    repo = ShopRepository.new
    order = Order.new
    order.customer_name = 'David'
    order.date_placed = '2022-10-28'
    order.item_id = '3'

    repo.create_order(order)
    orders = repo.all_orders
    expect(orders.length).to eq 4
    expect(orders[-1].customer_name).to eq "David"
  end
end