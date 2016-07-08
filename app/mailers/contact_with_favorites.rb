class ContactWithFavorites < ApplicationMailer

  def email_favorites(favorites: [], requesters_email:, requesters_location:, requesters_comment:)
    @favorites = favorites
    @requesters_email = requesters_email
    @requesters_location = requesters_location
    @requesters_comment = requesters_comment
    mail(
      to: 'wakelank@gmail.com',
      subject: "Customer Inquiry",
      from: requesters_email
    )
  end

end
