#' Staticrypt Wrapper Function with Command Print Option and User-Specified String
#'
#' This function is an R wrapper for the Staticrypt CLI tool. It allows users to encrypt or decrypt files using various customizable options, includes type checking for each argument, offers the option to print the resulting command without executing it, and allows the inclusion of a user-specified string.
#'
#' @param files Character. One or more filenames to encrypt/decrypt.
#' @param directory Character. Directory where the generated files will be saved (default: NULL).
#' @param recursive Boolean. Whether to recursively encrypt the input directory (default: FALSE).
#' @param password Character. Password for encryption (default: NULL, prompts if empty).
#' @param short Boolean. Hide "short password" warning (default: FALSE).
#' @param decrypt Boolean. Flag to decrypt files (default: FALSE).
#' @param remember Integer. Expiration in days for "Remember me" checkbox (default: NULL).
#' @param salt Character. 32-character hexadecimal string used as salt (default: NULL).
#' @param share Character. URL for auto-decrypting link (default: NULL).
#' @param share_remember Boolean. Auto-enable "Remember me" in the share link (default: FALSE).
#' @param config Character. Path to the config file (default: NULL).
#' @param template Character. Path to custom HTML template (default: NULL).
#' @param template_button Character. Label for the decrypt button (default: NULL).
#' @param template_color_primary Character. Primary color for the button (default: NULL).
#' @param template_color_secondary Character. Secondary color for the background (default: NULL).
#' @param template_instructions Character. Special instructions for the user (default: NULL).
#' @param template_error Character. Error message on wrong password (default: NULL).
#' @param template_placeholder Character. Placeholder for password input (default: NULL).
#' @param template_remember Character. Label for "Remember me" checkbox (default: NULL).
#' @param template_title Character. Title for the HTML page (default: NULL).
#' @param template_toggle_hide Character. Alt text for hiding the password (default: NULL).
#' @param template_toggle_show Character. Alt text for showing the password (default: NULL).
#' @param print_cmd Boolean. Whether to print the resulting command instead of executing it (default: FALSE).
#' @param user_string Character. A user-specified string to be appended to the command (default: NULL).
#'
#' @return Executes the Staticrypt CLI with the specified options or prints the command if `print_cmd` is `TRUE`.
#' @export
#'
#' @examples
#' # Encrypt a file with a password
#' # `print_cmd = TRUE` Only outputs the command to be passed to `system()`
#' staticryptr(
#'   "index.html",
#'   password = "yourpassword",
#'   print_cmd = TRUE
#' )
#'
#' # Decrypt a file (assuming you have the correct configuration)
#' staticryptr(
#'   "index.html",
#'   decrypt = TRUE,
#'   print_cmd = TRUE
#' )
#'
#' # Encrypt multiple files with custom options
#' staticryptr(
#'   files = c("page1.html", "page2.html"),
#'   password = "securepassword",
#'   template = "custom_template.html",
#'   template_color_primary = "#3498db",
#'   template_instructions = "Enter the password to access the page.",
#'   print_cmd = TRUE
#' )
#'
#' # Encrypt a directory recursively
#' staticryptr(
#'   files = "_output/",
#'   directory = ".",
#'   password = "yourverylongpassword",
#'   short = TRUE,
#'   recursive = TRUE,
#'   print_cmd = TRUE
#' )
staticryptr <- function(files,
                        directory = NULL,
                        recursive = FALSE,
                        password = NULL,
                        short = FALSE,
                        decrypt = FALSE,
                        remember = NULL,
                        salt = NULL,
                        share = NULL,
                        share_remember = FALSE,
                        config = NULL,
                        template = NULL,
                        template_button = NULL,
                        template_color_primary = NULL,
                        template_color_secondary = NULL,
                        template_instructions = NULL,
                        template_error = NULL,
                        template_placeholder = NULL,
                        template_remember = NULL,
                        template_title = NULL,
                        template_toggle_hide = NULL,
                        template_toggle_show = NULL,
                        print_cmd = FALSE,
                        user_string = NULL) {
  # Type checking
  if (!is.character(files)) {
    stop("files must be a character vector.")
  }
  if (!is.null(config) &&
    !is.character(config)) {
    stop("config must be a character string or NULL.")
  }
  if (!is.null(directory) &&
    !is.character(directory)) {
    stop("directory must be a character string or NULL.")
  }
  if (!is.logical(decrypt)) {
    stop("decrypt must be a boolean.")
  }
  if (!is.null(password) &&
    !is.character(password)) {
    stop("password must be a character string or NULL.")
  }
  if (!is.logical(recursive)) {
    stop("recursive must be a boolean.")
  }
  if (!is.null(remember) &&
    (!is.numeric(remember) ||
      remember < 0)) {
    stop("remember must be a non-negative integer or NULL.")
  }
  if (!is.null(salt) &&
    (!is.character(salt) ||
      nchar(salt) != 32)) {
    stop("salt must be a 32-character hexadecimal string or NULL.")
  }
  if (!is.null(share) &&
    !is.character(share)) {
    stop("share must be a character string or NULL.")
  }
  if (!is.logical(share_remember)) {
    stop("share_remember must be a boolean.")
  }
  if (!is.logical(short)) {
    stop("short must be a boolean.")
  }
  if (!is.null(template) &&
    !is.character(template)) {
    stop("template must be a character string or NULL.")
  }
  if (!is.null(template_button) &&
    !is.character(template_button)) {
    stop("template_button must be a character string or NULL.")
  }
  if (!is.null(template_color_primary) &&
    !is.character(template_color_primary)) {
    stop("template_color_primary must be a character string or NULL.")
  }
  if (!is.null(template_color_secondary) &&
    !is.character(template_color_secondary)) {
    stop("template_color_secondary must be a character string or NULL.")
  }
  if (!is.null(template_instructions) &&
    !is.character(template_instructions)) {
    stop("template_instructions must be a character string or NULL.")
  }
  if (!is.null(template_error) &&
    !is.character(template_error)) {
    stop("template_error must be a character string or NULL.")
  }
  if (!is.null(template_placeholder) &&
    !is.character(template_placeholder)) {
    stop("template_placeholder must be a character string or NULL.")
  }
  if (!is.null(template_remember) &&
    !is.character(template_remember)) {
    stop("template_remember must be a character string or NULL.")
  }
  if (!is.null(template_title) &&
    !is.character(template_title)) {
    stop("template_title must be a character string or NULL.")
  }
  if (!is.null(template_toggle_hide) &&
    !is.character(template_toggle_hide)) {
    stop("template_toggle_hide must be a character string or NULL.")
  }
  if (!is.null(template_toggle_show) &&
    !is.character(template_toggle_show)) {
    stop("template_toggle_show must be a character string or NULL.")
  }
  if (!is.logical(print_cmd)) {
    stop("print_cmd must be a boolean.")
  }
  if (!is.null(user_string) &&
    !is.character(user_string)) {
    stop("user_string must be a character string or NULL.")
  }

  # Construct the CLI command
  cmd <- paste(
    "npx staticrypt",
    paste(files, collapse = " "),
    if (!is.null(config)) {
      paste("--config", shQuote(config))
    } else {
      ""
    },
    if (!is.null(directory)) {
      paste("--directory", shQuote(directory))
    } else {
      ""
    },
    if (decrypt) {
      "--decrypt"
    } else {
      ""
    },
    if (!is.null(password)) {
      paste("--password", shQuote(password))
    } else {
      ""
    },
    if (recursive) {
      "--recursive"
    } else {
      ""
    },
    if (!is.null(remember)) {
      paste("--remember", remember)
    } else {
      ""
    },
    if (!is.null(salt)) {
      paste("--salt", shQuote(salt))
    } else {
      ""
    },
    if (!is.null(share)) {
      paste("--share", shQuote(share))
    } else {
      ""
    },
    if (share_remember) {
      "--share-remember"
    } else {
      ""
    },
    if (short) {
      "--short"
    } else {
      ""
    },
    if (!is.null(template)) {
      paste("--template", shQuote(template))
    } else {
      ""
    },
    if (!is.null(template_button)) {
      paste("--template-button", shQuote(template_button))
    } else {
      ""
    },
    if (!is.null(template_color_primary)) {
      paste(
        "--template-color-primary",
        shQuote(template_color_primary)
      )
    } else {
      ""
    },
    if (!is.null(template_color_secondary)) {
      paste(
        "--template-color-secondary",
        shQuote(template_color_secondary)
      )
    } else {
      ""
    },
    if (!is.null(template_instructions)) {
      paste(
        "--template-instructions",
        shQuote(template_instructions)
      )
    } else {
      ""
    },
    if (!is.null(template_error)) {
      paste("--template-error", shQuote(template_error))
    } else {
      ""
    },
    if (!is.null(template_placeholder)) {
      paste("--template-placeholder", shQuote(template_placeholder))
    } else {
      ""
    },
    if (!is.null(template_remember)) {
      paste("--template-remember", shQuote(template_remember))
    } else {
      ""
    },
    if (!is.null(template_title)) {
      paste("--template-title", shQuote(template_title))
    } else {
      ""
    },
    if (!is.null(template_toggle_hide)) {
      paste("--template-toggle-hide", shQuote(template_toggle_hide))
    } else {
      ""
    },
    if (!is.null(template_toggle_show)) {
      paste("--template-toggle-show", shQuote(template_toggle_show))
    } else {
      ""
    },
    if (!is.null(user_string)) {
      user_string
    } else {
      ""
    }
  )

  # Trim excess spaces
  cmd <- trimws(cmd)

  # Print the command
  if (print_cmd) {
    cat("Generated command:\n", cmd, "\n")
    return(cmd)
  }
  check_system()
  exit_status <- system(cmd)
  return(invisible(exit_status))
}
