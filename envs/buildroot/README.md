# buildroot

Buildroot, making embedded Linux easy.

For more info checkout [buildroot over on GitLab](https://gitlab.com/buildroot.org/buildroot) or on their [website](https://buildroot.org).

## Remarks

- works on unstable, but not on 23.11. 24.05 has not been tested.
- For reasons explained in comments this adds two scripts to the shell needed for gcc backwards compatibility
- This adds ccache, which is an optional dependency but one that speeds up consecutive builds tremendously
- Some dependencies are not mentioned in the docs (yet) - they were found by trial and error
- At the time of writing buildroot under nixos suffers from incompatibility between their systemd version and nixos's kernel headers
  A patch from the mailing list has to be applied: https://lore.kernel.org/all/20240515144432.3152351-1-bruce.ashfield@gmail.com/T/
- buildFHSEnv is required as buildroot tooling has some hardcoded paths expecting a "usual" linux FS
