#' Install Staticrypt
#'
#' Installs Staticrypt globally using npm if it is not already installed.
#' Requires Node.js and npm to be installed on your system.
#'
#' @param force Logical. If `TRUE`, skips the user prompt and forces installation.
#'   Default is `FALSE`.
#' @return Logical. Returns `TRUE` if installation was successful, `FALSE` otherwise.
#' @details This function checks if Node.js and npm are available, then installs
#'   Staticrypt globally using npm. If `force` is `FALSE`, it prompts the user
#'   for confirmation before proceeding with the installation.
#' @examples
#' \dontrun{
#' install_staticrypt()
#' }
#' @export
install_staticrypt <- function(force = FALSE) {
  is_node_available()
  if (!force && interactive()) {
    message("This will install Staticrypt globally on your machine.")
    choice <- utils::menu(c("Yes", "No"), title = "Do you want to proceed?")
    if (choice != 1) {
      message("Installation cancelled.")
      return(FALSE)
    }
  }
  result <- system("npm install -g staticrypt")
  if (result != 0) {
    stop("Failed to install Staticrypt. Please check your npm configuration.")
  }
  return(TRUE)
}

# Internal function to check if Node.js and npm are available
is_node_available <- function() {
  if (Sys.which("npm") == "") {
    stop("npm is missing from your environment. You can install Node.js and npm from here: https://nodejs.org/en/download/package-manager")
  }
  if (Sys.which("node") == "") {
    stop("Node.js is missing from your environment. You can install Node.js and npm from here: https://nodejs.org/en/download/package-manager")
  }
  return(TRUE)
}

# Internal function to check if Staticrypt is available
is_staticrypt_available <- function() {
  if (Sys.which("staticrypt") == "") {
    warning("Staticrypt is not installed.")
    ok <- install_staticrypt()
    if (!ok) {
      stop("Staticrypt installation failed. Please install it manually.")
    }
    return(FALSE)
  }
  return(TRUE)
}

#' Check System Requirements
#'
#' Checks if Node.js, npm, and Staticrypt are available on your system.
#'
#' @return Logical. Returns `TRUE` if all requirements are met.
#' @details This function verifies that Node.js, npm, and Staticrypt are installed
#'   and available in the system PATH. It will attempt to install Staticrypt if it is not found.
#' @examples
#' \dontrun{
#' check_system()
#' }
#' @export
check_system <- function() {
  is_node_available()
  is_staticrypt_available()
  return(TRUE)
}