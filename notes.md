# random commands

nix build .#rddc_image --argstr user sherman --arg uid 1000

## what should be configurable

- nixpkgs url
- USER
- UID
- working dir
- command
- volumes
- copyToRoot (packages)
- name
- tag
