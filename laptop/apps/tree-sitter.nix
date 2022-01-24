{ pkgs }:

with pkgs; [
  tree-sitter
  (tree-sitter.withPlugins (p:
    map (grammar: p."tree-sitter-${grammar}") [
      "bash"
      "c"
      "haskell"
      "javascript"
      "json"
      "latex"
      "make"
      "markdown"
      "nix"
      "rust"
      "svelte"
      "toml"
      "typescript"
      "yaml"
    ]))
]
