class ContactWithFavorites < ApplicationMailer

  def email_favorites(favorites: [],
                      requesters_email:,
                      requesters_first_name:,
                      requesters_last_name:,
                      additional_recipients:,
                      requesters_location:,
                      requesters_comment:)
    @favorites = favorites || NullObject.new
    @requesters_email = requesters_email.blank? ? "no email provided" : requesters_email
    # @requesters_first_name = requesters_first_name
    # @requesters_last_name = requesters_last_name
    @full_name = requesters_first_name + " " + requesters_last_name
    @additional_recipients = additional_recipients_arr(additional_recipients)
    @requesters_location = requesters_location.blank? ? "no location provided" : requesters_location
    @requesters_comment = requesters_comment.blank? ? "none" : requesters_comment
    mail(
      to: ['wakelank@gmail.com', 'info@sherlewagner.com', 'pt@sherlewagner.com'] + @additional_recipients,
      subject: "Sherle Wagner Customer Inquiry"
    )
  end

  def additional_recipients_arr additional_recipients_str
    max_num_of_emails = 10
    additional_recipients_str.gsub!(' ','')
    additional_recipients_arr = additional_recipients_str.split(',')
    additional_recipients_arr = additional_recipients_arr[0..max_num_of_emails]
    additional_recipients_arr.select do |address|
      valid_email? address
    end
  end

  def valid_email? address
    address == address[Devise::email_regexp]
  end
end
