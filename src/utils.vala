namespace Utils {
    public class Flatpak {
        public static string[] get_parsed_flatpak() {
            string stdout_buffer; // buffer for out from command line.
            string stderror_buffer; // buffer for an error.
            int flatpak_status; //  checking status output flatpak.

            try {
                GLib.Process.spawn_command_line_sync("flatpak list --app --columns=name,application,version", out stdout_buffer, out stderror_buffer, out flatpak_status); // sync execute command.
            } catch(GLib.SpawnError e) {
                print(@"oh, we have an problem..\n[ERROR]: $(e.message)\n");
                return {};
            }

            if(flatpak_status != 0) {
                print(@"Flatpak return an error: $stderror_buffer");
                return {};
            }

            return stdout_buffer.strip().split("\n");
        }
    }
}