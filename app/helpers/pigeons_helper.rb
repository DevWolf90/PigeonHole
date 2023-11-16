module PigeonsHelper
  def pigeon_card_variables(pigeon)
    card_class =
    if pigeon.read && pigeon.recipient != current_user
      "read sent"
    elsif pigeon.read && pigeon.recipient == current_user
      "read received"
    elsif !pigeon.read && pigeon.recipient != current_user
      "unread sent"
    elsif !pigeon.read && pigeon.recipient == current_user
      "unread received"
    end

    both = ""
    if pigeon.favourite? && pigeon.reply_later
      both.concat(content_tag(:i, "", class: "fa-solid fa-heart heart secondary-icon"))
      both.concat(content_tag(:i, "", class: "fa-solid fa-clock reply-icon offset-icon"))
    end

    favourite =
    if pigeon.favourite?
      content_tag(:i, "", class: "fa-solid fa-heart heart offset-icon")
    end

    reply_later =
    if pigeon.reply_later?
      content_tag(:i, "", class: "fa-solid fa-clock reply-icon offset-icon")
    end


    # particular =
    # if pigeon.favourite? && pigeon.reply_later
    #   content_tag(:i, "", class: "fa-solid fa-star heart offset-icon")
    # elsif pigeon.favourite?
    #   content_tag(:i, "", class: "fa-solid fa-heart heart offset-icon")
    # elsif pigeon.reply_later?
    #   content_tag(:i, "", class: "fa-solid fa-clock reply-icon offset-icon")
    # end

    reply_later_status = pigeon.reply_later ? "reply_later" : "dont-reply-later"
    media_icon =
      case pigeon.media_type
      when "video"
        content_tag(:i, "", class: "fa-brands fa-youtube fa-stack-1x media-type")
      when "article"
        content_tag(:i, "", class: "fa-regular fa-newspaper fa-stack-1x media-type")
      when "book"
        content_tag(:i, "", class: "fa-solid fa-book fa-stack-1x media-type")
      when "podcast"
        content_tag(:i, "", class: "fa-solid fa-microphone fa-stack-1x media-type")
      when "audio", "song", "playlist"
        content_tag(:i, "", class: "fa-solid fa-music fa-stack-1x media-type")
      when "movie"
        content_tag(:i, "", "fa-solid fa-film fa-stack-1x media-type")
      else
        {}
      end

    pigeon_avatar =
      if pigeon.user.avatar.attached?
        cl_image_tag pigeon.user.avatar.key, height: 30, width:30, class: 'avatar-image'
      else
        image_tag("https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000", height:30, width:30, class: 'avatar-image')
      end

    pigeon_state = {
      card_class: card_class,
      pigeon_avatar: pigeon_avatar,
      media_icon: media_icon,
      favourite: favourite,
      reply_later: reply_later,
      both: both
    }

    pigeon_state
  end
end
