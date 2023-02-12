pizzas <- c("Hawaiian", "Cheese", "Chicken BBQ")
pizza_prices <- c(120, 90, 130)
names(pizza_prices) <- pizzas

drinks <- c("Coke", "Sprite", "Orange juice")
drink_prices <- c(35, 35, 55)
names(drink_prices) <- drinks

sof <- c("Cash", "Card", "Promtpay")

f_pizza_order <- function() {
  cat("Hi, Welcome to Nyan Pizza, Meow\n")

  # ask customer's name
  cat("What's your name?\n")
  cust_name <- readLines("stdin", n=1)

  # greeting a customer
  cat("Nice to meet you", cust_name, "\n")

  order_count <- 1
  orders <- list()
  order_more <- "Y"
  while (order_more == "Y" || order_more == "y") {
    order <- list()
    # ask user about the order
    cat("What pizza would you like to order?\n")
    cat("[1] Hawaiian\n[2] Cheese\n[3] Chicken BBQ\n")
    pizza <- as.numeric(readLines("stdin", n=1))
    order[[1]] <- pizzas[pizza]
    
    cat("What drink would you like to order?\n")
    cat("[1] Coke\n[2] Sprite\n[3] Orange juice\n")
    drink <- as.numeric(readLines("stdin", n=1))
    order[[2]] <- drinks[drink]
    
    orders[[order_count]] <- order
    order_count <- order_count + 1

    # ask for another order
    cat("Do you want to have another order?\n")
    cat("[Y] Yes \n[N] No\n")
    order_more <- readLines("stdin", n=1)
  }

  total_price <- f_calculate_orders_price(orders) 

  # ask for applying coupon
  discounted_price <- total_price * (1 - f_calculate_discount())
  cat("Total price after discounted", discounted_price, "\n")

  # Ask customer payment's method
  cat("Do you want to pay by?\n")
  cat("[1] Cash\n[2] Card\n[3] Promtpay\n")
  payment_method <- as.numeric(readLines("stdin", n=1))
  f_payment(sof[payment_method])

  # process orders
  f_process_order(orders)
  cat(cust_name, "your order is ready\n")
  cat("Enjoy your food meowww\n")
}

f_calculate_orders_price <- function(orders) {
  cat("Your order are:\n")
  total <- 0
  for (order in orders) {
    pizza <- order[[1]]
    drink <- order[[2]]
    pizza_price <- pizza_prices[pizza]
    drink_price <- drink_prices[drink]
    cat("-", pizza, "pizza", pizza_price, "bath\n")
    cat("-", drink, drink_price, "bath\n")

    total <- total + pizza_price + drink_price
  }
  cat("Total:", total, "\n")
  total
}

f_calculate_discount <- function() {
  cat("Do you want to apply coupon?\n")
  cat("[Y] Yes \n[N] No\n")
  apply_code <- readLines("stdin", n=1)

  if (apply_code == "Y" || apply_code == "y") {
    cat("Enter your coupon code?\n")
    code <- readLines("stdin", n=1)
    if (code == "HALF") {
      cat("50% discount\n")
      return (0.5)
    } else if (code == "20DIS"){
      cat("20% discount\n")
      return (0.2)
    }
  }

  cat("No discount\n")
  return (0.0)
}

f_payment <- function(sof) {
  cat("Paying by", sof)
  for (i in 1:3) {
    Sys.sleep(1)
    cat(".")
  }
  cat("Transaction successful\n")
}

f_process_order <- function(orders) {
  for (order in orders) {
    cat("We are processing your order:", order[[1]], "Pizza and", order[[2]])
    for (i in 1:3) {
      Sys.sleep(1)
      cat(".")
    }
    cat("\n")
  }
}