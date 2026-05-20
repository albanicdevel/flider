public class FlatpakService : Object {
    public signal void apps_loaded (FlatpakApp[] apps);
    public signal void apps_failed (string reason);

    public FlatpakService () : Object {
        Object ();
    }
}