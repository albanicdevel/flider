using Gtk;
using Flatpak;

public class ListRow : Gtk.ListBoxRow {
    public Flatpak.InstalledRef package;
    public ListRow(Flatpak.InstalledRef package) {
        this.package = package;

        var name = new Gtk.Label(package.name);
        this.set_child(name);
    }
}


public class MainBox : Gtk.Box {
    private Gtk.ListBox list_box;
    public MainBox() {
        Object(orientation: Gtk.Orientation.VERTICAL, spacing: 12);
        list_box = new Gtk.ListBox();
        var manager = new PackageManager.Manager.system(); // initalize manager

        var show_packages = new Gtk.Button.with_label("Show it for me"); // button with label

        var scroll = new Gtk.ScrolledWindow();
        scroll.vexpand = true;
        
        show_packages.clicked.connect(() => { // if clicked
            var packages = manager.get_packages(); // get null or 'GenericArray<weak Flatpak.Installation>?'
            packages.@foreach((pkg) => { // because foreach word! use @foreach.
                var row = new ListRow(pkg);

                list_box.append(row);
            });
            show_packages.sensitive = false;
        });

        list_box.row_activated.connect((row) => {
            var pkg = row as ListRow;
            var detail = new DetailWindow(pkg?.package);
            detail.present();
        });

        scroll.set_child(list_box);
        this.append(scroll);
        this.append(show_packages); // append our button
    }
}