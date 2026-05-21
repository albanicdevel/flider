using Gtk;

public class AppListView : Gtk.Stack {
    private Gtk.ListBox list_box;
    private Gtk.Label error_label;

    construct {
        var spinner = new Gtk.Spinner();
        this.error_label = new Gtk.Label("");
        this.list_box = new Gtk.ListBox();
        spinner.start();
        add_named(spinner, "loading");
        add_named(error_label, "error");
        add_named(this.list_box, "list");
    }

    public void populate(FlatpakApp[] apps) {
        foreach(FlatpakApp app in apps) {
            this.list_box.add(new AppRow(app));
        }

        show_all();
        visible_child_name = "list";
    }

    public void set_error(string reason) {
        this.error_label.label = reason;
        visible_child_name = "error";
    }
}