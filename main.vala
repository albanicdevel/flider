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

		refresh_btn.clicked.connect(() => {
			print("Магия обновления через CLI!\n");
			foreach(string line in lines) {
			print(line + "\n");
		}
		});

		vbox.pack_start(refresh_btn, false, false, 0);

		window.add(vbox); 
		window.show_all();
	}

	public static int main(string[] args) {
		var app = new Flider();
		return app.run(args);
	}
}
