using Gtk;

public class Flider : Gtk.Application {
	public Flider() {
		Object (application_id: "net.albanix.flider");
	}

	protected override void activate() {
		var window = new Gtk.ApplicationWindow(this) {
			title = "Доза",
			default_width = 400,
			default_height = 600
		};

		var vbox = new Box(Orientation.VERTICAL, 6);

		var refresh_btn = new Button.with_label("Обновить");
		string[] argv = {"flatpak", "list", "--app"};
		var process = new Subprocess.newv(argv, SubprocessFlags.STDOUT_PIPE);
		string stdout_text;
		process.communicate_utf8(null, null, out stdout_text, null);

		string[] lines = stdout_text.split("\n");

		var list_box = new Gtk.ListBox();
		refresh_btn.clicked.connect(() => {
			list_box.foreach((child) => {
				list_box.remove(child);
			});
			
			print("Магия обновления через CLI!\n");
			var app_list = new GLib.GenericArray<Flatpak>();
			foreach(string line in lines) {
				if(line == "") continue;

				string[] parts = line.split("\t");
				if(parts.length >= 2) {
					var flatpak = new Flatpak(parts[0], parts[1]);
					app_list.add(flatpak);

					var row_box = new Box(Orientation.HORIZONTAL, 12);

					var name_label = new Label(flatpak.name);
					var id_label = new Label(flatpak.id);

					row_box.pack_start(name_label, false, false, 0);
					row_box.pack_start(id_label, false, false, 0);

					list_box.add(row_box);
				}
			}

			list_box.show_all();
		});

		vbox.pack_start(refresh_btn, false, false, 0);
		vbox.pack_start(list_box, false, false, 0);
		window.add(vbox);
		window.show_all();
	}

	public static int main(string[] args) {
		var app = new Flider();
		return app.run(args);
	}
}
