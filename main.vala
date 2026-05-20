using Gtk;

int main (string[] args) {
    // Створюємо GTK Application
    var app = new Gtk.Application ("org.albanicdevel.flider", ApplicationFlags.FLAGS_NONE);

    app.activate.connect (() => {
        // Ініціалізуємо ваш сервіс
        var service = new FlatpakService ();
        
        // Створюємо та показуємо головне вікно
        var window = new MainWindow (app, service);
        window.present ();
    });

    return app.run (args);
}