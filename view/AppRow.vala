using Gtk;

public class AppRow : ListBoxRow {
    public FlatpakApp app { get; construct; }

    public AppRow (FlatpakApp app) {
        Object (app: app);
    }

    construct {
        // Створюємо горизонтальний контейнер із відступами
        var box = new Box (Orientation.HORIZONTAL, 12);
        box.margin = 8;

        // Назва додатка (притиснута ліворуч, розширюється)
        var name_label = new Label (app.name);
        name_label.halign = Align.START;
        name_label.hexpand = true;

        // ID додатка (притиснутий праворуч, зробимо його тьмянішим)
        var id_label = new Label (app.id);
        id_label.halign = Align.END;
        id_label.get_style_context ().add_class ("dim-label"); 

        // Додаємо віджети в контейнер рядка
        box.add (name_label);
        box.add (id_label);

        this.add (box);
        this.show_all ();
    }
}