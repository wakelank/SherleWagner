class ContactWithFavorites < ApplicationMailer

  def email_favorites(favorites: [],
                      requesters_email:,
                      requesters_first_name:,
                      requesters_last_name:,
                      additional_recipients:,
                      requesters_location:,
                      requesters_comment:)
    @favorites = favorites || NullObject.new
    @requesters_email = requesters_email
    @requesters_first_name = requesters_first_name
    @requesters_last_name = requesters_last_name
    @full_name = requesters_first_name + " " + requesters_last_name
    @additional_recipients = additional_recipients_arr(additional_recipients)
    @requesters_location = requesters_location
    @requesters_comment = requesters_comment
    mail(
      to: ['wakelank@gmail.com', 'info@sherlewagner.com', 'pt@sherlewagner.com'] + @additional_recipients,
      subject: "Customer Inquiry",
      from: requesters_email
    )
  end

  def additional_recipients_arr additional_recipients_str
    additional_recipients_str.split(',')
  end
end
