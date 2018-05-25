# GlibD

D bindings for the GLib C Utility Library.

please view COPYING for GlibD's license.

## Building

For building you will need the GLib and Gobject Introspection development files, and the [gir-to-d](https://github.com/gtkd-developers/gir-to-d) tool.

Both [dub](https://code.dlang.org/) and [Meson](https://mesonbuild.com) build files are available.

Compiling with meson:
```
$ meson builddir && cd builddir
$ ninja
```
