{ pkgs }:

pkgs.python39Full.withPackages
(python-packages: with python-packages; [ doit python-dotenv flake8 ])

