#' piamPackages
#'
#' Fetches the names of packages available on https://pik-piam.r-universe.dev/ui#builds
#'
#' @param version return version information (if TRUE) - default is FALSE
#' @return A character vector of names of packages available on https://pik-piam.r-universe.dev/ui#builds
#'
#' @export
piamPackages <- function(version = FALSE) {
  packagesUrl <- "https://pik-piam.r-universe.dev/src/contrib/PACKAGES"
  fallback <- c("blackmagicc", "citation", "demystas", "edgeTransport", "edgeTrpLib",
                "GDPuc", "gdx", "gdxrrw", "gms", "goxygen", "HARr", "iamc", "limes",
                "lpjclass", "lpjmlkit", "lucode2", "luplot", "luscale", "lusweave",
                "m4fsdp", "madrat", "magclass", "magpie4", "MagpieNCGains", "magpiesets",
                "mip", "modelstats", "mrcommons", "mrdieter", "mrdrivers", "mredgebuildings",
                "mrfable", "mrfeed", "mrfish", "mrland", "mrmagpie", "mrremind",
                "mrsoil", "mrtutorial", "mrvalidation", "mrvalidnitrogen", "mrwaste",
                "mrwater", "mrwaterplots", "mstools", "piamenv", "piamInterfaces",
                "piamModelTests", "piktests", "quitte", "r2databus", "regressionworlddata",
                "remind2", "remulator", "rmndt", "rOpenscmRunner", "shinyresults",
                "SPARQL", "trafficlight")
  # create output object
  out <- tryCatch({
    sort(sub("^Package: ", "", grep("^Package: ", readLines(packagesUrl), value = TRUE)))
  }, warning = function(w) fallback, error = function(e) fallback)

  if(version) {
    out <- cbind(package = out, 'pik-piam-version' = tryCatch({
      sort(sub("^Version: ", "", grep("^Version: ", readLines(packagesUrl), value = TRUE)))
    }, warning = function(w) fallback, error = function(e) fallback))
  }
  
  return(out)
}
