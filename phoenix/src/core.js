// Core Configuration
class Core {
  static reload() {
    Phoenix.reload();
  }
  static bindKey(key, modifiers, callback) {
    return new Phoenix.Key(key, modifiers, callback);
  }
}
// Utility Methods and Classes
class Utils {
  static showNotification(text, duration = 3) {
    Phoenix.notify(text);
  }
  static showModal(text, duration = 2) {
    const modal = new Phoenix.Modal();
    modal.text = text;
    modal.duration = duration;
    modal.show();
  }
}
// Initial setup
Core.bindKey("r", ["cmd", "ctrl"], () => {
  Core.reload();
  Utils.showNotification("Configuration reloaded");
});
// Export the Core and Utils classes
export { Core, Utils };
