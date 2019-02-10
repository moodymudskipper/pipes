#' Create a new pipe operator.
#'
#' Create a new pipe by wrapping new code around what would have been executed
#' by the standard \code{`%>%`} pipe.
#' 
#' Printing existing pipes from the *pipes* package will provide examples to
#' build on. 
#' 
#' @param wrap an expression that will be executed after `BODY` is replaced by
#'   the code that would have been run by \code{`%>%` and `.` replaced by the
#'   input}
#' @examples 
#' \dontrun{
#' # How `%T>%` and `%$>%` were defined in this package 
#' `%T>%` <- new_pipe({local(BODY);.})
#' `%$%`  <- new_pipe(with(., BODY)) 
#' }
#' # print the number of rows before and after
#' `%nrowba>%` <- new_pipe({
#'   print(nrow(.))
#'   res <- BODY
#'   print(nrow(res))
#'   res})
#' iris %nrowba>% head
#' @export
new_pipe <- function(wrap = {BODY})
{
  # build a standard magrittr pipe
  fun <- pipe()
  
  # give it a pipe class
  class(fun) <- c("pipe","function")
  
  # give it an attribute containing wrapper code to be used in wrap_function
  attr(fun,"wrap") <- substitute(wrap)
  
  fun
}