# [Ladybird browser](https://github.com/LadybirdBrowser/ladybird) development environment

> [!NOTE]
> Ladybird is in pre-alpha; its dependencies are changing constantly. If you encounter an issue with
> this environment, please report it here, and *not* to the upstream maintainers.

Ladybird's build system uses vcpkg to vendor third-party dependencies, which proves undesirable to
use with Nix for [several reasons](https://github.com/LadybirdBrowser/ladybird/issues/371).
As a result, using `ladybird.py` to compile and run Ladybird will fail. Therefore, it is necessary
to use system packages provided by this environment.

This environment exports `ICU_ROOT` and sets `FONTCONFIG_FILE` (pointing to `dejavu_fonts` and
`liberation_ttf`). Both are required: without `ICU_ROOT` cmake cannot locate ICU headers, and
without the font configuration Ladybird crashes with `SIGILL` on startup because its font
fallback lists require fonts not present in a default NixOS installation.

Clone the repository & enter the shell:

```
git clone https://github.com/LadybirdBrowser/ladybird
nix develop --no-write-lock-file github:nix-community/nix-environments#ladybird
```

Note that if the build fails due to the process lto1-wpt using too much memory, the `ENABLE_LTO_FOR_RELEASE` option should be turned off.

First invoke `cmake` directly. For example:

 - `cmake -GNinja -BBuild/release`
 - `cmake -DENABLE_LTO_FOR_RELEASE=OFF -GNinja -BBuild/release`
 - `cmake -DCMAKE_BUILD_TYPE=Debug -GNinja -BBuild/debug`
 - `cmake -DENABLE_LAGOM_CCACHE=True -GNinja -BBuild/debug`
 - With sanitizers:
```
cmake -DENABLE_ADDRESS_SANITIZER=ON -DENABLE_UNDEFINED_SANITIZER=ON -GNinja -BBuild/san
```
 - Generate test targets:
```
cmake -DBUILD_TESTING=True -GNinja -BBuild/test
```

Then, run `ninja` to start the build:

```
ninja -C Build/debug
```

Or the javascript REPL:

```
ninja -C Build/debug js
```

Or the javascript test suite (requires `-DBUILD_TESTING=True`)

```
ninja -C Build/debug test-js
```
