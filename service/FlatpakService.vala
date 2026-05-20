public class FlatpakService {
    public signal void apps_loaded (FlatpakApp[] apps);
    public signal void apps_failed (string reason);

    public FlatpakService () {
    }


    private FlatpakApp[] parse (string stdout) {
        string[] lines = stdout.split("\n");
        var array = new GLib.GenericArray<FlatpakApp> ();
        foreach (string line in lines) {
            if (line == "") continue;

            if (line.length < 2) continue;
            string[] parts = line.split ("\t");
            array.add (new FlatpakApp (parts[0], parts[1]));
        }

        return array.data;
    }

    public void async_load() {
        new Thread<void> ("flatpak-loader", () => {
            try {
                string[] argv = { "flatpak", "list", "--app", "--columns=name,application"};
                var process = new GLib.Subprocess.newv (argv, GLib.SubprocessFlags.STDOUT_PIPE);
                string? stdout;
                process.communicate_utf8(null, null, out stdout, null);
                
                Idle.add(() => {
                    apps_loaded (parse (stdout ?? ""));
                    return false;
                });
            } catch(GLib.Error e) {
                string reason = e.message;
                Idle.add(() => {
                    apps_failed(reason);
                    return false;
                });
            }
        });
    }
}