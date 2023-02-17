project('GlibD', 'd',
    meson_version : '>=0.56',

    license: 'LGPL-3.0',
    version: '2.4.1'
)

project_soversion = 0

pkg_conf = import('pkgconfig')

source_root = meson.project_source_root()
build_root = meson.project_build_root()
gen_dir = 'generated'

#
# Dependencies
#
glib_dep          = dependency('glib-2.0')
gmodule_dep       = dependency('gmodule-2.0')
gobject_dep       = dependency('gobject-2.0')
gio_dep           = dependency('gio-2.0')
# The Glib gir files are part of the gobject introspection package.
introspection_dep = dependency('gobject-introspection-1.0')

#
# Build interfaces from GIR
#
gir_to_d_prog = find_program('girtod')
gir_wrap_dir = join_paths(source_root, 'src')
gir_d_intf_dir = join_paths(build_root, gen_dir)

message('Generating D interfaces from GIR...')
girtod_gen = run_command(gir_to_d_prog,
                         '-i', gir_wrap_dir,
                         '-o', gir_d_intf_dir,
                         '--print-files', 'relative,' + source_root,
                         check: false)
if girtod_gen.returncode() != 0
    error('Unable to build D intefaces from GIR:\n' + girtod_gen.stderr())
endif

gir_bind_dir = include_directories(gen_dir)
# Enlist D GIR interface sources
gir_binding_sources = girtod_gen.stdout().strip().split('\n')

glibd = library('glibd-2.0',
    [gir_binding_sources],
    include_directories: [gir_bind_dir],
    dependencies: [glib_dep, gmodule_dep, gobject_dep, gio_dep],
    install: true,
    soversion: project_soversion,
    version: meson.project_version())

install_subdir(join_paths(build_root, gen_dir, 'glib'),    install_dir: 'include/d/glibd-2/')
install_subdir(join_paths(build_root, gen_dir, 'gio'),     install_dir: 'include/d/glibd-2/')
install_subdir(join_paths(build_root, gen_dir, 'gobject'), install_dir: 'include/d/glibd-2/')
install_subdir(join_paths(build_root, gen_dir, 'gtkd'),    install_dir: 'include/d/glibd-2/')

pkg_conf.generate(glibd,
    name: 'glibd-2.0',
    subdirs: 'd/glibd-2',
    version: meson.project_version(),
    requires: [glib_dep, gmodule_dep, gio_dep, gobject_dep],
    description: 'D bindings for the GLib C Utility Library.')

# for use by others which embed this as subproject
glibd_dep = declare_dependency(
    link_with: [glibd],
    include_directories: [gir_bind_dir]
)

subdir('tests')
