class ContactWithFavorites < ApplicationMailer

  def email_favorites(favorites: [], requesters_email:, requesters_location:)
    @favorites = favorites
    @requesters_email = requesters_email
    @requesters_location = requesters_location
    mail(
      to:'wakelank@gmail.com',
      subject: "this is a test",
      from: "example@example.com"
    )
  end

end
