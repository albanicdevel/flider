using Gtk;
using Flatpak;

[GtkTemplate (ui = "/com/example/fmp/detail_window.ui")]
public class DetailWindow : Gtk.Window {
    public Flatpak.InstalledRef package;
   
    [GtkChild]
    private unowned Gtk.Label name_label;

    [GtkChild]
    private unowned Gtk.Label arch_label;

    [GtkChild]
    private unowned Gtk.Button b_delete;

    [GtkChild]
    private unowned Gtk.Button b_install;

    public DetailWindow(Flatpak.InstalledRef package) {
        this.package = package;

        this.set_default_size(600, 800);
        this.title = package.name;

        var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 12);

        name_label.label = package.name;
        arch_label.label = package.arch;
    }
}
