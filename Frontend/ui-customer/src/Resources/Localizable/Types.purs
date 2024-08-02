{-

  Copyright 2022-23, Juspay India Pvt Ltd

  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License

  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program

  is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY

  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details. You should have received a copy of

  the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
-}
module Language.Types where

data STR
  = ABOUT
 | SAFETY
 | SAFETY_CHECK_IN
 | ABOUT_APP_DESCRIPTION
 | ABOUT_REFERRAL_PROGRAM
 | ABOUT_REFERRAL_PROGRAM_DISCRIPTION String
 | ACCOUNT_DELETION_CONFIRMATION
 | ADD_ANOTHER_CONTACT
 | ADD_EMERGENCY_CONTACTS
 | ADD_FAVOURITE
 | ADD_NEW_ADDRESS
 | ADD_NEW_FAVOURITE
 | ADD_NOW
 | ADD_SAVED_LOCATION_FROM_SETTINGS
 | ADD_TAG
 | ADDRESS
 | ADDRESSES
 | ALL_FAVOURITES
 | ALL_TOPICS
 | ALREADY_EXISTS
 | ALSO_SHARE_YOUR_RIDE_STATUS_AND_LOCATION
 | AMOUNT_PAID
 | ANONYMOUS_CALL
 | ARE_YOU_STARING
 | ARE_YOU_SURE_YOU_WANT_TO_CANCEL
 | ARE_YOU_SURE_YOU_WANT_TO_LOGOUT
 | ARE_YOU_SURE_YOU_WANT_TO_REMOVE_CONTACT
 | ARE_YOU_SURE_YOU_WANT_TO_REMOVE_FAVOURITE_
 | ASK_FOR_PRICE
 | ASK_FOR_PRICE_INFO
 | ASKED_FOR_MORE_MONEY
 | AT_DROP
 | AT_PICKUP
 | AUTO_ACCEPTING_SELECTED_RIDE
 | AUTO_ASSIGN_A_RIDE
 | AUTO_ASSIGN_DRIVER
 | AWAY
 | AWAY_C
 | BASE_FARES
 | BOARD_THE_FIRST
 | BOOK_NOW
 | BOOK_RIDE_
 | BOOKING_PREFERENCE
 | BOOST_YOUR_RIDE_CHANCES_AND_HELP_DRIVERS_WITH_TIPS
 | BY_CASH
 | BY_TAPPING_CONTINUE
 | CALL
 | CALL_DRIVER
 | CALL_DRIVER_USING
 | CALL_EMERGENCY_CONTACTS
 | CALL_EMERGENCY_CENTRE
 | CANCEL_
 | CANCEL_AUTO_ASSIGNING
 | CANCEL_ONGOING_SEARCH
 | CANCEL_RIDE
 | REQUEST_EDIT
 | CANCEL_SEARCH
 | CANCEL_STR
 | CANCELLED
 | CHANGE
 | CHANGE_DROP_LOCATION
 | CHANGE_LOCATION
 | CHECK_OUT_LIVE_STATS
 | CHECK_YOUR_INTERNET_CONNECTION_AND_TRY_AGAIN
 | CHOOSE_A_RIDE_AS_PER_YOUR_COMFORT
 | CHOOSE_BETWEEN_MULTIPLE_DRIVERS
 | CHOOSE_BETWEEN_MULTIPLE_RIDES
 | CHOOSE_ON_MAP
 | CHOOSE_YOUR_RIDE
 | COMFY
 | CONFIRM_AND_BOOK
 | CONFIRM_AND_SAVE
 | CONFIRM_CHANGES
 | CONFIRM_DROP_LOCATION
 | CHECK_REVISED_FARE_AND_ROUTE
 | CONFIRM_EMERGENCY_CONTACTS
 | CONFIRM_FOR
 | CONFIRM_LOCATION
 | CONFIRM_PICKUP_LOCATION
 | CONFIRM_RIDE_
 | CONFIRMING_THE_RIDE_FOR_YOU
 | CONTACT_SUPPORT
 | CONTACTS_SELECTED
 | CONTINUE
 | COPIED
 | COULD_NOT_CONNECT_TO_DRIVER
 | CURRENT_LOCATION
 | FARE_UPDATED
 | PLEASE_CONFIRM_WITH_YOUR_AFTER_REQUESTING
 | PREVIOUSLY
 | ROUTE_AND_FARE_UPDATED
 | PREVIOUS_FARE
 | YOUR_DRIVER_MIGHT_WANT_TO_GO_TOWARDS_THE_CURRENT_DROP_KINDLY_ASK_THEM_TO_CONFIRM_AFTER_REQUESTING
 | CURRENTLY_WE_ARE_LIVE_IN_ String
 | CUSTOMER_SELECTED_FARE
 | CUSTOMER_TIP_DESCRIPTION
 | DIAL_112
 | DETAILS
 | DATA_COLLECTION_AUTHORITY
 | DAY_TIME_CHARGES String String
 | DAYTIME_CHARGES_APPLICABLE_AT_NIGHT String String
 | DAYTIME_CHARGES_APPLIED_AT_NIGHT String String String
 | DEL_ACCOUNT
 | DELETE
 | DENY_ACCESS
 | DESCRIBE_YOUR_ISSUE
 | DESTINATION_OUTSIDE_LIMITS
 | DIRECT_CALL
 | DO_YOU_NEED_EMERGENCY_HELP
 | DOWNLOAD_PDF
 | DRAG_THE_MAP
 | DRIVER_PICKUP_CHARGES String
 | DRIVER_REQUESTED_TO_CANCEL
 | DRIVER_WAS_NOT_REACHABLE
 | DRIVER_WAS_RUDE
 | DRIVERS_CAN_CHARGE_AN_ADDITIONAL_FARE_UPTO
 | DRIVERS_CAN_CHARGE_BETWEEN_THE_ABOVE_RANGE
 | DRIVERS_MAY_QUOTE_EXTRA_TO_COVER_FOR_TRAFFIC
 | DRIVER_ADDITION_LIMITS_ARE_IN_INCREMENTS
 | DROP
 | DROP_LOCATION_FAR_AWAY
 | EARLY_END_RIDE_CHARGES
 | EARLY_END_RIDE_CHARGES_DESCRIPTION
 | ECONOMICAL
 | EDIT
 | EDIT_FAVOURITE
 | EMAIL
 | EMAIL_ALREADY_EXISTS
 | EMAIL_ID
 | EMERGENCY_CONTACS_ADDED_SUCCESSFULLY
 | EMERGENCY_CONTACTS
 | EDIT_EMERGENCY_CONTACTS
 | EMERGENCY_HELP
 | EMPTY_RIDES
 | ENABLE_THIS_FEATURE_TO_CHOOSE_YOUR_RIDE
 | ENJOY_RIDING_WITH_US
 | ENTER_4_DIGIT_OTP
 | ENTER_A_LOCATION
 | ENTER_MOBILE_NUMBER
 | ENTER_OTP
 | ENTER_YOUR_MOBILE_NUMBER
 | ENTER_YOUR_NAME
 | ERROR_404
 | ERROR_OCCURED_TRY_AGAIN
 | ESTIMATES_CHANGED
 | ESTIMATES_REVISED_TO
 | ETA_WAS_TOO_LONG
 | ETA_WAS_TOO_SHORT
 | EXISTS_AS
 | EXPIRES_IN
 | FAQ
 | FARE_HAS_BEEN_UPDATED
 | FARE_WAS_HIGH
 | FAVOURITE
 | FAVOURITE_ADDED_SUCCESSFULLY
 | FAVOURITE_LOCATION
 | FAVOURITE_REMOVED_SUCCESSFULLY
 | FAVOURITE_UPDATED_SUCCESSFULLY
 | FAVOURITE_YOUR_CURRENT_LOCATION
 | FAVOURITES
 | FEMALE
 | FINDING_RIDES_NEAR_YOU
 | FOR_OTHER_ISSUES_WRITE_TO_US
 | FULL_NAME
 | GENDER_STR
 | GET_ESTIMATE_FARE
 | GETTING_DELAYED_PLEASE_WAIT
 | GETTING_ESTIMATES_FOR_YOU
 | GETTING_REVISED_ESTIMATE
 | GETTING_STARTED_AND_FAQS
 | GIVE_THIS_LOCATION_A_NAME
 | GO_BACK_
 | GO_HOME_
 | GO_TO_HOME__
 | GOOGLE_MAP_
 | GOT_ANOTHER_RIDE_ELSE_WHERE
 | GOT_IT
 | GOT_IT_TELL_US_MORE
 | GOVERNMENT_CHAGRES
 | GRANT_ACCESS
 | CGST
 | HAVE_REFERRAL_CODE
 | HATCHBACK
 | HELP_AND_SUPPORT
 | HELP_US_WITH_YOUR_FEEDBACK_OPTIONAL
 | HELP_US_WITH_YOUR_REASON
 | HEY
 | HOME
 | HOPE_YOUR_RIDE_WAS_HASSLE_FREE
 | HOW_DO_YOU_IDENTIFY_YOURSELF
 | HOW_SHOULD_WE_ADDRESS_YOU
 | HOW_THE_PRICING_WORKS
 | HOW_THIS_WORKS
 | HOW_WAS_YOUR_RIDE_EXPERIENCE
 | HOW_WAS_YOUR_RIDE_WITH
 | ACTUAL_FARE_WAS_HIGHER_THAN_WHAT_WAS_SHOWN
 | I_AM_ON_MY_WAY
 | I_HAVE_ARRIVED
 | IF_YOU_STILL_WANNA_BOOK_RIDE_CLICK_CONTINUE_AND_START_BOOKING_THE_RIDE
 | IN
 | IN_APP_TRACKING
 | INVALID_CODE_PLEASE_RE_ENTER
 | INVALID_MOBILE_NUMBER
 | INVOICE
 | IS_ON_THE_WAY
 | IS_WAITING_AT_PICKUP
 | IT_SEEMS_TO_BE_A_VERY_BUSY_DAY
 | LANGUAGE
 | LET_TRY_THAT_AGAIN
 | LIVE_STATS_DASHBOARD
 | LOAD_MORE
 | LOADING
 | LOCATION
 | LOCATION_ALREADY
 | LOCATION_ALREADY_EXISTS
 | LOCATION_ALREADY_EXISTS_AS
 | LOCATION_UNSERVICEABLE
 | LOGIN_USING_THE_OTP_SENT_TO
 | LOGO
 | LOGOUT_
 | LOOKING_FOR_YOU_AT_PICKUP
 | LOST_SOMETHING
 | MALE
 | MANDATORY
 | MAX_CHAR_LIMIT_REACHED
 | MAYBE_LATER
 | MESSAGE
 | METERS_AWAY_FROM_YOUR_DESTINATION
 | MIN_FARE_UPTO String
 | MORE_THAN
 | MINS_AWAY
 | MOBILE
 | MOBILE_NUMBER_STR
 | MY_RIDES
 | NAME
 | NAME_ALREADY_IN_USE
 | NAVIGATE
 | NEARBY
 | NIGHT_TIME_CHARGES String String
 | NO
 | NO_CONTACTS_LEFT_ON_DEVICE_TO_ADD
 | NO_DONT
 | NO_EMERGENCY_CONTACTS_SET
 | NO_FAVOURITES_SAVED_YET
 | NO_MORE_RIDES
 | NO_TIP
 | NOMINAL_FARE
 | CUSTOMER_CANCELLATION_DUES
 | NOT_NOW
 | NOTE
 | NOTIFY_ME
 | OF
 | OK_I_WILL_WAIT
 | ONLINE_
 | OTHER
 | OTHERS
 | OTP
 | OUR_SUGGESTED_PRICE_FOR_THIS_TRIP_IS
 | PAID
 | PAY_DIRECTLY_TO_YOUR_DRIVER_USING_CASH_UPI
 | PAY_DRIVER_USING_CASH_OR_UPI
 | PAY_DRIVER_USING_CASH_OR_UPI_
 | PAY_THE_DRIVER
 | PAY_THE_DRIVER_INFO
 | PAY_THE_DRIVER_NOTE
 | PAY_VIA_CASH_OR_UPI
 | PAYMENT_METHOD
 | PAYMENT_METHOD_STRING
 | PAYMENT_METHOD_STRING_
 | PEOPLE
 | PERCENTAGE_OF_NOMINAL_FARE
 | PERSONAL_DETAILS
 | PICK_UP_LOCATION
 | PICK_UP_LOCATION_INCORRECT
 | PICKUP_AND_DROP
 | PICKUP_CHARGE
 | PLACE_CALL
 | PLEASE_CHOOSE_YOUR_PREFERRED_LANGUAGE_TO_CONTINUE
 | PLEASE_COME_FAST_I_AM_WAITING
 | PLEASE_COME_SOON
 | PLEASE_PAY_THE_FINAL_AMOUNT_TO_THE_DRIVER_VIA_CASH
 | PLEASE_TELL_US_WHY_YOU_WANT_TO_CANCEL
 | PLEASE_UPDATE_APP_TO_CONTINUE_SERVICE
 | PLEASE_WAIT_I_WILL_BE_THERE
 | PLEASE_WAIT_WHILE_IN_PROGRESS
 | PREFER_NOT_TO_SAY
 | PRIVACY_POLICY
 | PROBLEM_AT_OUR_END
 | PROFILE_COMPLETION
 | PROMOTION
 | QUOTE_EXPIRED
 | RATE_ABOVE_MIN_FARE
 | RATE_CARD
 | RATE_YOUR_DRIVER
 | RATE_YOUR_RIDE
 | RATE_YOUR_RIDE_WITH
 | REFEREAL_CODE_DISCRIPTION
 | REFERRAL_CODE_APPLIED
 | REFERRAL_CODE_SUCCESSFULL
 | REGISTER_USING_DIFFERENT_NUMBER
 | REMOVE
 | REMOVE_FAVOURITE
 | REPEAT_RIDE
 | REPORT_AN_ISSUE
 | REPORT_AN_ISSUE_WITH_THIS_TRIP
 | REQUEST_AUTO_RIDE String
 | REQUEST_CALLBACK
 | REQUEST_RIDE
 | REQUEST_SUBMITTED
 | REQUEST_TO_DELETE_ACCOUNT
 | RESEND
 | RIDE_COMPLETED
 | RIDE_DETAILS
 | RIDE_FARE
 | RIDE_ID
 | RIDE_NOT_SERVICEABLE
 | APP_NOT_SERVICEABLE
 | SAVE
 | SAVE_AS
 | SAVE_PLACE
 | SAVED_ADDRESS_HELPS_YOU_KEEP_YOUR_FAVOURITE_PLACES_HANDY
 | SAVED_ADDRESSES
 | SEARCH_AGAIN_WITH
 | SEARCH_AGAIN_WITH_A_TIP
 | SEARCH_AGAIN_WITHOUT_A_TIP
 | SEARCH_CONTACTS
 | SELECT_A_RIDE
 | SELECT_AN_OFFER
 | SELECT_AN_OFFER_FROM_OUR_DRIVERS
 | SELECT_AN_OFFER_FROM_OUR_DRIVERS_INFO
 | SELECT_CONTACTS
 | SELECT_FAVOURITE
 | SELECT_ON_MAP
 | SELECT_YOUR_DROP
 | SELECT_YOUR_GENDER
 | SEND_EMAIL
 | SERVICE_CHARGES
 | SET_LOCATION_ON_MAP
 | SET_NOW
 | SET_UP_YOUR_ACCOUNT
 | SHARE_APP
 | SHARE_RIDE_WITH_EMERGENCY_CONTACTS
 | SHOW_ALL_OPTIONS
 | SIX_DIGIT_REFERRAL_CODE
 | SKIP
 | SOFTWARE_LICENSE
 | SORRY_WE_COULDNT_FIND_ANY_RIDES
 | SORT_BY
 | SPACIOUS
 | START_
 | START_YOUR_CHAT_USING_THESE_QUICK_CHAT_SUGGESTIONS
 | START_YOUR_CHAT_WITH_THE_DRIVER
 | STEPS_TO_COMPLETE
 | SUBJECT
 | SUBMIT
 | SUBMIT_FEEDBACK
 | SUCCESSFUL_ONBOARD String
 | SUPPORT
 | SUV
 | SEDAN
 | T_AND_C_A
 | TERMS_AND_CONDITIONS
 | THANK_YOU_FOR_WRITING
 | THANK_YOU_FOR_WRITING_TO_US
 | THANK_YOUR_DRIVER
 | THE_TRIP_IS_VERY_SHORT_AND_JUST_TAKE
 | TIP
 | TO_THE
 | TOTAL_AMOUNT
 | TOTAL_FARE_MAY_CHANGE_DUE_TO_CHANGE_IN_ROUTE
 | TOTAL_PAID
 | TRACK_LIVE_LOCATION_USING
 | TRIP_CHARGES
 | TRIP_DETAILS_
 | TRIP_ID
 | TRY_AGAIN
 | TRY_AGAIN_WITH
 | TRY_AGAIN_WITH_A_TIP
 | TRY_AGAIN_WITHOUT_TIP
 | TRY_CONNECTING_WITH_THE_DRIVER
 | TRY_LOOKING_FOR_RIDES_AGAIN
 | UNREACHABLE_PLEASE_CALL_BACK
 | UPDATE
 | UPDATE_PERSONAL_DETAILS
 | SETUP_NOW
 | UPDATE_REQUIRED
 | USE_CURRENT_LOCATION
 | USER
 | VERIFYING_OTP
 | VIEW_ALL_RIDES
 | VIEW_BREAKDOWN
 | VIEW_DETAILS
 | VIEW_INVOICE
 | VISIT_MY_RIDES_SECTION_FOR_RIDE_SPECIFIC_COMPLAINTS
 | WAIT_TIME
 | WAIT_TIME_TOO_LONG
 | WAITING_CHARGE
 | WAITING_CHARGE_DESCRIPTION
 | WAITING_CHARGE_RATECARD_DESCRIPTION String String
 | WAITING_CHARGE_INFO String String
 | WE_HAVE_RECEIVED_YOUR_ISSUE
 | WE_HAVE_RECEIVED_YOUR_ISSUE_WELL_REACH_OUT_TO_YOU_IN_SOMETIME
 | WE_NEED_ACCESS_TO_YOUR_LOCATION
 | WE_WILL_DELETE_YOUR_ACCOUNT
 | WELCOME_TEXT
 | WHERE_TO
 | WORK
 | WRITE_A_COMMENT
 | WRITE_TO_US
 | WRONG_OTP
 | YES
 | YES_CANCEL_SEARCH
 | YES_DELETE_IT
 | YES_REMOVE
 | YES_TRY_AGAIN
 | YOU_ARE_ABOUT_TO_CALL_NAMMA_YATRI_SUPPORT String
 | YOU_ARE_ABOUT_TO_CALL_NEAREST_EMERGENCY_CENTRE
 | YOU_ARE_OFFLINE
 | YOU_CAN_CANCEL_RIDE
 | YOU_CAN_DESCRIBE_THE_ISSUE_YOU_FACED_HERE
 | YOU_CAN_GET_REFERRAL_CODE_FROM_DRIVER String
 | YOU_CAN_TAKE_A_WALK_OR_CONTINUE_WITH_RIDE_BOOKING
 | YOU_HAVE_RIDE_OFFERS_ARE_YOU_SURE_YOU_WANT_TO_CANCEL
 | YOU_HAVENT_TAKEN_A_TRIP_YET
 | YOU_RATED
 | YOU_WILL_BE_ASKED_TO_SELECT_CONTACTS
 | YOUR_EMAIL_ID
 | LOCATION_PERMISSION_SUBTITLE
 | YOUR_NUMBER_WILL_BE_VISIBLE_TO_THE_DRIVER_USE_IF_NOT_CALLING_FROM_REGISTERED_NUMBER
 | YOUR_NUMBER_WILL_NOT_BE_SHOWN_TO_THE_DRIVER_THE_CALL_WILL_BE_RECORDED_FOR_COMPLIANCE
 | YOUR_RECENT_RIDE
 | YOUR_RIDE_HAS_STARTED
 | YOUR_RIDE_IS_NOW_COMPLETE
 | YOUR_RIDES
 | YOUR_TRIP_IS_TOO_SHORT_YOU_ARE_JUST
 | DOWNLOAD_INVOICE
 | WAS_YOUR_CALL_SUCCESSFUL
 | DRIVER_ADDITIONS
 | FARE_UPDATE_POLICY
 | DRIVER_ADDITIONS_OPTIONAL
 | THE_DRIVER_MAY_QUOTE_EXTRA_TO_COVER_FOR_TRAFFIC
 | DRIVER_ADDITIONS_ARE_CALCULATED_AT_RATE String
 | DRIVER_MAY_NOT_CHARGE_THIS_ADDITIONAL_FARE
 | YOU_MAY_SEE_AN_UPDATED_FINAL_FARE_DUE_TO_ANY_OF_THE_BELOW_REASONS
 | REASON_CHANGE_IN_ROUTE_A
 | REASON_CHANGE_IN_ROUTE_B
 | GO_TO_ZONE String
 | REQUEST_RECEIVED_WE_WILL_CALL_YOU_BACK_SOON
 | CONTACT_REMOVED_SUCCESSFULLY
 | CORPORATE_ADDRESS
 | CORPORATE_ADDRESS_DESCRIPTION String
 | CORPORATE_ADDRESS_DESCRIPTION_ADDITIONAL String
 | REGISTERED_ADDRESS
 | REGISTERED_ADDRESS_DESCRIPTION String
 | REGISTERED_ADDRESS_DESCRIPTION_ADDITIONAL String
 | RECOMMENDED
 | COMPLETE_YOUR_PROFILE_FOR_A_PERSONALISED_RIDE_EXPERIENCE
 | COMPLETE_YOUR_NAMMA_SAFETY_SETUP_FOR_SAFE_RIDE_EXPERIENCE
 | UPDATE_NOW
 | WE_WOULD_APPRECIATE_YOUR_FEEDBACK
 | REASON_FOR_DELETING_ACCOUNT
 | SUBMIT_REQUEST
 | PLEASE_ENTER_A_VALID_EMAIL
 | WE_WOULD_APPRECIATE_YOUR_REASONING
 | OK_GOT_IT
 | WAIT_FOR_DRIVER
 | NO_LONGER_REQUIRE_A_RIDE_DUE_TO_CHANGE_IN_PLANS
 | CANCELLING_AS_I_GOT_A_RIDE_ON_ANOTHER_APP
 | DRIVER_LOCATION_WASNT_CHANGING_ON_THE_MAP
 | DRIVER_WAS_TAKING_TOO_LONG_TO_REACH_THE_PICKUP_LOCATION
 | THE_PICKUP_LOCATION_ENTERED_WAS_WRONG
 | YOUR_DRIVER_IS_JUST
 | M_AWAY
 | DRIVER_HAS_ALREADY_TRAVELLED
 | PLEASE_CONTACT_THE_DRIVER_BEFORE_CANCELLING
 | CONFIRM_WITH_YOUR_DRIVER
 | CHANGE_OF_PLANS
 | DRIVER_IS_NOT_MOVING
 | WRONG_PICKUP_LOCATION
 | DRIVER_MIGHT_BE_TAKING_ALTERNATE_ROUTE
 | DRIVER_IS_NOT_MOVING_Q
 | WOULD_YOU_LIKE_TO_CHECK_WITH_THE_DRIVER_BEFORE_CANCELLING
 | DRIVER_IS_NEAR_YOUR_LOCATION
 | SOME_OTHER_REASON
 | LOCATION_PERMISSION_SUBTITLE_NEW_USER
 | METRO_RIDE
 | GO_BACK_TEXT
 | DRIVER_PREFERRED_YOUR_SPECIAL_REQUEST_AND_IS_JUST
 | DRIVER_PREFERRED_YOUR_SPECIAL_REQUEST
 | AND_HAS_TRAVELLED
 | PLEASE_FIND_REVISED_FARE_ESTIMATE
 | FARE_ESTIMATE
 | TIP_SELECTED
 | ADD_A_TIP_TO_FIND_A_RIDE_QUICKER
 | IT_SEEMS_TO_BE_TAKING_LONGER_THAN_USUAL
 | CONTINUE_SEARCH_WITH
 | CONTINUING_SEARCH_WITH
 | SEARCHING_WITH
 | THE_DRIVER_PREFERRED_YOUR_SPECIAL_REQUEST_AND_IS_ALREADY_ON_THE_WAY_TO_YOUR_LOCATION
 | DRIVER_IS_ALREADY_ON_THE_WAY_TO_YOUR_LOCATION
 | ALLOW_LOCATION_ACCESS
 | MESSAGE_FROM_DRIVER
 | REPLY
 | NAME_SHOULD_BE_MORE_THAN_2_CHARACTERS
 | THIS_FIELD_IS_REQUIRED
 | EMAIL_EXISTS_ALREADY
 | OKAY_GOT_IT
 | CALL_NAMMA_YATRI_SUPPORT String
 | CALL_112
 | SEATS
 | OTP_PAGE_HAS_BEEN_EXPIRED_PLEASE_REQUEST_OTP_AGAIN
 | OTP_ENTERING_LIMIT_EXHAUSTED_PLEASE_TRY_AGAIN_LATER
 | TOO_MANY_LOGIN_ATTEMPTS_PLEASE_TRY_AGAIN_LATER
 | SOMETHING_WENT_WRONG_PLEASE_TRY_AGAIN
 | SORRY_LIMIT_EXCEEDED_YOU_CANT_ADD_ANY_MORE_FAVOURITES
 | IT_SEEMS_LIKE_YOU_HAVE_AN_ONGOING_RIDE_
 | CANCELLATION_UNSUCCESSFULL_PLEASE_TRY_AGAIN
 | NO_DRIVER_AVAILABLE_AT_THE_MOMENT_PLEASE_TRY_AGAIN
 | OTP_FOR_THE_JATRI_SATHI_ZONE_HAS_BEEN_EXPIRED_PLEASE_TRY_LOOKING_AGAIN String
 | NO_CONTACTS_FOUND_ON_THE_DEVICE_TO_BE_ADDED
 | PLEASE_ENABLE_CONTACTS_PERMISSION_TO_PROCEED
 | LIMIT_REACHED_3_OF_3_EMERGENCY_CONTACTS_ALREADY_ADDED
 | INVALID_CONTACT_FORMAT
 | OTP_RESENT_LIMIT_EXHAUSTED_PLEASE_TRY_AGAIN_LATER
 | RATE_YOUR_EXPERIENCE
 | REPORT_ISSUE_
 | DONE
 | PLEASE_TELL_US_WHAT_WENT_WRONG
 | YOUR_FEEDBACK_HELPS_US String
 | DID_YOU_FACE_ANY_ISSUE
 | DID_THE_DRIVER_OFFER_ASSISTANCE
 | WAS_THE_DRIVER_UNDERSTANDING_OF_YOUR_NEEDS
 | WE_NOTICED_YOUR_RIDE_ENDED_AWAY
 | GET_CALLBACK_FROM_US
 | DRIVER_WAS_NOT_READY_TO_GO
 | ASKING_FOR_MORE_MONEY
 | VEHICLE_BROKEN
 | WE_WILL_GIVE_YOU_CALLBACK
 | YOUR_ISSUE_HAS_BEEN_REPORTED
 | OTP_RESENT_SUCCESSFULLY
 | DESCRIPTION_SHOULD_BE_MORE_THAN_10_ALPHABETIC_CHARACTERS
 | INCORRECT_OTP_PLEASE_TRY_AGAIN
 | N_MORE_ATTEMPTS_LEFT
 | GO_TO_SELECTED_PICKUP_SPOT
 | GO_TO_SELECTED_PICKUP_SPOT_AS_AUTOS_ARE_RESTRICTED
 | UNPROFESSIONAL_DRIVER
 | RASH_DRIVING
 | DRIVER_CHARGED_MORE
 | UNCOMFORTABLE_AUTO
 | UNCOMFORTABLE_CAB
 | TRIP_GOT_DELAYED
 | FELT_UNSAFE
 | POLITE_DRIVER
 | EXPERT_DRIVING
 | SAFE_RIDE
 | CLEAN_AUTO
 | CLEAN_CAB
 | ON_TIME
 | SKILLED_NAVIGATOR
 | RUDE_DRIVER
 | TOO_MANY_CALLS
 | RECKLESS_DRIVING
 | LATE_DROP_OFF
 | LATE_PICK_UP
 | POOR_EXPERIENCE
 | TERRIBLE_EXPERIENCE
 | NEEDS_IMPROVEMENT
 | AMAZING
 | ALMOST_PERFECT
 | ASKED_FOR_EXTRA_FARE
 | ANYTHING_THAT_YOU_WOULD_LIKE_TO_TELL_US
 | PLATFORM_FEE
 | FINDING_QUOTES_TEXT
 | PLEASE_WAIT
 | PAY_DRIVER_USING_WALLET
 | FASTER
 | NEW_
 | SGST
 | OTP_EXPIRED
 | OTP_EXPIRED_DESCRIPTION
 | PLATFORM_GST
 | MISC_WAITING_CHARGE
 | TAXI_FROM_ZONE String
 | TAXI
 | AC
 | NON_AC
 | AC_TAXI
 | NON_AC_TAXI
 | GET_OTP_VIA_WHATSAPP
 | OR
 | HELPS_DRIVER_CONFIRM_ITS_YOU
 | LETS_GET_YOU_TRIP_READY
 | GOT_AN_OTP
 | JUST_ONE_LAST_THING
 | TOLL_CHARGES_WILL_BE_EXTRA
 | AUTO_RICKSHAW
 | CABS_AVAILABLE
 | GENERAL_DISABILITY_DESCRIPTION
 | PI_POINTER_1
 | PI_POINTER_2
 | VI_POINTER_1
 | VI_POINTER_2
 | HI_POINTER_1
 | HI_POINTER_2
 | ACCESSIBILITY_TEXT String
 | TO_CATER_YOUR_SPECIFIC_NEEDS String
 | SPECIAL_ASSISTANCE
 | SELECT_THE_CONDITION_THAT_IS_APPLICABLE
 | DISABILITY_CLAIMER_TEXT
 | ARE_YOU_A_PERSON_WITH_DISABILITY
 | DO_YOU_NEEED_SPECIAL_ASSISTANCE
 | ASSISTANCE_REQUIRED
 | NO_DISABILITY
 | LEARN_HOW_TEXT String
 | UPDATE_PROFILE
 | NOW_GET_ASSISTED_RIDES
 | SENT_OTP_VIA_SMS
 | SENT_OTP_VIA_WHATSAPP 
 | PLEASE_ENABLE_LOCATION_PERMISSION String
 | ENABLE_LOCATION_PERMISSION_TO
 | AC_SUV
 | AC_CAB
 | RIDE_TYPE
 | ERNAKULAM_LIMIT_CHARGE
 | SELECT_LOCATION_ON_MAP
 | DOWNLOAD_DRIVER_RECEIPT
 | VIEW_DRIVER_RECEIPT
 | DRIVER_RECEIPT
 | HELP
 | FARE_INFO_TEXT String
 | EDUCATIONAL_POP_UP_SLIDE_1_TITLE
 | EDUCATIONAL_POP_UP_SLIDE_2_TITLE
 | EDUCATIONAL_POP_UP_SLIDE_3_TITLE
 | EDUCATIONAL_POP_UP_SLIDE_4_TITLE
 | EDUCATIONAL_POP_UP_SLIDE_5_TITLE
 | EDUCATIONAL_POP_UP_SLIDE_1_SUBTITLE
 | EDUCATIONAL_POP_UP_SLIDE_2_SUBTITLE
 | EDUCATIONAL_POP_UP_SLIDE_3_SUBTITLE
 | EDUCATIONAL_POP_UP_SLIDE_4_SUBTITLE
 | EDUCATIONAL_POP_UP_SLIDE_5_SUBTITLE
 | INCLUSIVE_AND_ACCESSIBLE
 | YOU_SEEM_TO_BE_FAR_FROM_PICK_UP
 | ARE_YOU_SURE_YOU_WANT_TO_PROCEED_WITH_THE_BOOKING
 | MY_TICKETS
 | SOMETHING_WENT_WRONG_TRY_AGAIN_LATER
 | YOU_CAN_BOOK_TICKETS_TO_THE_ZOO_BY_CLICKING_THE_BUTTON
 | CHARGES_APPLICABLE_AFTER_3_MINS
 | WAITING_AT_PICKUP
 | REACHING_YOUR_DESTINATION_IN_
 | LEARN_MORE
 | PICKUP
 | PAY_BY_CASH_OR_UPI
 | WAIT_TIMER
 | HOW_LONG_DRIVER_WAITED_FOR_PICKUP
 | YOU_WILL_PAY_FOR_EVERY_MINUTE String String
 | CHAT_WITH
 | QUICK
 | CHATS
 | REPLIES
 | NAMMA_SAFETY
 | YOU_SENT
 | MESSAGE_YOUR_DRIVER
 | CHECK_IN_WITH_YOUR_DRIVER
 | CHECK_IN_WITH_YOUR_EM String
 | TRACK_ON_GOOGLE_MAPS
 | OTP_EXPIRE_TIMER
 | SHOWS_FOR_HOW_LONG_YOUR_OTP_
 | IF_YOUR_OTP_EXPIRES_
 | YOU_HAVE_REACHED_DESTINATION 
 | PLACES_YOU_MIGHT_LIKE_TO_GO_TO
 | SUGGESTED_DESTINATION
 | RECENT_RIDES
 | ONE_CLICK_BOOKING_FOR_YOUR_FAVOURITE_JOURNEYS
 | VIEW_MORE
 | VIEW_LESS
 | HAVE_A_REFFERAL 
 | YOUR_SUGGESTED_DESTINATIONS_AND_RECENT_RIDES_WILL_APPEAR_HERE
 | WELCOME_TO_NAMMA_YATRI_
 | BOOK_AND_MOVE
 | ANYWHERE_IN_THE_CITY
 | CHECKOUT_OUR_LIVE_STATS
 | MOST_LOVED_APP String
 | PICKUP_
 | PAST_SEARCHES
 | SEARCH_RESULTS
 | EDIT_DESTINATION
 | REQUESTING_RIDE_IN
 | CONFIRM_FARE
 | REQUEST_CHANGE
 | REQUESTING_RIDE
 | TAP_HERE_TO_STOP_AUTO_REQUESTING
 | POWERED_BY
 | BOOK_YOUR_RIDE
 | START_TYPING_TO_SEARCH_PLACES
 | FARE_UPDATED_WITH_CHARGES
 | FARE_UPDATED_WITH_SHORTER_DIST
 | FARE_UPDATED_WITH_LONGER_DIST
 | FARE_UPDATED_WITH_CHARGES_SHORTER_DIST
 | FARE_UPDATED_WITH_CHARGES_LONGER_DIST
 | DID_YOU_HAVE_A_SAFE_JOURNEY
 | TRIP_WAS_SAFE_AND_WORRY_FREE
 | DRIVER_BEHAVED_INAPPROPRIATELY
 | I_DID_NOT_FEEL_SAFE
 | LOOKING_FOR_ANOTHER_RIDE
 | THE_RIDE_HAD_BEEN_CANCELLED_WE_ARE_FINDING_YOU_ANOTHER
 | ENJOY_THE_RIDE
 | RIDE_STARTED
 | DISCOVER_AWESOME_SPOTS_TAILORED_JUST_FOR_YOU 
 | SMART
 | ONE_CLICK
 | NOT_SERVICEABLE
 | WE_ARE_NOT_LIVE_IN_YOUR_AREA
 | FACING_PROBLEM_WITH_APP 
 | TAP_HERE_TO_REPORT
 | CONFIRM_YOUR_RIDE
 | RIDE_SCHEDULED
 | RIDE_STARTS_ON
 | RENTAL_PACKAGE
 | GO_HOME
 | CANCEL_RENTAL_BOOKING
 | ADD_FIRST_STOP
 | DRIVER_WILL_BE_ASSIGNED_MINUTES_BEFORE_STARTING_THE_RIDE
 | YEARS_AGO
 | REPORTED_ISSUES
 | RESOLVED_ISSUES
 | ISSUE_NO
 | REPORTED
 | RESOLVED
 | MONTHS_AGO
 | DAYS_AGO
 | HOURS_AGO
 | MIN_AGO
 | SEC_AGO
 | RIDE_RELATED_ISSUE_PAGE_NAME
 | APP_RELATED_ISSUE_PAGE_NAME
 | DRIVER_RELATED_ISSUE_PAGE_NAME
 | LOST_AND_FOUND_ISSUE_PAGE_NAME
 | SELECT_A_RIDE_TO_REPORT
 | I_DONT_KNOW_WHICH_RIDE
 | YOUR_REPORTS
 | VIEW
 | ADD_VOICE_NOTE
 | VOICE_NOTE
 | ADDED_IMAGES
 | NO_IMAGES_ADDED
 | SUBMIT_ISSUE_DETAILS
 | IMAGE_PREVIEW
 | REPORT_ISSUE_CHAT_PLACEHOLDER String
 | ADDED_VOICE_NOTE
 | NO_VOICE_NOTE_ADDED
 | CALL_DRIVER_TITLE
 | CALL_DRIVER_DESCRIPTION
 | CALL_SUPPORT_TITLE
 | CALL_SUPPORT_DESCRIPTION String
 | ADD_IMAGE
 | ADD_ANOTHER
 | IMAGES
 | ISSUE_SUBMITTED_TEXT
 | ISSUE_RESOLVED_TEXT
 | CHOOSE_AN_OPTION
 | IMAGE
 | ISSUE_MARKED_AS_RESOLVED
 | STILL_HAVING_ISSUE
 | RECORD_VOICE_NOTE
 | CANCEL_BUTTON
 | MAX_IMAGES
 | SOS_ISSUE_PAGE_NAME 
 | FARE_DISCREPANCIES_ISSUE_PAGE_NAME
 | PAYMENT_RELATED_ISSUE_PAGE_NAME
 | ACCOUNT_RELATED_ISSUE_PAGE_NAME
 | OTHER_ISSUES
 | CANT_FIND_OPTION
 | NEED_HELP 
 | SAFETY_ISSUE_PAGE_NAME
 | WE_HOPE_THE_ISSUE_IS_RESOLVED String 
 | PLEASE_SELECT_THE_RIDE_TO_CALL_DRIVER 
 | ADD_IMAGE_S 
 | ALREADY_HAVE_AN_ACTIVE_RIDE
 | CONFIRM_STOP_LOCATION
 | CONFIRM_DROP
 | BOOK_METRO_WITH_NY_NOW
 | LEARN_ABOUT_NAMMA_SAFETY
 | NAMMA_SAFETY_WILL_ENABLE_ACCESS
 | EDIT_ACTIONS
 | EMERGENCY_ACTIONS
 | WHEN_YOU_START_EMERGENCY_SOS
 | RIDE_SHARE_AFTER_SIX_PM
 | WHO_CAN_TRACK_YOUR_RIDE String
 | EMERGENCY_SHARING_WITH_CONTACTS
 | SHARING_WITH
 | ADD_A_CONTACT
 | TO_ENSURE_SAFETY_USERS_SHOULD
 | ABOUT_SOS_DESC
 | FEW_EXAMPLES_OF_SOS_SITUATIONS
 | THINGS_TO_DO_DURING_SOS_SITUATION
 | EMERGENCY_REQUEST_SENT
 | SOS_TRIGGERED_DESC
 | SOS_ACTIONS
 | CALL_POLICE
 | CALL_SUPPORT
 | RECORD_VIDEO
 | STOP_AND_SHARE_RECORDING
 | CANCEL_SHARING
 | START_RECORDING
 | SHARING_THE_VIDEO_IN
 | EMERGENCY_INFO_SHARED
 | EMERGENCY_INFO_SHARED_ACTION
 | SET_UP_YOUR_PERSONAL_SAFETY_SETTINGS
 | ACTIVATE_LIVE_VIDEO_RECORDING_FEATURES
 | CHOOSE_RESPONSIVE_CONTACTS
 | SHARE_LOCATION_AND_RIDE_DETAILS_EMERGENCY_CONTACT
 | NAMMA_SAFETY_MEASURES
 | SAFETY_GUIDELINES_FOR_YOU
 | ABOUT_SOS
 | NIGHT_TIME_SAFETY_CHECKS
 | SHARE_INFO_WITH_EMERGENCY_CONTACTS_TITLE
 | SHARE_INFO_WITH_EMERGENCY_CONTACTS_DESC
 | TRIGGER_ALERT_TO_NAMMAYATRI_SUPPORT_TITLE String
 | TRIGGER_ALERT_TO_NAMMAYATRI_SUPPORT_DESC
 | ENABLE_NIGHT_TIME_SAFETY_ALERTS_TITLE
 | ENABLE_NIGHT_TIME_SAFETY_ALERTS_DESC
 | ALMOST_DONE_TITLE
 | ALMOST_DONE_DESC
 | SAFETY_MEASURE_1
 | SAFETY_MEASURE_2
 | SAFETY_MEASURE_3
 | SAFETY_MEASURE_4
 | SAFETY_MEASURE_5 String
 | SAFETY_MEASURE_6
 | SAFETY_GUIDELINES_1
 | SAFETY_GUIDELINES_2
 | SAFETY_GUIDELINES_3
 | SAFETY_GUIDELINES_4
 | SAFETY_GUIDELINES_5
 | SAFETY_GUIDELINES_6
 | SAFETY_GUIDELINES_7
 | ABOUT_SOS_1
 | ABOUT_SOS_2
 | ABOUT_SOS_3
 | ABOUT_SOS_4
 | ABOUT_SOS_5
 | ABOUT_SOS_6
 | ABOUT_SOS_7
 | ABOUT_SOS_8
 | ABOUT_SOS_9
 | ABOUT_SOS_10
 | ABOUT_SOS_11 String
 | ABOUT_SOS_12
 | ABOUT_SOS_13
 | THE_VIDEO_WILL_BE_RECORDED
 | EMERGENCY_VIDEO
 | NAMMA_SAFETY_IS_SET_UP
 | PERSONAL_SAFETY_SETTINGS_PERMISSION_REQUEST
 | ACTIVATE_NAMMA_SAFETY_POPUP_TITLE
 | ACTIVATE_NAMMA_SAFETY_POPUP_DESC
 | ACTIVATE_NAMMA_SAFETY_POPUP_ACTION
 | DISMISS
 | SEND_SILENT_SOS_TO_POLICE
 | OUR_SAFETY_PARTNER
 | BANGALURU_CITY_POLICE
 | GET_OPTIONS_TO_DIRECTLY_CALL_POLICE
 | SHARE_SOS_SILENTLY_WITH_POLICE
 | CALL_AND_ALERT_THE_NEAREST_POLICE_CENTRE
 | SEND_A_SILENT_SOS_TO_THE_POLICE
 | SEND_A_VIDEO_RECORDING_TO_POLICE
 | PERSONAL_SAFETY_ACTION_1
 | PERSONAL_SAFETY_ACTION_2 String
 | PERSONAL_SAFETY_ACTION_2_POLICE
 | PERSONAL_SAFETY_ACTION_3
 | SEND_VIDEO_TO_POLICE
 | FINISH_SETUP
 | MARK_RIDE_AS_SAFE
 | ACTIVATE_SOS
 | EMERGENCY_INFO_SHARED_ACTION_POLICE
 | START_SETUP
 | CALL_SUPPORT_FOR_SAFETY String
 | WE_NOTICED_YOUR_RIDE_HASNT_MOVED
 | WE_NOTICED_YOUR_RIDE_IS_ON_DIFFERENT_ROUTE
 | WE_ARE_HERE_FOR_YOU
 | I_NEED_HELP
 | I_FEEL_SAFE
 | EVERYTHING_OKAY_Q
 | PLEASE_REMAIN_CALM_YOU_CAN_REQUEST_AN_IMMEDIATE_CALL
 | RECEIVE_CALL_FROM_SUPPORT
 | ADD_CONTACTS
 | VIDEO_SHARE_INFO_TO_POLICE
 | CALL_POLICE_HELPLINE
 | PLEASE_REMAIN_CALM_CALL_POLICE
 | PLEASE_ALLOW_CAMERA_AND_MICROPHONE_PERMISSIONS
 | ACTIVATE_NAMMA_SAFETY_WILL_ENABLE_ACCESS
 | SELECT_PREFERRED_CONTACTS
 | NEW
 | SAFETY_CENTER
 | EMERGENCY_SOS
 | AUTOMATIC_CALL_PLACED_TO_EMERGENCY_CONTACTS
 | EMERGENCY_CONTACTS_CAN_FOLLOW String
 | ALERT_SAFETY_TEAM String
 | OPTION_TO_REPORT_A_SAFETY_ISSUE
 | RECOMMEND_EMERGENCY_CONTACTS_TO_INSTALL String
 | TEST_SAFETY_DRILL
 | START_TEST_DRILL
 | REPORT_SAFETY_ISSUE
 | SAFETY_TEAM_WILL_BE_ALERTED String
 | EMERGENCY_CONTACTS_CAN_TAKE_ACTION String
 | SHARE_RIDE
 | SHARE_RIDE_DESCRIPTION String
 | SHARE_RIDE_WITH_CONTACT String
 | SHARE_LINK
 | GLAD_TO_KNOW_YOU_ARE_SAFE
 | PLEASE_STAY_CALM_TEAM_ALERTED String
 | TRY_ANOTHER_CONTACT
 | YOUR_CURRENT_LOCATION
 | THIS_IS_NOT_A_REAL_SOS_SITUATION
 | YOUR_VEHICLE_INFO
 | POLICE_VIEW_INSTRUCTION
 | TEST_SOS_ACTIVATING_IN
 | SOS
 | TEST_SOS
 | SELECT_CONTACT_TO_CALL
 | EMERGENCY_SOS_ACTIVATING
 | PRESS_TO_START_TEST_DRILL
 | PRESS_IN_CASE_OF_EMERGENCY
 | INFORM_EMERGENCY_CONTACTS
 | AVAILABLE_IN_REAL_EMERGENCY
 | OTHER_SAFETY_ACTIONS
 | DISCLAIMER
 | USE_ONLY_IN_EMERGENCY
 | MISUSE_MAY_LEAD_TO_LEGAL_ACTION
 | USE_TEST_DRILL
 | INDICATION_TO_EMERGENCY_CONTACTS String
 | ARE_YOU_READY_TO_START_DRILL
 | TEST_DRILL_DESC
 | LEARN_ABOUT_SAFETY_MODE
 | TEST_EMERGENCY_REQUEST_SENT
 | TEST_SOS_TRIGGERED_DESC
 | SOS_WILL_BE_DISABLED
 | DIAL_NOW
 | FOLLOWING String
 | TURN_OFF_ALARM
 | CHOOSE_A_PERSON_TO_FOLLOW
 | IS_IN_SOS_SITUATION String
 | MARKED_RIDE_SAFE String
 | STAY_CALM_KEEP_TRACKING String
 | YOU_WILL_BE_NOTIFIED
 | TAP_HERE_TO_FOLLOW String
 | HAVE_SHARED_RIDE_WITH_YOU String
 | SOS_LOCATION
 | THIS_IS_A_TEST_MOCK_DRILL String
 | THIS_IS_NOT_REAL_DRILL
 | REACHED_DESTINATION_SAFELY String
 | RIDE_ENDED String
 | COMPLETE_YOUR_TEST_DRILL
 | TEST_DRILL
 | RIDE_SHARED_WITH_SELECTED_CONTACTS
 | TERMS_AND_CONDITIONS_UPDATED
 | OKAY
 | TRY_LATER
 | REFERRAL_CODE_IS_APPLIED
 | YOU_HAVE_ALREADY_USED_DIFFERENT_REFERRAL_CODE
 | INVALID_REFERRAL_CODE
  | STOPS
  | GREEN_LINE
  | BLUE_LINE
  | RED_LINE
  | VIEW_ROUTE_INFO
  | VALID_UNTIL
  | TICKET_NUMBER
  | TICKET
  | TICKETS
  | ONWORD_JOURNEY
  | ROUND_TRIP_STR
  | TICKETS_FOR_CHENNAI_METRO
  | ACTIVE_STR
  | EXPIRED_STR
  | USED_STR
  | MAP_STR
  | TICKET_DETAILS
  | ROUTE_DETAILS
  | UNCERTAIN_ABOUT_METRO_ROUTES
  | SEE_MAP   
  | CHENNAI_METRO_TERM_1
  | CHENNAI_METRO_TERM_2
  | CHENNAI_METRO_TERM_EVENT
  | FREE_TICKET_CASHBACK
  | NO_OF_PASSENGERS
  | MAXIMUM
  | TICKETS_ALLOWED_PER_USER
  | STARTING_FROM
  | FROM
  | TO
  | BOOKING_ID
  | PLEASE_WHILE_GEN_TICKET
  | PAYMENT_RECEIVED
  | PLEASE_CHECK_BACK_FEW_MIN
  | YOUR_BOOKING_PENDING
  | PLEASE_RETRY_BOOKING
  | BOOKING_FAILED
  | INCASE_OF_FAIL
  | REFRESH_STATUS
  | DATE
  | NO_OF_TICKETS
  | ACTIVE_TICKETS
  | CONFIRMING_STR
  | FAILED_STR
  | CONFIRMED_STR
  | BUY_METRO_TICKETS
  | GET_FARE
  | METRO_BOOKING_TIMINGS
  | CHENNAI_METRO_TIME String String
  | PLEASE_COME_BACK_LATER_METRO
  | NO_QOUTES_AVAILABLE
  | I_AGREE_TO_THE
  | HERE_IS_METRO_TICKET
  | VIEW_TICKET 
  | DESTINATION
  | PAY 
  | PENDING_STR 
  | PAST_TICKETS
  | ONE_WAY_STR
  | SHARE_TICKET
  | ORIGIN
  | HISTORY 
  | ALWAYS
  | ALWAYS_SHARE_DESC
  | NIGHT_RIDES_SHARE
  | NIGHT_RIDES_DESC
  | NEVER
  | NEVER_SHARE_DESC
  | SHARE_TRIP_NOTIFICATONS
  | CALL_CUSTOMER_SUPPORT
  | YET_TO_START String
  | MESSAGE_FROM String
  | RIDE_CANCELLED
  | TRACK_RIDE_STRING String String String String  
  | SAFETY_CENTER_IS_DISABLED
  | TRACK_ON_GOOGLE_MAP
  | SHOW_WALKING_DIRECTION
  | SPECIAL_PICKUP_ZONE
  | SPECIAL_PICKUP_ZONE_RIDE
  | WE_WILL_TRY_TO_CONNECT_YOU_WITH_DRIVER_IN_CLOSEST_PICKUP_ZONE
  | THIS_PROVIDES_YOU_AN_INSTANT_PICKUP_EXPERIENCE
  | DRIVER_AT_PICKUP_LOCATION
  | DRIVER_ALMOST_AT_PICKUP
  | MAXIMUM_EDIT_PICKUP_ATTEMPTS_REACHED
  | MOVE_PIN_TO_THE_DESIRED_PICKUP_POINT
  | CHANGE_PICKUP_LOCATION
  | LOCATION_IS_TOO_FAR  
  | A_TIP_HELPS_FIND_A_RIDE_QUICKER
  | TIP_ADDED        
  | CONTINUE_SEARCH_WITH_NO_TIP
  | SEARCHING_WITH_NO_TIP
  | SEARCH_AGAIN
  | DRIVER_IS_ON_THE_WAY
  | DRIVER_IS_WAITING_AT_PICKUP
  | IS_AT_PICKUP_LOCATION
  | GO_TO_SELECTED_SPOT_FOR_PICKUP
  | SELECT_POPULAR_SPOT_FOR_HASSLE_FREE_PICKUP
  | TICKET_IS_NON_CANCELLABLE
  | CANCEL_BOOKING
  | BOOKING_NOT_CANCELLABLE
  | BOOKINGS_WILL_BE_CANCELLED
  | BOOKINGS_WILL_BE_CANCELLED_WITH_REFUND String
  | REFUND_NOT_APPLICABLE
  | YES_CANCEL_BOOKING
  | WOULD_YOU_LIKE_TO_PROCEED
  | BOOKING_CANCELLED
  | REFUND_IS_IN_PROCESS
  | TOTAL_REFUND
  | NUMBER_OF_TICKETS
  | CANCELLATION_DATE
  | TICKETS_FOR_KOCHI_METRO
  | YOUR_BOOKED_TICKETS
  | PLAN_YOUR_JOURNEY
  | BOOK_ROUND_TRIP
  | BY_PROCEEDING_YOU_AGREE
  | TERMS_AND_CONDITIONS_FULL
  | EXPERIENCE_HASSLE_FREE_METRO_BOOKING String
  | KOCHI_METRO_TERM_1
  | KOCHI_METRO_TERM_2
  | KOCHI_METRO_TIME
  | BOOK_TICKET
  | PREPARE_EMERGENCY_CONTACTS
  | EMERGENCY_CONTACTS_WILL_BE_NOTIFIED
  | INFORM_EMERGENCY_CONTACTS_ABOUT_TEST
  | RECENT_RIDE_ISSUE_DESC
  | I_NEED_HELP_WITH_MY_RECENT_RIDE
  | CONTINUE_WITH_SAFETY_SETTINGS
  | TAP_WHERE_TO_TO_BOOK_RIDE

  | LAST_CHOSEN_VARIANT_NOT_AVAILABLE
  | TOLL_CHARGES
  | TOLL_CHARGES_DESC 
  | TOLL_CHARGES_INCLUDING String
  | TOLL_ROAD_CHANGED 
  | PARKING_CHARGE 
  | TOLL_OR_PARKING_CHARGES
  | TOLL_CHARGES_ESTIMATED
  | ADD_TIP
  | CHANGE_RIDE_TYPE
  | TRY_ADDING_TIP_OR_CHANGE_RIDE_TYPE
  | APPLICABLE_TOLL_CHARGES
  | UPDATE_TIP_STR
  | BOOK String
  | FARE_FOR String
  | WAITING_CHARGE_LIMIT String
  | TIME_TAKEN
  | TRIP_DISTANCE
  | UNABLE_TO_CANCEL_RIDE
  | GOT_A_REFERRAL_FROM_A_DRIVER_OR_FRIEND
  | ENTER_REFERRAL_CODE_
  | REFERRED_USERS
  | SHOW_APP_QR
  | SHARE_AND_REFER
  | YOUR_REFERRAL_CODE
  | REFER_YOUR_FRIENDS
  | REFERRALS
  | ENTER_NOW
  | WHAT_IS_REFERRAL_PROGRAM
  | USERS_WHO_DOWNLOAD_APP_AND_COMPLETE_THEIR_FIRST_RIDE_USING_REFERRAL_CODE String
  | THE_REFERRAL_PROGRAM_INCENTIVISES_DRIVERS_TO_ACCEPT_MORE_RIDES String
  | INVALID_CODE
  | ENTER_6_DIGIT_REFERRAL_CODE_BELOW
  | APPLY
  | TOLL_CHARGES_INCLUDED
  | ONE_TAP_BOOKINGS
  | HAS_YOUR_DRIVER_SET_THE_AC_AS_PER_YOUR_PREFERENCE
  | NO_REPORT_AN_ISSUE
  | GREAT_ENJOY_THE_TRIP
  | ENJOY_YOUR_BUDGET_FRIENDLY_NON_AC_RIDE
  | AC_IS_NOT_AVAILABLE_ON_THIS_RIDE
  | AC_NOT_WORKING_DESC
  | SHOWING_FARE_FROM_MULTI_PROVIDER
  | LIVE_CHAT
  | DRIVER_TIP_ADDITION
  | LIVE_RIDE_SHARING
  | ENHANCED_SAFETY
  | CONFIRM_PROVIDER
  | SELECT_A_PROVIDER
  | CONFIRMING_SELECTED_PROVIDER
  | BOOK_TOP_PROVIDER
  | CHOOSE_FROM_PROVIDERS
  | CHOOSE_BETWEEN_PROVIDERS 
  | CHOOSE_BETWEEN_PROVIDERS_DESC
  | GUARANTEED_RIDE 
  | THIS_RIDE_FULFILLED_BY String
  | ADDITIONAL_FEATURES_ON String
  | NOTIFY_YOUR_EC
  | EC_CAN_RESPOND
  | QUICK_SUPPORT String
  | LEARN_ABOUT_APP_SAFETY_FEAT String
  | OTHER_PROVIDER_NO_RECEIPT
  | RIDE_FULFILLED_BY String  
  | CONGESTION_CHARGES
  | TIP_CAN_BE_ADDED String
  | CONGESTION_CHARGES_DESC String
  | AC_TURNED_OFF
  | BOOK_ANY
  | ESTIMATES_EXPIRY_ERROR
  | ESTIMATES_EXPIRY_ERROR_AND_FETCH_AGAIN
  | PAY_YOUR_DRIVER_BY_CASH_OR_UPI
  | TRIP_DELAYED
  | SELECT_VEHICLE
  | BOOK_RENTAL
  | CONFIRM_RENTAL
  | RENTAL_RIDE
  | SELECT_DURATION
  | SELECT_DISTANCE
  | RENTAL_OPTIONS
  | BOOKING_ON
  | INCLUDED_KMS
  | BASE_FARE
  | TOLLS_AND_PARKING_FEES
  | FINAL_FARE_DESCRIPTION
  | EXCESS_DISTANCE_CHARGE_DESCRIPTION String
  | ADDITIONAL_CHARGES_DESCRIPTION
  | PARKING_FEES_AND_TOLLS_NOT_INCLUDED
  | NIGHT_TIME_FEE_DESCRIPTION
  | CHOOSE_YOUR_RENTAL_RIDE
  | FIRST_STOP_OPTIONAL
  | JANUARY
  | FEBRUARY
  | MARCH
  | APRIL
  | MAY
  | JUNE
  | JULY
  | AUGUST
  | SEPTEMBER
  | OCTOBER
  | NOVEMBER
  | DECEMBER
  | HOURS
  | NOT_ADDED_YET
  | NEXT_STOP
  | TIME
  | DISTANCE
  | STARTING_ODO
  | END_OTP
  | ONLY_LOCATION_WITHIN_CITY_LIMITS
  | RIDE_TIME
  | RIDE_DISTANCE
  | RIDE_STARTED_AT
  | RIDE_ENDED_AT
  | ESTIMATED_FARE
  | EXTRA_TIME_FARE
  | TOTAL_FARE
  | FARE_UPDATE
  | NOW
  | DATE_INVALID_MESSAGE
  | EDIT_PICKUP 
  | ADD_STOP 
  | ENTER_PICKUP_LOC 
  | INTERCITY_OPTIONS
  | PROCEED
  | SCHEDULE_RIDE_AVAILABLE
  | RENTAL_RIDE_UNTIL
  | EXTRA_TIME_CHARGES 
  | DIST_BASED_CHARGES
  | TIME_BASED_CHARGES
  | RENTAL_POLICY
  | SELECT_PACKAGE
  | RENTAL_POLICY_DESC
  | RENTAL_POLICY_DESC_1
  | RENTALS_INTERCITY_AVAILABLE String
  | CHECK_IT_OUT
  | FAILED_TO_CANCEL
  | SCHEDULING_ALLOWED_IN_INTERCITY_RENTAL
  | SPECIAL_ZONE_INTERCITY_INELIGIBLE
  | NO_RIDES_SCHEDULED_YET
  | RIDE_BOOKING
  | SPECIAL_ZONE_RENTAL_INELIGIBLE
  | SERVICES
  | YOU_HAVE_UPCOMING_RENTAL_BOOKING String
  | SCHEDULED
  | UPCOMING_BOOKINGS
  | RENTALS_
  | INTER_CITY_
  | YOU_HAVE_UPCOMING_INTERCITY_BOOKING String
  | A_RIDE_ALREADY_EXISTS
  | YOU_HAVE_AN_RIDE_FROM_TO_SCHEDULED_FROM_TILL
  | EXTRA_PER_KM_FARE
  | EXTRA_PER_MINUTE_FARE
  | PICKUP_CHARGES
  | WAITING_CHARGES_AFTER_3_MINS
  | FARE_DETERMINED_AS_PER_KARNATAKA_GUIDELINES
  | RENTAL_CHARGES
  | RENTAL_INFO_POLICY_DESC String
  | RENTAL_INFO_POLICY_DESC_
  | RENTAL_SCREEN_EXPLAINER
  | INSTANT
  | COMING_SOON
  | CANCEL_SCHEDULED_RIDE 
  | CANCEL_SCHEDULED_RIDE_DESC
  | CONFIRM_CANCELLATION
  | INTERCITY_RIDES_COMING_SOON
  | VIEW_FARES
  | EXCESS_TIME_DESCRIPTION String
  | ESTIMATED_CHARGES
  | NIGHT_TIME_FEES
  | PARKING_AND_OTHER_CHARGES
  | ADDITIONAL_CHARGES 
  | ESTIMATED_BASE_FARE 
  | INCLUDED_DISTANCE 
  | INCLUDED_TIME
  | TOLL_CHARGES_DESCRIPTION
  | WILL_BE_ADDED_TO_FINAL_FARE
  | EXTRA_DISTANCE_FARE
  | NETWORK_ERROR
  | SERVER_ERROR
  | UNKNOWN_ERROR
  | CONNECTION_REFUSED
  | TIMEOUT
  | WAS_TOLL_EXP_SMOOTH 
  | WAS_TOLL_EXP_SMOOTH_DESC  
  | WAS_DRIVER_HELPFUL 
  | WAS_RIDE_SAFE_DESC 
  | WAS_RIDE_SAFE  
  | WAS_DRIVER_HELPFUL_DESC  
  | COLLECT_TOLL_SEP  
  | FINAL_FARE_EXCLUDES_TOLL  
  | TOLL_CHARGES_MAYBE_APPLICABLE
  | METRO_BANNER_TITLE String
  | VIEW_ON_GOOGLE_MAPS
  | WALKING_DIRECTIONS_TO_PICKUP
  | EXPLORE_CITY_WITH_US String
  | GO_TO_DESTINATION String
  | WALK_TO String
  | BANGALORE
  | KOLKATA
  | PARIS
  | KOCHI
  | DELHI
  | HYDERABAD
  | MUMBAI
  | CHENNAI
  | COIMBATORE
  | PONDICHERRY
  | GOA
  | PUNE
  | MYSORE
  | TUMAKURU
  | NOIDA
  | GURUGRAM
  | WAITING_CHARGES
  | QUOTES_EXPIRY_ERROR_AND_FETCH_AGAIN
  | PLACE_A_CALL
  | YOU_CAN_WRITE_TO_US_AT
  | CHARGEABLE 
  | BOOKED
  | SURCHARGES
  | SILIGURI
  | KOZHIKODE
  | THRISSUR
  | TRIVANDRUM  
  | METRO_FREE_TICKET_EVENT String
  | METRO_FREE_TICKET_EVENT_DESC String String
  | NEXT_FREE_TICKET
  | FREE_TICKET_AVAILABLE String String
  | ADDITIONAL_CHARGES_WILL_BE_APPLICABLE
  | PARKING_CHARGES_INCLUDED String
  | APP_TOLL_CHARGES
  | APP_PARKING_CHARGES
  | APP_TOLL_PARKING_CHARGES
  | PARKING_CHARGES_DESC
  | TOLL_CHARGES_INCLUDED_IN_FAIR
  | PLEASE_DO_NOT_PAY_EXTRA_TO_DRIVER 
  | VELLORE
  | HOSUR 
  | MADURAI 
  | THANJAVUR 
  | TIRUNELVELI 
  | SALEM 
  | TRICHY
  | DAVANAGERE
  | SHIVAMOGGA
  | HUBLI
  | MANGALORE
  | GULBARGA
  | UDUPI
  | CANCEL_BOOKING_
  | CANCEL_INTERCITY_BOOKING
  | RENTAL_BOOKING
  | INTERCITY_BOOKING
  | BOOKING
  | CLEAN_BIKE
  | UNCOMFORTABLE_BIKE
  | DRIVER_AVAILABLE
  | DRIVERS_AVAILABLE
  | MORE_SAFETY_MEASURES
  | SAFETY_SETUP
  | COMPLETE
  | TRUSTED_CONTACT_HELP
  | DRIVER_SAFETY_STANDARDS
  | TRUSTED_CONTACT
  | SAFETY_DRILL
  | DEFAULT_CONTACT
  | APP_CALL_CHAT
  | TRUSTED_CONTACT_DESC
  | ENABLE_LIVE_TRACKING
  | UNEXPECTED_EVENT_CHECK
  | UNEXPECTED_EVENT_CHECK_DESC
  | UNEXPECTED_EVENT_CHECK_TIMINGS
  | NEXT
  | POST_RIDE_CHECK
  | POST_RIDE_CHECK_DESC
  | POST_RIDE_CHECK_TIMINGS
  | SAFETY_TEAM_NOTIFICATION
  | NOTIFY_SAFETY_TEAM
  | NOTIFY_SAFETY_TEAM_SUB
  | NOTIFY_SAFETY_TEAM_NOTE
  | EMERGENCY_SOS_NEW
  | EMERGENCY_SOS_SUB
  | SHAKE_TO_ACTIVATE
  | SHAKE_TO_ACTIVATE_SUB
  | AUTOMATIC_CALL_SOS
  | AUTOMATIC_CALL_SOS_SUB
  | PLACE_DEFAULT_CALL
  | DEFAULT_CALL_CONTACT
  | DEFAULT_CONTACT_DESC
  | MORE_EMERGENCY_ACTIONS
  | SIREN
  | CALL_POLICE_DESC
  | RECORD_AUDIO_DESC
  | SIREN_DESC
  | CALL_SAFETY_TEAM_DESC
  | SAFETY_DRILL_DESC
  | SAFETY_DRILL_SUB
  | SAFETY_DRILL_NOTE
  | RIDE_ACTIONS
  | RIDE_ACTIONS_SUB
  | LIVE_TRACKING
  | LIVE_TRACKING_SUB
  | CHAT_WITH_RIDER
  | CHAT_WITH_RIDER_SUB
  | EMERGENCY_ACTIONS_SUB
  | CURRENT_INITIATIVES
  | CURRENT_INITIATIVES_SUB
  | DRIVER_VERIFICATION
  | DRIVER_VERIFICATION_SUB
  | SAFETY_FEEDBACK
  | SAFETY_FEEDBACK_SUB
  | SAFETY_TRAINING
  | SAFETY_TRAINING_SUB
  | DRIVER_ID_CHECK
  | DRIVER_ID_CHECK_SUB
  | DATA_PRIVACY
  | DATA_PRIVACY_SUB
  | FAVOURITE_DRIVER
  | FAVOURITE_DRIVER_SUB
  | WOMEN_DRIVERS
  | WOMEN_DRIVERS_SUB
  | DASHCAM
  | DASHCAM_SUB
  | NEVER_SHARE_LN
  | ALWAYS_SHARE_LN
  | SHARE_WITH_TIME_CONSTRAINTS_LN
  | NEVER_SHARE_EM
  | ALWAYS_SHARE_EM
  | SHARE_WITH_TIME_CONSTRAINTS_EM
  | LIVE_RIDE_TRACKING
  | LIVE_RIDE_TRACKING_DESC
  | UPCOMING_INITIATIVES
  | UPCOMING_INITIATIVES_DESC
  | RECEIVE_CALL_FROM_SAFETY_TEAM
  | NOTIFY_ALL_EMERGENCY_CONTACTS
  | RECORD_AUDIO
  | CALL_SAFETY_TEAM
  | SAFETY_TEAM_CALLBACK_REQUESTED
  | EMERGENCY_CONTACTS_NOTIFIED
  | CALL_PLACED
  | EMERGENCY_SOS_ACTIVATED
  | TAP_TO_CALL_OTHER_EMERGENCY_CONTACTS
  | RECORDING_AUDIO
  | RECORDED_AUDIO
  | SHARE_WITH_SAFETY_TEAM
  | EMERGENCY
  | MANUAL_LIVE_TRACKING
  | MANUAL_LIVE_TRACKING_DESC
  | AUTOMATIC_LIVE_TRACKING
  | AUTOMATIC_LIVE_TRACKING_DESC
  | TRACKING_NO_SETUP
  | FOLLOWING_STR
  | DIALING_POLICE_IN_TIME String
  | TRANSIT
  | INTERCITY_STR 
  | RENTAL_STR
  | DELIVERY
  | INTERCITY_BUS
  | WHERE_ARE_YOU_GOING
  | TAP_TO_FOLLOW
  | HAS_SHARED_A_RIDE_WITH_YOU String
