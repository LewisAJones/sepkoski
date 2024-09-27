combine_args <- function(default, user) {
  #Remove default arguments for user input
  rm <- which(names(default) %in% names(user))
  if (length(rm) > 0) {
    default <- default[-rm]
  }
  # Add user args
  return(append(default, user))
}
