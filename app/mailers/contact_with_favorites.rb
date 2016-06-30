class ContactWithFavorites < ApplicationMailer

  def email_favorites(favorites:)
    @favorites = favorites.map(&:number)
    mail(
      to:'wakelank@gmail.com',
      subject: "this is a test",
      from: "example@example.com"
    )
  end

end
