using Flatpak;

namespace PackageManager {
        public class Manager {
        private Flatpak.Installation installation;

        public Manager.system() {
            try {
                installation = new Flatpak.Installation.system();
            } catch(GLib.Error e) {
                print(@"error: $(e.message)\ncode: $(e.code)");
                installation = null;
            }
        }

        public Manager.user() {
            installation = new Flatpak.Installation.user();
        }

        public GenericArray<weak Flatpak.InstalledRef>? get_packages() {
            return installation?.list_installed_refs(); // if installation is null - return null.    
        }
    }

    //  public Ref {
    //      public string name;
    //      public string arch;
    //      public string commit;

    //      public Ref() {
    //          this.name = Flatpak.Ref.name;
    //          this.arch = Flatpak.Ref.arch;
    //          this.commit = Flatpak.Ref.commit;
    //      }
    //  }
}