require_relative '../config/environment'
require 'benchmark'
#Declare variables
# budget = ''
# max_size = ''
# selection = ''
# result = ''
# moving_on = ''



def welcome_new_customer
	#this is when a new customer enters
	puts "*Welcome to The Coach finder ©, please enter your name to begin:*"
    customer = gets.chomp

      puts "*Thank you #{customer}, please tell me your budget so I can get an idea of your price range,\n you can just enter a number like 500 or 1000:*"
      budget = gets.chomp

        puts "*Okay that's great, just one more thing before we scan for your results,\n what is your maximum size required in feet,\n you can just enter a number like 5 or 6: *"
        max_size = gets.chomp

        puts " Your name is #{customer}, your budget is $#{budget} and your max size is #{max_size}ft"
        puts "If this is incorrect type menu to return to menu and start over\n otherwise type y to continue"
        moving_on = gets.chomp
        case moving_on
        when "menu"
        	 loadscreen
           clearscreen
        	 welcome_screen
        when "y"

        new_customer = Customer.create(name: customer, budget: budget.to_i,max_size: max_size.to_i )
        scan_results(new_customer)
    else
    	puts "Sorry you typed an incorrect command, returning home"
      loadscreen
      clearscreen
    	welcome_screen
    	
    end
end

def scan_results(new_scan)
	puts "*****SCANNING********"
     loadscreen
     clearscreen

	puts "Okay I have scanned the results and have couches in your budget that match your size,"
 
    result = new_scan.compares
    
    if result == nil
    	puts "An error has occured, make sure you type budget or all"
    	scan_results(new_scan)
    end
 
    puts "Thank you #{new_scan.name}\n\n\n"

    puts "#{result.length}- Results."

    puts "\n"

    sleep(4)
    
    returning_commands(new_scan)
end



def returning_customer
	#this function is for returning
    
    	puts "*Welcome returning customer, please enter your name to begin:*"
    	customer = gets.chomp
    	if customer == 'menu'
    		loadscreen
    		clearscreen
    		welcome_screen
    	end
    	existing = Customer.find_by(name: customer)
    	
      case existing	
      when nil
    	puts "Unable to find customer by that name, \ntry again or type menu to return to home menu and create new customer"
      returning_customer
      else
    	puts "Thank you #{existing.name}"
    	returning_commands(existing)

    end

end


def returning_commands(existing)
  while true
	#CRUD commands for existing customer
	puts 'Here is a list of commands you can use.'
	puts 'info - lists current customer info'
	puts 'scan - performs a scan of couches available based on your budget and size requirements'
	puts 'order - place an order using the order id from scan results'
  puts 'check - checks current order if available'
  puts 'cancel - cancels all orders from customer'
	puts 'name - allows you to set a new customer name'
	puts 'budget - allows you to set a new budget'
	puts 'size - allows you to set a new max size for your scan results'
	puts 'delete - removes your existing customer data'
	puts 'menu - to return to home menu'
   moving_on = gets.chomp
 case moving_on

  #####################
    when "admin"
      admin_menu
  #####Secret admin menu #######
    when "info"
    	puts "name : #{existing.name}"
    	puts "budget :#{existing.budget}"
    	puts "max couch size :#{existing.max_size}ft"
    	sleep(3)
 	when "scan"
 		#returns a scan
 		scan_results(existing)

 	when "order"
 		new_order(existing)
    #around line 199
    sleep(3)
  when "check"
    order_check(existing)
    #around line 179
    sleep(3)

  when "cancel"
    puts "This will erase all current customer orders, type y to proceed."
    check = gets.chomp
    if check == "y"
      existing.orders.destroy_all
    else
      puts "Error has occured"
      break
    end

 	when "name"
 		puts "Current customer name is #{existing.name}"
 		puts "Please enter your new customer name"
 		change = gets.chomp
 		existing.name = change
 		existing.save
 		puts "Customer now known as #{existing.name}"
 		sleep(3)
 		#Change users name
 	when "budget"
 		puts "Current budget is #{existing.budget}"
 		puts "Please enter your new budget as a whole number eg. 1000"
 		change = gets.chomp
 		existing.budget = change
 		existing.save
 		puts "Budget now set as #{existing.budget}"
 		sleep(3)
 		#change users budget
 	when "size"
 		puts "Current max size is #{existing.max_size}"
 		puts "Please enter your new maximum size in feet as a whole number eg. 6"
 		change = gets.chomp
 		existing.max_size = change
 		existing.save
 		puts "Maximum size now set at #{existing.max_size}ft."
 		sleep(3)
 		#change users size
 	when "delete"
        puts "Are you sure? type yes to delete"
        delete = gets.chomp
        case delete
           when "yes"
           existing.destroy
           puts "User record destroyed"
           sleep(3)
           else
 		   puts "User not deleted, you did not type yes"
 		   sleep(3)
 		end
 		clearscreen
 		welcome_screen
 	when "help"
 		returning_commands
 	when 'menu'
 		#break out of current while loop and return to Welcome Screen
 		break
 	else
 		puts "Please check your spelling or caps and try entering the command again or type help"
 		sleep(3)
 	end
