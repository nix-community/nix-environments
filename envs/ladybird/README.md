# [Ladybird browser](https://github.com/LadybirdBrowser/ladybird) development environment

> [!NOTE]
> Ladybird is in pre-alpha; its dependencies are changing constantly. If you encounter an issue with
> this environment, please report it here, and *not* to the upstream maintainers.

Ladybird's build system uses vcpkg to vendor third-party dependencies, which proves undesirable to
use with Nix for [several reasons](https://github.com/LadybirdBrowser/ladybird/issues/371).
As a result, using `ladybird.sh` to compile and run Ladybird will fail. Therefore, it is necessary
to use system packages provided by this environment.

Clone the repository & enter the shell:

```
git clone https://github.com/LadybirdBrowser/ladybird
nix develop --no-write-lock-file github:nix-community/nix-environments#ladybird
```

First invoke `cmake` directly. For example:

 - `cmake -GNinja -BBuild/release`
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
