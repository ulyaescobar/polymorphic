class LikeNotification < Noticed::Base
  include Rails.application.routes.url_helpers # Mengimpor url_helpers
  # Mendefinisikan penerima notifikasi, dalam hal ini adalah pengguna yang akan menerima notifikasi
  # Anda harus mengganti ":user" dengan model pengguna yang sesuai dalam aplikasi Anda
  deliver_by :database, format: :to_database, recipients: :user

  
  def to_database
    {
      message: "Anda mendapatkan suka dari pengguna #{params[:liker_name]} pada postingan #{params[:post_title]}",
      # url: url_for(controller: 'posts', action: 'show', id: params[:post_id]) # Menggunakan url_for untuk menghasilkan URL
    }
  end

end