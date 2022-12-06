install_dir <- function() path.expand("~/r-node")

sys <- list(
  Windows = list(
    url = "https://nodejs.org/dist/v18.12.1/node-v18.12.1-win-x64.zip",
    npm_path = "node-v18.12.1-win-x64\\npm.cmd",
    extract = unzip
  ),
  Darwin = list(
    url = "https://nodejs.org/dist/v18.12.1/node-v18.12.1-darwin-arm64.tar.gz",
    npm_path = "node-v18.12.1-darwin-arm64/bin/npm",
    extract = untar
  ),
  Linux = list(
    url = "https://nodejs.org/dist/v18.12.1/node-v18.12.1-linux-x64.tar.xz",
    npm_path = "node-v18.12.1-linux-x64/bin/npm",
    extract = untar
  )
)

get_sys <- function() sys[[Sys.info()[["sysname"]]]]

setup <- function() {
  sys <- get_sys()
  if (!file.exists(install_dir())) {
    archive <- tempfile()
    download.file(sys$url, archive)
    sys$extract(archive, exdir = install_dir())
  }
}

#' @export
npm <- function(...) {
  setup()
  sys <- get_sys()
  system2(command = file.path(install_dir(), sys$npm_path), args = c(...))
}
