{ pkgs }:

pkgs.rWrapper.override {
  packages = with pkgs.rPackages; [
    jsonlite
    optparse
    readxl
    tidyverse
    xml2
    gridExtra
    scales
  ];
}
