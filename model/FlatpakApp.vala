public class FlatpakApp : Object {
    public string name { get; construct; }
    public string id { get; construct; }

    public FlatpakApp (string name, string id) {
        Object (name: name, id: id);
    }

    // тут я готувався писати щось 
}