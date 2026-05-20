using Gtk;

public class MainWindow : ApplicationWindow {
    private ListBox list_box;
    private Spinner spinner;
    private FlatpakService service;

    public MainWindow (Gtk.Application app, FlatpakService service) {
        Object (application: app, title: "Flider");
        this.service = service;
        
        set_default_size (450, 600);

        // Головний вертикальний контейнер
        var main_box = new Box (Orientation.VERTICAL, 0);

        // Індикатор завантаження
        spinner = new Spinner ();
        main_box.add (spinner);

        // Прокручувана область для списку програм
        var scrolled = new ScrolledWindow (null, null);
        list_box = new ListBox ();
        scrolled.add (list_box);
        
        // Розширюємо область списку на все вікно
        scrolled.vexpand = true;
        main_box.add (scrolled);

        this.add (main_box);

        // Підключаємо сигнали від вашого сервісу
        service.apps_loaded.connect (on_apps_loaded);
        service.apps_failed.connect (on_apps_failed);

        // Запускаємо асинхронне завантаження
        spinner.start ();
        service.async_load ();

        this.show_all ();
    }

    private void on_apps_loaded (FlatpakApp[] apps) {
        spinner.stop ();
        spinner.hide ();

        // Очищаємо список перед додаванням (якщо там щось було)
        foreach (var child in list_box.get_children ()) {
            list_box.remove (child);
        }

        // Заповнюємо список новими віджетами AppRow
        foreach (var app in apps) {
            var row = new AppRow (app);
            list_box.add (row);
        }
        
        list_box.show_all ();
    }

    private void on_apps_failed (string reason) {
        spinner.stop ();
        spinner.hide ();
        
        // Показуємо помилку користувачеві
        var dialog = new MessageDialog (this, DialogFlags.MODAL, MessageType.ERROR, ButtonsType.CLOSE, "Не вдалося завантажити Flatpak: %s", reason);
        dialog.run ();
        dialog.destroy ();
    }
}