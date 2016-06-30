class ContactWithFavorites < ApplicationMailer

  def email_favorites(favorites: [])
    @favorites = favorites
    mail(
      to:'wakelank@gmail.com',
      subject: "this is a test",
      from: "example@example.com"
    )
  end

end
