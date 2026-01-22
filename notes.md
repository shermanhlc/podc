# nix

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

# deb

## required for use

- podman

## commands

list all: `podman ps -a`

build image: `podman build -f dockerfile --build-args-file argfile.conf --tag basic_test_image`
run interactive: `podman run -it basic_test_image`


## how should this be setup?

### files in tool dir
tool dir `/var/podc/`
- `dockerfile`
- `argfile.conf`
- `commands/`
- `commands/generate_image` 
- `commands/add_deps` 
    - this should be a main command, but then should add a deps list in the project dir. can install with `grep -vE '^#' example_project/podc/deps.list | xargs apt-get install -y`
    - this may be replaced and instead just require that deps.list be modified

project dir
- `podc/`
- `podc/build`
- `podc/clean`
- other commands
