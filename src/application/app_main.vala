using Gtk;
using Windows;

public class App : Gtk.Application {
    public App() {
        Object(application_id: "com.example.fmp");
    }

    public override void activate() {
        var win_main = new Windows.Window(this);
        win_main.present();
    }
}