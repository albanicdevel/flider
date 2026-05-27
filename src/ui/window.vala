using Flatpak;

namespace Windows {
    public class Window : Gtk.ApplicationWindow {
        public Window(App app) {
            Object(
                application: app, 
                title: "FMP"
            );

            this.set_default_size(600, 800);

            var main_box = new MainBox();

            this.set_child(main_box);
        }
    } 
}
