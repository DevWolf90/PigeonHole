module PigeonsHelper
  def pigeon_card_variables(pigeon)
    card_class = pigeon.read ? "read" : "unread"
    media_icon =
      case pigeon.media_type
      when "video"
        content_tag(:i, "", class: "fa-brands fa-youtube pigeon-card-media")
      when "article"
        content_tag(:i, "", class: "fa-regular fa-newspaper pigeon-card-media")
      when "book"
        content_tag(:i, "", class: "fa-solid fa-book pigeon-card-media")
      when "podcast"
        content_tag(:i, "", class: "fa-solid fa-microphone pigeon-card-media")
      when "audio", "song", "playlist"
        content_tag(:i, "", class: "fa-solid fa-music pigeon-card-media")
      when "movie"
        content_tag(:i, "", "fa-solid fa-film pigeon-card-media")
      else
        ""
      end

    pigeon_avatar =
      if pigeon.user.avatar.attached?
        cl_image_tag pigeon.user.avatar.key, height: 30, width:30, crop: :fill
      else
        image_tag("https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000", height:30, width:30)
      end

    pigeon_state = {
      card_class: card_class,
      pigeon_avatar: pigeon_avatar,
      media_icon: media_icon,

    }

    pigeon_state
  end
end