end
end

def order_check(user)

   puts "You have currently have #{user.orders.all.length} orders"
   # binding.pry
   # user.order.empty?
   user.orders.all.each do |orders|
        puts "#{orders.supplier_couch.couch.name} from #{orders.supplier_couch.supplier.name}"
        puts "Price paid $#{orders.supplier_couch.price}"
                          end                
end


def new_order(user)
  #creates a new order
  puts "Welcome #{user.name}\nHave you selected a couch you would like to order?\nIf so please enter the order id:"
begin
  order_id = gets.chomp
  order_id = Integer(order_id)
rescue
  puts "Please make sure you enter a valid number"
  retry
end
  
  begin 
    supplier_couch = SupplierCouch.find(order_id)
   
  rescue
     puts "An error has occured in your order, please try again with a correct Order ID\nUse scan if you are unsure.\n\n"
     welcome_screen
  end
  user.orders << Order.create(supplier_couch_id: supplier_couch.id)
  puts "Thank you for your order"

  supplier_couch.quantity -= 1
  user.budget -= supplier_couch.price
  supplier_couch.save
  user.save
  #Updates customer and supplier databases to reflect changes
  
  sleep(3)
end



def list_all_couches
	#returns list of all couches by name
	puts "Available Couches:"
	SupplierCouch.all.each do |items|
		puts "'#{items.couch.name}' available from #{items.supplier.name} for $#{items.price}"
		puts "size : #{items.couch.length_in_ft}ft\n\n"
	end
sleep(3)
puts"\n"
welcome_screen
end

def admin_menu
  puts "WELCOME TO ADMIN CONSOLE"
  binding.pry
end

def welcome_screen
puts "*Welcome to The Couch finder © home menu"
puts "Here is a list of commands you can use."
puts "help - reprints this list"
puts "new - opens up a new customer service"
puts "update - opens an existing customer account so you can order/update/delete your data"
puts "list - lists of all couches available"
# puts "stores - lists all stores in the database"
puts "quit - to exit the program"

#Opening welcome message
moving_on = gets.chomp
 case moving_on
 	when "help"
 		welcome_screen
 	when "new"
 		welcome_new_customer
 	when "update"
 		returning_customer
 	when "list"
 		list_all_couches
 	# when "stores"
 	# 	list_all_stores

 	when "quit"

 		exit

 	else
 		puts "Please check your spelling or caps and try entering the command again or type help"
 	end
end
###BEGIN Loading screen script
def loadscreen
spinner = Enumerator.new do |e|
  loop do
    e.yield '|'
    e.yield '/'
    e.yield '-'
    e.yield '\\'
  end
end

def clearscreen
	system "clear" or system "cls"
end

1.upto(100) do |i|
  progress = "=" * (i/5) unless i < 5
  printf("\rloading data: [%-20s] %d%% %s", progress, i, spinner.next)
  sleep(0.007)
end
end
####END loading screen script then clear screen
loadscreen
clearscreen
while true
	welcome_screen
end









