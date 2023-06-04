import consumer from "./consumer"

consumer.subscriptions.create("LikeNotificationChannel", {
  connected() {
    console.log("Connected to LikeNotificationChannel");
  },

  disconnected() {
    console.log("Disconnected from LikeNotificationChannel");
  },

  received(data) {
    console.log(data); // Tambahkan logika penanganan notifikasi sesuai kebutuhan Anda
  }
});