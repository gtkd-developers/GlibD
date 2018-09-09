
value_test = executable(
	'value_test',
	'ValueTest.d',
	include_directories: [gir_bind_dir],
	dependencies: [glib_dep, gobject_dep, gio_dep],
	link_with: [glibd]
)
test('gobject_value_test', value_test)
