## GitHub-Pages

direnv (https://direnv.net/) development environment for local development of
a GitHub-Pages site. This is a more complex alternative to `nix-shell -p jekyll`
which should work fine in most cases but which is not guaranteed to exactly
match the GitHub-Pages environment.

For more information, see:

https://discourse.nixos.org/t/shell-nix-for-github-pages-development/2000

### Usage

```
direnv allow
make # or "bundle install"
```

Then run `make serve` or `jekyll serve`. Run `make update` or `bundle update` to
update to the latest version of the `github-pages` gem.

### Known issues

`bundle install` will fail when the directory path contains spaces.
