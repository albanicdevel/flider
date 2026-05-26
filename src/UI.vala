using Gtk;
using Utils;

namespace UI {
    public class App : Gtk.Application {
        public App() {
            Object(application_id: "org.albanicdevel.fmp", flags: GLib.ApplicationFlags.DEFAULT_FLAGS);
        }

        public override void activate() {
            var window = new Gtk.ApplicationWindow(this);
            window.title = "FMP";
            window.set_default_size(600, 400);


            var stack = new Gtk.Stack();
            stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;

            var scroll = new Gtk.ScrolledWindow();
            scroll.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scroll.vexpand = true;

            var listbox = new Gtk.ListBox();
            listbox.selection_mode = Gtk.SelectionMode.SINGLE;

            string[] pkgs = Utils.Flatpak.get_parsed_flatpak();
            foreach(string pkg in pkgs) {

                var label = new Gtk.Label(pkg);
                label.xalign = 0;
                label.margin_top = 8;
                label.margin_bottom = 8;
                label.margin_start = 12;
                listbox.append(label);
            }

            scroll.set_child(listbox);
            stack.add_named(scroll, "list");

            var detail = new Gtk.Box(Gtk.Orientation.VERTICAL, 12);
            detail.margin_top = 24;
            detail.margin_start = 24;

            var detail_label = new Gtk.Label("Chose the package");
            var back_button = new Gtk.Button.with_label("Back");
            detail.append(back_button);
            detail.append(detail_label);
            stack.add_named(detail, "detail");

            listbox.row_activated.connect((row) => {
                detail_label.label = pkgs[row.get_index()];
                stack.set_visible_child_name("detail");

            });

            back_button.clicked.connect(() => {
                stack.set_visible_child_name("list");
            });


            window.set_child(stack);
            window.present();
        }
    }
}