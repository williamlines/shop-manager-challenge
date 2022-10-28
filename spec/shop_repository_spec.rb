require 'shop_repository'

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
end