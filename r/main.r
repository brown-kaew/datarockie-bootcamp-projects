source("pizza.r")
source("game.r")

cat("Hi, Welcome to our app.", sep = "\n")

# get input from user
cat("Select mode\n")
cat("[1] Pizza Order\n[2] Pao Ying Chub Game\n")
mode <- readLines("stdin", n=1)
if (mode == "1") {
  f_pizza_order()
} else {
  f_pao_ying_chub_game()
}