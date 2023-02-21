{ ... }:

let

  ledger-rules = with builtins;
    fetchurl {
      url = "https://raw.githubusercontent.com/LedgerHQ/udev-rules/2776324af6df36c2af4d2e8e92a1c98c281117c9/20-hw1.rules";
      sha256 = "089jclmkd0sfqawag1gsd82gxqqpcrqrkklhml20ir2wxfz65lp6";
    };

in

{
  services.udev.extraRules = with builtins;
    foldl' (r: rs: "${rs}\n${r}") "" (map readFile [
      ledger-rules
    ]);
}
