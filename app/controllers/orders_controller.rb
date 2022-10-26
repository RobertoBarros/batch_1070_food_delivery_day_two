require_relative '../views/orders_view'

class OrdersController

  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
  end

  def add
    # Listar todos os meals e selecionar pelo index
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @orders_view.ask_index
    meal = meals[index]

    # Listar todos os customers e selecionar pelo index
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @orders_view.ask_index
    customer = customers[index]

    # Listar todos os riders e selecionar pelo index
    riders = @employee_repository.all_riders
    @orders_view.display_riders(riders)
    index = @orders_view.ask_index
    employee = riders[index]

    order = Order.new(meal: meal, customer: customer, employee: employee)

    @order_repository.create(order)


  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @orders_view.display(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.undelivered_orders.select { |order| order.employee.id == employee.id }
    @orders_view.display(orders)
    index = @orders_view.ask_index
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end


end
