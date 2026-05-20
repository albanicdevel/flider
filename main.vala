using Gtk;

public class Main {
	public static int main (string[] argv) {
		var service = new FlatpakService ();
		service.apps_loaded.connect((apps) => {
			foreach (FlatpakApp app in apps) {
				print (app.name + "\t" + app.id + "\n");	
			}
		});

		service.async_load ();
		var loop = new GLib.MainLoop ();
		loop.run ();
		return 0;
	}
}