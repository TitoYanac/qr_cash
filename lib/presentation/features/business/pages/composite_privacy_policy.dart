import 'package:flutter/material.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../atoms/composite_component.dart';
import '../../../atoms/list_component.dart';
import '../../../atoms/paragraph_component.dart';
import '../../../atoms/title_component.dart';
import '../../widgets/appbar_with_leading.dart';



class CompositePrivacyPolicyScreen extends StatelessWidget {
  const CompositePrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithLeading(title: translation(context)!.p_p_privacy_policy).getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ParagraphComponent(translation(context)!.p_p_this_privacy_notice_for_vistony_india_private_limited__doing_business_as_listoil____we___us__or__our___describes_how_and_why_we_might_collect_store_use_and_or_share___process___your_information_when_you_use_our_services___services___such_as_when_you_).render(),
              ListComponent([
                translation(context)!.p_p_download_and_use_our_mobile_application__qrcash__or_any_other_application_of_ours_that_links_to_this_privacy_notice,
                translation(context)!.p_p_engage_with_us_in_other_related_ways_including_any_sales_marketing_or_events
              ]).render(),
              ParagraphComponent(translation(context)!.p_p_questions_or_concerns__reading_this_privacy_notice_will_help_you_understand_your_privacy_rights_and_choices_if_you_do_not_agree_with_our_policies_and_practices_please_do_not_use_our_services_if_you_still_have_any_questions_or_concerns_please_contact_us_at_vsharma_listoil_com_).render(),
              CompositeComponent(translation(context)!.p_p_summary_of_key_points, [
                ParagraphComponent(translation(context)!.p_p_this_summary_provides_key_points_from_our_privacy_notice_but_you_can_find_out_more_details_about_any_of_these_topics_by_clicking_the_link_following_each_key_point_or_by_using_our_table_of_contents_below_to_find_the_section_you_are_looking_for_),
                ParagraphComponent(translation(context)!.p_p_what_personal_information_do_we_process__when_you_visit_use_or_navigate_our_services_we_may_process_personal_information_depending_on_how_you_interact_with_us_and_the_services_the_choices_you_make_and_the_products_and_features_you_use_learn_more_about_personal_information_you_disclose_to_us_),
                ParagraphComponent(translation(context)!.p_p_do_we_process_any_sensitive_personal_information__we_may_process_sensitive_personal_information_when_necessary_with_your_consent_or_as_otherwise_permitted_by_applicable_law_learn_more_about_sensitive_information_we_process_),
                ParagraphComponent(translation(context)!.p_p_do_we_receive_any_information_from_third_parties__we_do_not_receive_any_information_from_third_parties_),
                ParagraphComponent(translation(context)!.p_p_how_do_we_process_your_information__we_process_your_information_to_provide_improve_and_administer_our_services_communicate_with_you_for_security_and_fraud_prevention_and_to_comply_with_law_we_may_also_process_your_information_for_other_purposes_with_your_consent_we_process_your_information_only_when_we_have_a_valid_legal_reason_to_do_so_learn_more_about_how_we_process_your_information_),
                ParagraphComponent(translation(context)!.p_p_how_do_we_keep_your_information_safe__we_have_organizational_and_technical_processes_and_procedures_in_place_to_protect_your_personal_information_however_no_electronic_transmission_over_the_internet_or_information_storage_technology_can_be_guaranteed_to_be_100__secure_so_we_cannot_promise_or_guarantee_that_hackers_cybercriminals_or_other_unauthorized_third_parties_will_not_be_able_to_defeat_our_security_and_improperly_collect_access_steal_or_modify_your_information_learn_more_about_how_we_keep_your_information_safe_),
                ParagraphComponent(translation(context)!.p_p_what_are_your_rights__depending_on_where_you_are_located_geographically_the_applicable_privacy_law_may_mean_you_have_certain_rights_regarding_your_personal_information_learn_more_about_your_privacy_rights_),
                ParagraphComponent(translation(context)!.p_p_how_do_you_exercise_your_rights__the_easiest_way_to_exercise_your_rights_is_by_visiting_http___www_listoil_com_contactus_or_by_contacting_us_we_will_consider_and_act_upon_any_request_in_accordance_with_applicable_data_protection_laws_),
                ParagraphComponent(translation(context)!.p_p_want_to_learn_more_about_what_we_do_with_any_information_we_collect__review_the_privacy_notice_in_full_),
                
              ]).render(),
              CompositeComponent(translation(context)!.p_p_table_of_contents, [
                ListComponent([
                  translation(context)!.p_p_1_what_information_do_we_collect_,
                  translation(context)!.p_p_2_how_do_we_process_your_information_,
                  translation(context)!.p_p_3_when_and_with_whom_do_we_share_your_personal_information_,
                  translation(context)!.p_p_4_do_we_use_cookies_and_other_tracking_technologies_,
                  translation(context)!.p_p_5_how_long_do_we_keep_your_information_,
                  translation(context)!.p_p_6_how_do_we_keep_your_information_safe_,
                  translation(context)!.p_p_7_do_we_collect_information_from_minors_,
                  translation(context)!.p_p_8_what_are_your_privacy_rights_,
                  translation(context)!.p_p_9_controls_for_do_not_track_features,
                  translation(context)!.p_p_10_do_california_residents_have_specific_privacy_rights_,
                  translation(context)!.p_p_11_do_we_make_updates_to_this_notice_,
                  translation(context)!.p_p_12_how_can_you_contact_us_about_this_notice_,
                  translation(context)!.p_p_13_how_can_you_review_update_or_delete_the_data_we_collect_from_you_,
                ]),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_1_what_information_do_we_collect_, [
                TitleComponent(translation(context)!.p_p_personal_information_you_disclose_to_us),
                ParagraphComponent(translation(context)!.p_p_in_short_we_collect_personal_information_that_you_provide_to_us_),
                ParagraphComponent(translation(context)!.p_p_we_collect_personal_information_that_you_voluntarily_provide_to_us_when_you_register_on_the_services_express_an_interest_in_obtaining_information_about_us_or_our_products_and_services_when_you_participate_in_activities_on_the_services_or_otherwise_when_you_contact_us_),
                ParagraphComponent(translation(context)!.p_p_personal_information_provided_by_you_the_personal_information_that_we_collect_depends_on_the_context_of_your_interactions_with_us_and_the_services_the_choices_you_make_and_the_products_and_features_you_use_the_personal_information_we_collect_may_include_the_following_),
                ListComponent([
                  translation(context)!.p_p_names_,
                  translation(context)!.p_p_phone_numbers,
                  translation(context)!.p_p_email_addresses,
                  translation(context)!.p_p_mailing_addresses,
                  translation(context)!.p_p_usernames_,
                  translation(context)!.p_p_billing_addresses,
                  translation(context)!.p_p_debit_credit_card_numbers,
                  translation(context)!.p_p_bank_account_numbers,
                  translation(context)!.p_p_aadhar_card,
                  translation(context)!.p_p_pan_card_number,
                ]),
                ParagraphComponent(translation(context)!.p_p_sensitive_information_when_necessary_with_your_consent_or_as_otherwise_permitted_by_applicable_law_we_process_the_following_categories_of_sensitive_information_),
                ListComponent([
                  translation(context)!.p_p_financial_data,
                  translation(context)!.p_p_bank_account_numbers,
                  translation(context)!.p_p_pan_numbers
                ]),
                ParagraphComponent(translation(context)!.p_p_application_data_if_you_use_our_application_s__we_also_may_collect_the_following_information_if_you_choose_to_provide_us_with_access_or_permission_),
                ListComponent([
                  translation(context)!.p_p_geolocation_information_we_may_request_access_or_permission_to_track_location_based_information_from_your_mobile_device_either_continuously_or_while_you_are_using_our_mobile_application_s__to_provide_certain_location_based_services_if_you_wish_to_change_our_access_or_permissions_you_may_do_so_in_your_device_s_settings_,
                  translation(context)!.p_p_mobile_device_access_we_may_request_access_or_permission_to_certain_features_from_your_mobile_device_including_your_mobile_device_s_camera_and_other_features_if_you_wish_to_change_our_access_or_permissions_you_may_do_so_in_your_device_s_settings_,
                  translation(context)!.p_p_mobile_device_data_we_automatically_collect_device_information__such_as_your_mobile_device_id_model_and_manufacturer__operating_system_version_information_and_system_configuration_information_device_and_application_identification_numbers_browser_type_and_version_hardware_model_internet_service_provider_and_or_mobile_carrier_and_internet_protocol__ip__address__or_proxy_server__if_you_are_using_our_application_s__we_may_also_collect_information_about_the_phone_network_associated_with_your_mobile_device_your_mobile_device_s_operating_system_or_platform_the_type_of_mobile_device_you_use_your_mobile_device_s_unique_device_id_and_information_about_the_features_of_our_application_s__you_accessed_,
                  translation(context)!.p_p_push_notifications_we_may_request_to_send_you_push_notifications_regarding_your_account_or_certain_features_of_the_application_s__if_you_wish_to_opt_out_from_receiving_these_types_of_communications_you_may_turn_them_off_in_your_device_s_settings_,

                ]),
                ParagraphComponent(translation(context)!.p_p_this_information_is_primarily_needed_to_maintain_the_security_and_operation_of_our_application_s__for_troubleshooting_and_for_our_internal_analytics_and_reporting_purposes_),
                ParagraphComponent(translation(context)!.p_p_all_personal_information_that_you_provide_to_us_must_be_true_complete_and_accurate_and_you_must_notify_us_of_any_changes_to_such_personal_information_),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_2_how_do_we_process_your_information_, [
                ParagraphComponent(translation(context)!.p_p_in_short_we_process_your_information_to_provide_improve_and_administer_our_services_communicate_with_you_for_security_and_fraud_prevention_and_to_comply_with_law_we_may_also_process_your_information_for_other_purposes_with_your_consent_),
                ParagraphComponent(translation(context)!.p_p_we_process_your_personal_information_for_a_variety_of_reasons_depending_on_how_you_interact_with_our_services_including_),
                ListComponent([
                  translation(context)!.p_p_to_facilitate_account_creation_and_authentication_and_otherwise_manage_user_accounts_we_may_process_your_information_so_you_can_create_and_log_in_to_your_account_as_well_as_keep_your_account_in_working_order_,
                  translation(context)!.p_p_to_deliver_and_facilitate_delivery_of_services_to_the_user_we_may_process_your_information_to_provide_you_with_the_requested_service_,
                  translation(context)!.p_p_to_respond_to_user_inquiries_offer_support_to_users_we_may_process_your_information_to_respond_to_your_inquiries_and_solve_any_potential_issues_you_might_have_with_the_requested_service_,
                  translation(context)!.p_p_to_fulfill_and_manage_your_orders_we_may_process_your_information_to_fulfill_and_manage_your_orders_payments_returns_and_exchanges_made_through_the_services_,
                  translation(context)!.p_p_to_request_feedback_we_may_process_your_information_when_necessary_to_request_feedback_and_to_contact_you_about_your_use_of_our_services_,
                  translation(context)!.p_p_to_send_you_marketing_and_promotional_communications_we_may_process_the_personal_information_you_send_to_us_for_our_marketing_purposes_if_this_is_in_accordance_with_your_marketing_preferences_you_can_opt_out_of_our_marketing_emails_at_any_time_for_more_information_see__what_are_your_privacy_rights__below_,
                  translation(context)!.p_p_to_deliver_targeted_advertising_to_you_we_may_process_your_information_to_develop_and_display_personalized_content_and_advertising_tailored_to_your_interests_location_and_more_,
                  translation(context)!.p_p_to_administer_prize_draws_and_competitions_we_may_process_your_information_to_administer_prize_draws_and_competitions_,
                  translation(context)!.p_p_to_evaluate_and_improve_our_services_products_marketing_and_your_experience_we_may_process_your_information_when_we_believe_it_is_necessary_to_identify_usage_trends_determine_the_effectiveness_of_our_promotional_campaigns_and_to_evaluate_and_improve_our_services_products_marketing_and_your_experience_,
                  translation(context)!.p_p_to_identify_usage_trends_we_may_process_information_about_how_you_use_our_services_to_better_understand_how_they_are_being_used_so_we_can_improve_them_,
                  translation(context)!.p_p_to_determine_the_effectiveness_of_our_marketing_and_promotional_campaigns_we_may_process_your_information_to_better_understand_how_to_provide_marketing_and_promotional_campaigns_that_are_most_relevant_to_you_,
                  translation(context)!.p_p_to_comply_with_our_legal_obligations_we_may_process_your_information_to_comply_with_our_legal_obligations_respond_to_legal_requests_and_exercise_establish_or_defend_our_legal_rights_,
                ]),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_3_when_and_with_whom_do_we_share_your_personal_information_, [
                ParagraphComponent(translation(context)!.p_p_in_short_we_may_share_information_in_specific_situations_described_in_this_section_and_or_with_the_following_third_parties_),
                ParagraphComponent(translation(context)!.p_p_we_may_need_to_share_your_personal_information_in_the_following_situations_),
                ListComponent([
                  translation(context)!.p_p_business_transfers_we_may_share_or_transfer_your_information_in_connection_with_or_during_negotiations_of_any_merger_sale_of_company_assets_financing_or_acquisition_of_all_or_a_portion_of_our_business_to_another_company_,
                  translation(context)!.p_p_when_we_use_google_maps_platform_apis_we_may_share_your_information_with_certain_google_maps_platform_apis__e_g__google_maps_api_places_api__we_obtain_and_store_on_your_device___cache___your_location_you_may_revoke_your_consent_anytime_by_contacting_us_at_the_contact_details_provided_at_the_end_of_this_document_,

                ]),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_4_do_we_use_cookies_and_other_tracking_technologies_, [
                ParagraphComponent(translation(context)!.p_p_in_short_we_may_use_cookies_and_other_tracking_technologies_to_collect_and_store_your_information_),
                ParagraphComponent(translation(context)!.p_p_we_may_use_cookies_and_similar_tracking_technologies__like_web_beacons_and_pixels__to_access_or_store_information_specific_information_about_how_we_use_such_technologies_and_how_you_can_refuse_certain_cookies_is_set_out_in_our_cookie_notice_),

              ]).render(),
              CompositeComponent(translation(context)!.p_p_5_how_long_do_we_keep_your_information_, [
                ParagraphComponent(translation(context)!.p_p_in_short_we_keep_your_information_for_as_long_as_necessary_to_fulfill_the_purposes_outlined_in_this_privacy_notice_unless_otherwise_required_by_law_),
                ParagraphComponent(translation(context)!.p_p_we_will_only_keep_your_personal_information_for_as_long_as_it_is_necessary_for_the_purposes_set_out_in_this_privacy_notice_unless_a_longer_retention_period_is_required_or_permitted_by_law__such_as_tax_accounting_or_other_legal_requirements__no_purpose_in_this_notice_will_require_us_keeping_your_personal_information_for_longer_than_three__3__months_past_the_termination_of_the_user_s_account_),
                ParagraphComponent(translation(context)!.p_p_when_we_have_no_ongoing_legitimate_business_need_to_process_your_personal_information_we_will_either_delete_or_anonymize_such_information_or_if_this_is_not_possible__for_example_because_your_personal_information_has_been_stored_in_backup_archives__then_we_will_securely_store_your_personal_information_and_isolate_it_from_any_further_processing_until_deletion_is_possible_),

              ]).render(),
              CompositeComponent(translation(context)!.p_p_6_how_do_we_keep_your_information_safe_, [
                ParagraphComponent(translation(context)!.p_p_in_short_we_aim_to_protect_your_personal_information_through_a_system_of_organizational_and_technical_security_measures_),
                ParagraphComponent(translation(context)!.p_p_we_have_implemented_appropriate_and_reasonable_technical_and_organizational_security_measures_designed_to_protect_the_security_of_any_personal_information_we_process_however_despite_our_safeguards_and_efforts_to_secure_your_information_no_electronic_transmission_over_the_internet_or_information_storage_technology_can_be_guaranteed_to_be_100__secure_so_we_cannot_promise_or_guarantee_that_hackers_cybercriminals_or_other_unauthorized_third_parties_will_not_be_able_to_defeat_our_security_and_improperly_collect_access_steal_or_modify_your_information_although_we_will_do_our_best_to_protect_your_personal_information_transmission_of_personal_information_to_and_from_our_services_is_at_your_own_risk_you_should_only_access_the_services_within_a_secure_environment_),

              ]).render(),
              CompositeComponent(translation(context)!.p_p_7_do_we_collect_information_from_minors_, [
                ParagraphComponent(translation(context)!.p_p_in_short_we_do_not_knowingly_collect_data_from_or_market_to_children_under_18_years_of_age_),
                ParagraphComponent(translation(context)!.p_p_we_do_not_knowingly_solicit_data_from_or_market_to_children_under_18_years_of_age_by_using_the_services_you_represent_that_you_are_at_least_18_or_that_you_are_the_parent_or_guardian_of_such_a_minor_and_consent_to_such_minor_dependent_s_use_of_the_services_if_we_learn_that_personal_information_from_users_less_than_18_years_of_age_has_been_collected_we_will_deactivate_the_account_and_take_reasonable_measures_to_promptly_delete_such_data_from_our_records_if_you_become_aware_of_any_data_we_may_have_collected_from_children_under_age_18_please_contact_us_at_vsharma_listoil_com_),

              ]).render(),
              CompositeComponent(translation(context)!.p_p_8_what_are_your_privacy_rights_, [
                ParagraphComponent(translation(context)!.p_p_in_short__you_may_review_change_or_terminate_your_account_at_any_time_),
                ParagraphComponent(translation(context)!.p_p_if_you_are_located_in_the_eea_or_uk_and_you_believe_we_are_unlawfully_processing_your_personal_information_you_also_have_the_right_to_complain_to_your_member_state_data_protection_authority_or_uk_data_protection_authority_),
                ParagraphComponent(translation(context)!.p_p_if_you_are_located_in_switzerland_you_may_contact_the_federal_data_protection_and_information_commissioner_),
                ParagraphComponent(translation(context)!.p_p_withdrawing_your_consent_if_we_are_relying_on_your_consent_to_process_your_personal_information_which_may_be_express_and_or_implied_consent_depending_on_the_applicable_law_you_have_the_right_to_withdraw_your_consent_at_any_time_you_can_withdraw_your_consent_at_any_time_by_contacting_us_by_using_the_contact_details_provided_in_the_section__how_can_you_contact_us_about_this_notice__below_),
                ParagraphComponent(translation(context)!.p_p_however_please_note_that_this_will_not_affect_the_lawfulness_of_the_processing_before_its_withdrawal_nor_when_applicable_law_allows_will_it_affect_the_processing_of_your_personal_information_conducted_in_reliance_on_lawful_processing_grounds_other_than_consent_),
                ParagraphComponent(translation(context)!.p_p_opting_out_of_marketing_and_promotional_communications_you_can_unsubscribe_from_our_marketing_and_promotional_communications_at_any_time_by_clicking_on_the_unsubscribe_link_in_the_emails_that_we_send_or_by_contacting_us_using_the_details_provided_in_the_section__how_can_you_contact_us_about_this_notice__below_you_will_then_be_removed_from_the_marketing_lists_however_we_may_still_communicate_with_you__for_example_to_send_you_service_related_messages_that_are_necessary_for_the_administration_and_use_of_your_account_to_respond_to_service_requests_or_for_other_non_marketing_purposes_),
                TitleComponent(translation(context)!.p_p_account_information),
                ParagraphComponent(translation(context)!.p_p_if_you_would_at_any_time_like_to_review_or_change_the_information_in_your_account_or_terminate_your_account_you_can_),
                ListComponent([
                  translation(context)!.p_p_contact_us_using_the_contact_information_provided_,
                ]),
                ParagraphComponent(translation(context)!.p_p_upon_your_request_to_terminate_your_account_we_will_deactivate_or_delete_your_account_and_information_from_our_active_databases_however_we_may_retain_some_information_in_our_files_to_prevent_fraud_troubleshoot_problems_assist_with_any_investigations_enforce_our_legal_terms_and_or_comply_with_applicable_legal_requirements_),
                ParagraphComponent(translation(context)!.p_p_cookies_and_similar_technologies_most_web_browsers_are_set_to_accept_cookies_by_default_if_you_prefer_you_can_usually_choose_to_set_your_browser_to_remove_cookies_and_to_reject_cookies_if_you_choose_to_remove_cookies_or_reject_cookies_this_could_affect_certain_features_or_services_of_our_services_you_may_also_opt_out_of_interest_based_advertising_by_advertisers_on_our_services_),
                ParagraphComponent(translation(context)!.p_p_if_you_have_questions_or_comments_about_your_privacy_rights_you_may_email_us_at_vsharma_listoil_com_),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_9_controls_for_do_not_track_features, [
                ParagraphComponent(translation(context)!.p_p_most_web_browsers_and_some_mobile_operating_systems_and_mobile_applications_include_a_do_not_track___dnt___feature_or_setting_you_can_activate_to_signal_your_privacy_preference_not_to_have_data_about_your_online_browsing_activities_monitored_and_collected_at_this_stage_no_uniform_technology_standard_for_recognizing_and_implementing_dnt_signals_has_been_finalized_as_such_we_do_not_currently_respond_to_dnt_browser_signals_or_any_other_mechanism_that_automatically_communicates_your_choice_not_to_be_tracked_online_if_a_standard_for_online_tracking_is_adopted_that_we_must_follow_in_the_future_we_will_inform_you_about_that_practice_in_a_revised_version_of_this_privacy_notice_),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_10_do_california_residents_have_specific_privacy_rights_, [
                ParagraphComponent(translation(context)!.p_p_in_short_yes_if_you_are_a_resident_of_california_you_are_granted_specific_rights_regarding_access_to_your_personal_information_),
                ParagraphComponent(translation(context)!.p_p_california_civil_code_section_1798_83_also_known_as_the__shine_the_light_law_permits_our_users_who_are_california_residents_to_request_and_obtain_from_us_once_a_year_and_free_of_charge_information_about_categories_of_personal_information__if_any__we_disclosed_to_third_parties_for_direct_marketing_purposes_and_the_names_and_addresses_of_all_third_parties_with_which_we_shared_personal_information_in_the_immediately_preceding_calendar_year_if_you_are_a_california_resident_and_would_like_to_make_such_a_request_please_submit_your_request_in_writing_to_us_using_the_contact_information_provided_below_),
                ParagraphComponent(translation(context)!.p_p_if_you_are_under_18_years_of_age_reside_in_california_and_have_a_registered_account_with_services_you_have_the_right_to_request_removal_of_unwanted_data_that_you_publicly_post_on_the_services_to_request_removal_of_such_data_please_contact_us_using_the_contact_information_provided_below_and_include_the_email_address_associated_with_your_account_and_a_statement_that_you_reside_in_california_we_will_make_sure_the_data_is_not_publicly_displayed_on_the_services_but_please_be_aware_that_the_data_may_not_be_completely_or_comprehensively_removed_from_all_our_systems__e_g__backups_etc___),

              ]).render(),
              CompositeComponent(translation(context)!.p_p_11_do_we_make_updates_to_this_notice_, [
                ParagraphComponent(translation(context)!.p_p_in_short_yes_we_will_update_this_notice_as_necessary_to_stay_compliant_with_relevant_laws_),
                ParagraphComponent(translation(context)!.p_p_we_may_update_this_privacy_notice_from_time_to_time_the_updated_version_will_be_indicated_by_an_updated__revised_date_and_the_updated_version_will_be_effective_as_soon_as_it_is_accessible_if_we_make_material_changes_to_this_privacy_notice_we_may_notify_you_either_by_prominently_posting_a_notice_of_such_changes_or_by_directly_sending_you_a_notification_we_encourage_you_to_review_this_privacy_notice_frequently_to_be_informed_of_how_we_are_protecting_your_information_),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_12_how_can_you_contact_us_about_this_notice_, [
                ParagraphComponent(translation(context)!.p_p_if_you_have_questions_or_comments_about_this_notice_you_may_contact_our_data_protection_officer__dpo__vatsal_sharma_by_email_at_vsharma_listoil_com_by_phone_at__918619219450_or_contact_us_by_post_at_),
                ParagraphComponent(translation(context)!.p_p_vistony_india_private_limited),
                ParagraphComponent(translation(context)!.p_p_vatsal_sharma),
                ParagraphComponent(translation(context)!.p_p_f647_f647a_kushkera_industrial_area_riico_bhiwadi_),
                ParagraphComponent(translation(context)!.p_p_alwar_301707_rajasthan_india),
                ParagraphComponent(translation(context)!.p_p_bhiwadi_rajasthan_301707),
                ParagraphComponent(translation(context)!.p_p_india_),
              ]).render(),
              CompositeComponent(translation(context)!.p_p_13_how_can_you_review_update_or_delete_the_data_we_collect_from_you_, [
                ParagraphComponent(translation(context)!.p_p_based_on_the_applicable_laws_of_your_country_you_may_have_the_right_to_request_access_to_the_personal_information_we_collect_from_you_change_that_information_or_delete_it_to_request_to_review_update_or_delete_your_personal_information_please_visit_http___www_listoil_com_contactus_),
              ]).render(),
            ],
          ),
        ),
      ),
    );
  }
}
