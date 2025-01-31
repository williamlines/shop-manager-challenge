require_relative './item'
require_relative './order'

class ShopRepository
  # Selecting all records
  # No arguments
  def all_items
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql, [])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.name = record['name']
      item.price = record['price']
      item.quantity = record['quantity']

      items << item
    end
    return items
  end

  def all_orders
    sql = 'SELECT id, customer_name, date_placed, item_id FROM orders;'
    result_set = DatabaseConnection.exec_params(sql, [])

    orders = []

    result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.date_placed = record['date_placed']
      order.item_id = record['item_id']

      orders << order
    end
    return orders
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def create_item(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES($1, $2, $3);'
    params = [item.name, item.price, item.quantity]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def create_order(order)
    sql = 'INSERT INTO orders (customer_name, date_placed, item_id) VALUES($1, $2, $3);'
    params = [order.customer_name, order.date_placed, order.item_id]

    DatabaseConnection.exec_params(sql, params)
    return nil
  end
end