actions <- c("rock", "paper", "scissors")

f_pao_ying_chub_game <- function() {
  cat("Hi, Welcome to Nyan Game, Meow\n")
  cat("Press Q to exit\n")
  ai_score <- 0
  your_score <- 0

  while (T) {
    # take action
    ai_action <- sample(actions, 1)
    your_action <- f_your_action()
    
    if (your_action == "Q") {
      # exit game
      break
    }

    # find winner
    winner <- f_who_win(your_action, ai_action)
    if (winner == "you") {
      your_score <- your_score + 1
    } else if (winner == "ai") {
      ai_score <- ai_score + 1
    }

    cat("Score you:", your_score, "ai:", ai_score, "\n")
  }
  cat("See you again meowww...\n")
}

f_your_action <- function() {
  cat("Enter a choice [1] rock [2] paper [3] scissors : ")
  input <- readLines("stdin", n=1)
  if (input == "Q" || input == "q") {
    return ("Q")
  }
  choice <- as.numeric(input)
  actions[[choice]]
}

f_who_win <- function(user_action, ai_action) {
  cat("Your action", user_action, "\n")
  cat("AI action", ai_action, "\n")
  if (user_action == ai_action) {
    cat("Both players selected", user_action, "It's a tie!\n")
    return ("tie")
  } else if (user_action == "rock") {
    if (ai_action == "scissors") {
      cat("Rock smashes scissors! You win!\n")
      return ("you")
    } else {
      cat("Paper covers rock! You lose.\n")
      return ("ai")
    }
  } else if (user_action == "paper") {
    if (ai_action == "rock") {
      cat("Paper covers rock! You win!\n")
      return ("you")
    } else {
      cat("Scissors cuts paper! You lose.\n")
      return ("ai")
    }
  } else if (user_action == "scissors") {
    if (ai_action == "paper") {
      cat("Scissors cuts paper! You win!\n")
      return ("you")
    } else {
      cat("Rock smashes scissors! You lose.\n")
      return ("ai")
    }
  }
}