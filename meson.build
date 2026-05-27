project('fmp', 'vala', 'c')

gnome = import('gnome')

deps = [
  dependency('gtk4'), 
  dependency('flatpak'),
]

add_project_arguments('-include', 'gtk/gtk.h', language: 'c')

resources = gnome.compile_resources(
  'fmp-resources',
  'src/fmp.gresource.xml',
  source_dir: meson.current_source_dir() / 'src' / 'ui',
)

executable(
  'fmp', 
  'src/main.vala',
  'src/flatpak/flatpak.vala',
  'src/ui/main_box.vala',
  'src/ui/window.vala',
  'src/application/app_main.vala',
  'src/ui/detail_window.vala',
  resources,
  dependencies: deps,
  vala_args: [
    '--vapidir', meson.source_root(), 
    '--gresourcesdir', meson.current_source_dir() / 'src' / 'ui'
  ]
)