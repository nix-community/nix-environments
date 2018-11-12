# nix-environments
Re-usable nix-shell environments to build/develop projects.

For some projects it is non-trivial to get a minimal develop environment
that work with Nix/NixOS.
The purpose of this repository is to share shell.nix expression that help
to get started with those projects.
The goal of the project is not to build or package those projects (which is often even harder)
but to document the build requirements.

What environments should include:

- dependencies to build, develop or test the project

What environments should **not** include:

- opinionated, user-specific dependencies for example editors or favorite debugging tools
