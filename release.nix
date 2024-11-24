let inherit (import ./.) provide;
in {
  inherit (provide) checks;
  inherit (provide.components) library;
  shell = import ./shell.nix;
}
