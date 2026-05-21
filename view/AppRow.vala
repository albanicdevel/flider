using Gtk;

public class AppRow : ListBoxRow {
    public FlatpakApp app { get; construct; }

    public AppRow (FlatpakApp app) {
        Object (app: app);
    }

    construct {
        var box = new Gtk.Box(Orientation.HORIZONTAL);
        var name_label = new Gtk.Label(this.app.name);
        var id_label = new Gtk.Label(this.app.id);
        box.add(name_label);
        box.add(id_label);

        add(box);
        box.show_all();
    }
}