module AirbnbApi
  module Resource
    class Listing
      include AirbnbApi::Resource
      extend AirbnbApi::Resource::ClassMethods

      attributes %i[
        id
        name
        property_type_category
        room_type_category
        bedrooms
        bathrooms
        beds
        bed_type_category
        amenity_categories
        requested_approval_status_category
        has_availability
        permit_or_tax_id
        apt
        street
        city
        state
        zipcode
        country_code
        lat
        lng
        user_defined_location
        directions
        check_in_time
        check_in_time_ends_at
        check_out_time
        min_nights_input_value
        max_nights_input_value
        person_capacity
        cancellation_policy_category
        listing_currency
        listing_price
        listing_weekend_price
        listing_weekly_price
        listing_monthly_price
        listing_security_deposit
        listing_cleaning_fee
        guests_included
        listing_extra_person_price
        instant_book_welcome_message
        synchronization_category
      ]
    end
  end
end
