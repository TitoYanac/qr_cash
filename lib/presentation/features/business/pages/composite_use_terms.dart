import 'package:flutter/material.dart';
import 'package:qr_save_scan/presentation/widgets/atoms/list_component.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../widgets/atoms/paragraph_component.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';

class CompositeUseTerms extends StatelessWidget {
  const CompositeUseTerms({super.key});

  @override
  Widget build(BuildContext context) {
    final traductor = translation(context)!;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: translation(context)!.terms_of_use,
              leading: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  ParagraphComponent(traductor.t_c_1_use_of_the_qr_save_scan_app_will_be_governed_by_the_terms_and_conditions_contained_herein_below_each_user_agrees_that_he_she_has_read_and_understood_the_t_cs_and_each_user_agrees_to_be_bound_by_the_t_cs),
                  ParagraphComponent(traductor.t_c_2_the_qr_save_scan_app_has_been_designed_for_scanning_qr_coupons_located_inside_the_cap_of_the_pack_in_addition_the_app_could_also_be_used_to_run_other_marketing_promos),
                  ParagraphComponent(traductor.t_c_3_vistony_india_private_limited_listoil_does_not_guarantee_that_the_qr_save_scan_app_is_perfect_or_free_from_faults_or_that_the_information_contained_is_completely_accurate_participants_are_encouraged_to_visit_our_website_for_updated_customer_care_information_although_we_make_reasonable_efforts_to_update_the_information_provided_by_the_qr_save_scan_app_we_make_no_representations_warranties_or_guarantees_whether_expressed_or_implied_that_such_information_is_accurate_complete_or_up_to_date_qr_save_scan_app_and_the_services_have_not_been_developed_to_meet_your_requirements_please_check_that_the_facilities_and_functions_of_qr_save_scan_meet_your_requirements),
                  ParagraphComponent(traductor.t_c_4_access_to_the_qr_save_scan_app),
                  ParagraphComponent(traductor.t_c_by_accessing_and_using_this_app_the_user_represents_warrants_and_agrees_that),
                  ListComponent(children: [
                    traductor.t_c_a_the_user_is_a_resident_of_india_is_above_the_age_of_18_and_is_competent_to_contract,
                    traductor.t_c_b_the_user_can_create_a_binding_legal_obligation,
                    traductor.t_c_c_the_user_is_not_barred_from_receiving_products_or_services_under_applicable_law,
                    traductor.t_c_d_the_use_of_the_qr_save_scan_app_will_at_all_times_comply_with_these_terms_and_conditions,
                    traductor.t_c_e_the_user_shall_provide_any_information_as_is_required_and_all_such_information_is_accurate_true_current_and_complete,
                    traductor.t_c_f_certain_details_like_location_address_and_pin_code_will_be_captured_by_listoil_through_the_qr_save_scan_application_using_a_global_positioning_system_gps_tracker_and_such_locational_details_are_a_prerequisite_for_the_user_to_commence_using_the_qr_save_scan_application_the_user_consents_and_permits_listoil_to_capture_such_locational_details_as_and_when_the_user_logs_onto_the_qr_save_scan_application_the_user_understands_and_agrees_that_if_such_details_are_not_procured_or_the_user_does_not_permit_the_gps_tracker_to_access_their_locational_details_the_user_will_not_be_able_to_access_and_use_the_qr_save_scan_application_any_user_may_decide_to_remove_such_consent_it_is_also_understood_that_in_case_consent_is_removed_certain_functionalities_of_the_app_may_not_be_available,
                    traductor.t_c_g_the_user_will_update_the_correct_information_and_ensure_that_it_is_accurate_at_all_times,
                    traductor.t_c_h_this_shall_constitute_permission_and_consent_for_listoil_and_its_affiliates_to_store_in_its_database_and_also_use_the_user_s_name_telephone_numbers_e_mail_ids_personal_sensitive_information_like_bank_account_details_and_ifsc_codes_permanent_account_number_add_a_card_number_and_other_details_and_information_personal_information___without_any___additional_compensation_whatsoever,
                    traductor.t_c_i_this_shall_also_constitute_permission_for_listoil_to_share_the_personal_information_with_its_affiliates_and_also_with_standard_chartered_bank_and_or_any_new_banking_partner_third_party_payment_bank_that_it_may_tie_up_with_from_time_to_time_to_facilitate_transfer_of_funds_to_the_user_bank_account,
                    traductor.t_c_j_the_user_shall_bear_all_the_risks_of_the_banking_channels_and_the_risk_of_listoil_sharing_personal_information_to_the_banks_and_other_third_party_payment_providers_subject_to_reasonable_standard_measures_adopted_by_the_banks_and_such_third_party_service_providers_to_ensure_the_security_of_such_channels,
                    traductor.t_c_k_downloading_the_qr_save_scan_app_shall_be_deemed_to_be_consent_by_the_user_to_receive_promotional_messages_about_the_app_and_listoil_or_any_third_party_so_authorised_by_listoil,
                    traductor.t_c_l_users_shall_not_reverse_engineer_tamper_or_misuse_the_app_while_downloading_installing_or_functioning_the_app_in_any_manner,
                  ]),
                  ParagraphComponent(traductor.t_c_5_usage_of_the_qr_save_scan_app),
                  ParagraphComponent(traductor.t_c_the_purpose_of_the_app_is_to_scan_qr_coupons_which_are_available_inside_certain_packs),
                  ParagraphComponent(traductor.t_c_the_app_will_function_as_follows),
                  ListComponent(children: [

                    traductor.t_c_a_users_register_themselves_on_the_app_by_providing_their_mobile_numbers_an_otp_is_sent_to_the_mobile_number_and_the_user_sets_a_password_post_which_the_user_is_registered_for_using_the_app,
                    traductor.t_c_b_the_user_then_scans_the_qr_code_located_inside_the_cap_of_the_pack_in_case_coupons_are_not_getting_scanned_the_user_can_manually_enter_the_12_digit_code_mentioned_on_the_coupon,
                    traductor.t_c_c_scan_results_will_indicate_the_validity_of_a_qr_code_valid_qr_codes_are_those_codes_that_are_scanned_for_the_first_time_before_the_date_of_expiry,
                    traductor.t_c_d_only_valid_qr_codes_are_eligible_for_redemption,
                    traductor.t_c_e_users_will_be_able_to_view_a_summary_of_all_coupons_scanned,
                    traductor.t_c_f_if_the_user_has_entered_his_her_bank_account_information_and_provided_the_other_personal___information_funds_will_be_automatically_transferred_to_the_bank_account_so_provided_by_the_user_after_validation_of_the_code_listoil_and_or_its_affiliates_shall_not_be_responsible_for_verifying_or_validating_the_authenticity_of_the_information_so_provided_by_the_user_and_shall_not_be_responsible_for_any_crediting_transferring_the_funds_to_an_account_where_wrong_details_have_been_provided_by_the_user,

                  ]),
                  ParagraphComponent(traductor.t_c_6_users_may_be_barred_from_using_the_qr_save_scan_app_in_case_of_misuse_listoil_shall_have_sole_discretion_in_barring_such_users),
                  ParagraphComponent(traductor.t_c_7_to_provide_our_products_and_services_we_may_however_need_to_share_your_personal_information_with_other_companies_within_listoil_and_or_third_party_service_providers_that_process_data_on_our_behalf_since_listoil_operates_globally_castrol_may_receive_the_information_in_other_jurisdictions_or_want_to_transfer_your_personal_information_to_other_countries_including_countries_outside_india_we_reserve_the_right_to_disclose_your_personal_information_as_required_by_law_or_when_we_believe_that_disclosure_is_necessary_to_protect_our_rights_and_or_comply_with_a_judicial_proceeding_court_order_request_from_a_regulator_or_any_other_legal_process_served_on_listoil_if_listoil_is_subject_to_a_takeover_divestment_or_acquisition_we_may_disclose_your_personal_information_to_the_new_owner_of_the_business),
                  ParagraphComponent(traductor.t_c_8_intellectual_property_rights),
                  ParagraphComponent(traductor.t_c_all_intellectual_property_rights_in_qr_save_scan_throughout_the_world_belong_to_us_and_the_rights_in_qr_save_scan_app_you_shall_not_claim_or_impair_in_any_manner_the_intellectual_property_rights_in_or_to_the_qr_save_scan_app_other_than_the_right_to_use_the_qr_save_scan_app_by_these_terms),
                  ParagraphComponent(traductor.t_c_9_you_must),
                  ListComponent(children: [
                    traductor.t_c_a_not_use_the_qr_save_scan_app_in_any_unlawful_manner_for_any_unlawful_purpose_or_in_any_manner_inconsistent_with_these_terms_or_act_fraudulently_or_maliciously_for_example_by_hacking_into_or_inserting_malicious_code_such_as_viruses_or_harmful_data_into_qr_save_scan_app_or_any_operating_system,
                    traductor.t_c_b_do_not_infringe_our_intellectual_property_rights_or_those_of_any_third_party_about_your_use_of_the_qr_save_scan_app,
                    traductor.t_c_c_not_use_the_qr_save_scan_app_or_any_service_in_a_way_that_could_damage_disable_overburden_impair_or_compromise_our_systems_or_security_or_interfere_with_other_users,
                    traductor.t_c_d_not_collect_or_harvest_any_information_or_data_from_our_systems_or_attempt_to_decipher_any_transmissions_to_or_from_the_servers_running_the_qr_save_scan_app,
                  ]),
                  ParagraphComponent(traductor.t_c_10_you_must_keep_your_account_details_safe),
                  ParagraphComponent(traductor.t_c_if_you_are_provided_with_a_user_identification_code_password_or_any_other_piece_of_information_as_part_of_our_security_procedures_you_must_treat_such_information_as_confidential_you_must_not_disclose_it_to_any_third_party_including_but_not_limited_to_those_individuals_in_your_own_company_listoil_has_the_right_to_disable_any_user_identification_code_or_password_whether_chosen_by_you_or_allocated_by_us_at_any_time_if_in_our_reasonable_opinion_you_have_failed_to_comply_with_any_of_the_provisions_of_these_terms_of_use),
                  ParagraphComponent(traductor.t_c_if_you_know_or_suspect_that_anyone_other_than_you_knows_your_user_identification_code_or_password_you_must_promptly_notify_us_you_can_refer_to_our_website_for_details_of_our_customer_care),
                  ParagraphComponent(traductor.t_c_11_the_users_shall_not_bring_any_action_claim_damages_or_other_proceedings_against_listoil_its_directors_agents_employees_licensees_or_assigns_affiliates_or_persons_associated_with_listoil_in_the_event_of_suffering_any_injury_or_losses_or_any_damage_being_caused_on_account_of_usage_of_the_qr_save_scan_app),
                  ParagraphComponent(traductor.t_c_12_you_agree_that_you_will),
                  ListComponent(children: [
                    traductor.t_c_a_not_rent_lease_sub_license_loan_provide_or_otherwise_make_available_the_qr_save_scan_app_in_any_form_in_whole_or_in_part_to_any_person_without_prior_written_consent_from_us,
                    traductor.t_c_b_do_not_copy_the_qr_save_scan_app,
                    traductor.t_c_c_not_translate_merge_adapt_vary_alter_or_modify_the_whole_or_any_part_of_the_qr_save_scan_app_nor_permit_the_qr_save_scan_app_or_any_part_of_it_to_be_combined_with_or_become_incorporated_in_any_other_programs,
                    traductor.t_c_d_not__disassemble_de_compile_reverse_engineer_or_create_derivative_works_based_on_the_whole_or_any_part_of_qr_save_scan_nor_attempt_to_do_any_such_things,
                    traductor.t_c_e_comply_with_all_applicable_technology_control_or_export_laws_and_regulations_that_apply_to_the_technology_used_or_supported_by_the_qr_save_scan_app_or_any_service,
                  ]),
                  ParagraphComponent(traductor.t_c_13_we_are_not_responsible_for_viruses_and_you_must_not_introduce_them),
                  ListComponent(children: [

                    traductor.t_c_a_we_do_not_guarantee_that_the_qr_save_scan_app_will_be_secure_or_free_from_bugs_or_viruses,
                    traductor.t_c_b_you_are_responsible_for_configuring_your_information_technology_computer_programmes_and_platform_to_access_the_qr_save_scan_app_you_should_use_your_virus_protection_software,
                    traductor.t_c_c_you_must_not_misuse_our_site_by_knowingly_introducing_viruses_trojans_worms_logic_bombs_or_other_material_that_is_malicious_or_technologically_harmful,

                  ]),
                  ParagraphComponent(traductor.t_c_14_listoil_reserves_at_any_time_the_right_to_refuse_reimbursement_to_a_user_whom_listoil_decides_in_its_sole_discretion),
                  ListComponent(children: [
                    traductor.t_c_a_has_violated_the_terms_and_conditions_including_but_not_limited_to_gaining_an_unfair_advantage_in_scanning_using_fraudulent_means,
                    traductor.t_c_b_has_scanned_duplicate_coupons,
                    traductor.t_c_c_has_scanned_expired_coupons_listoil_also_reserves_the_right_at_any_time_to_verify_the_validity_of_submissions_made_by_the_users,

                  ]),
                  ParagraphComponent(traductor.t_c_15_update_to_qr_save_scan_app_and_changes_to_the_service),
                  ParagraphComponent(traductor.t_c_from_time_to_time_we_may_automatically_update_the_qr_save_scan_app_and_change_the_service_to_improve_performance_enhance_functionality_reflect_changes_to_the_operating_system_or_address_security_issues_alternatively_we_may_ask_you_to_update_the_qr_save_scan_for_these_reasons_if_you_choose_not_to_install_such_updates_or_if_you_opt_out_of_automatic_updates_you_may_not_be_able_to_continue_using_qr_save_scan_and_the_services_listoil_shall_not_be_liable_for_any_cost_incurred_by_the_user_for_downloading_the_app_or_regular_usage_of_the_app),
                  ParagraphComponent(traductor.t_c_16_we_may_collect_technical_data_about_your_device),
                  ListComponent(children: [
                    traductor.t_c_a_by_using_the_qr_save_scan_app_or_any_of_the_services_you_permit_listoil_and_its_affiliates_to_collect_and_use_technical_information_about_the_devices_you_operate_the_qr_save_scan_app_on_and_the_related_software_hardware_and_peripherals_to_improve_our_products_and_to_provide_any_services_to_you,
                    traductor.t_c_b_all_user_personal_details_must_be_valid_and_up_to_date_and_will_be_held_by_listoil_and_may_be_used_for_the_app_and_future_promotion_and_marketing_purposes_by_listoil_privacy_policy_see_https_www_castrol_com_en_in_india_privacy_statement_html_unless_otherwise_directed_by_users_at_the_time_of_using_the_app,
                  ]),
                  ParagraphComponent(traductor.t_c_17_the_user_shall_not_assign_these_t_cs_or_any_rights_benefits_or_obligations_hereunder_without_the_express_written_permission_of_listoil_any_attempted_assignment_that_does_not_comply_with_these_t_cs_shall_be_null_and_void_listoil_may_assign_these_t_cs_in_whole_or_in_part_to_any_third_party_at_its_sole_discretion),
                  ParagraphComponent(traductor.t_c_18_the_t_cs_and_other_terms_incorporated_by_reference_constitute_the_entire_agreement_and_understanding_between_the_user_and_listoil_concerning_the_subject_matter_hereof_and_supersedes_all_prior_or_contemporaneous_communications_and_proposals_whether_oral_or_written_between_the_user_and_listoil_concerning_such_subject_matter),
                  ParagraphComponent(traductor.t_c_19_listoil_always_reserves_its_right_to_modify_any_part_of_these_t_cs_at_its_sole_discretion_the_user_agrees_to_revisit_the_t_cs_regularly_to_ensure_that_they_stay_informed_of_any_changes_the_user_s_continued_use_of_the_services_after_any_update_to_the_t_cs_will_constitute_acceptance_of_the_modified_t_cs),
                  ParagraphComponent(traductor.t_c_20_in_the_event_of_any_inconsistency_between_these_t_cs_and_any_other_materials_documents_or_writings_relating_to_or_in_connection_with_the_app_these_t_cs_shall_prevail),
                  ParagraphComponent(traductor.t_c_21_the_failure_of_qr_save_scan_at_any_time_to_require_observance_or_performance_by_the_user_of_any_of_the_provisions_of_these_t_c_shall_in_no_way_affect_listoil_s_right_to_require_such_observance_of_performance_at_any_time_thereafter_nor_shall_the_waiver_by_listoil_of_a_breach_of_any_provision_hereof_by_the_user_be_taken_or_held_to_be_a_waiver_of_any_succeeding_breach_of_such_provision_a_waiver_of_any_of_the_provisions_herein_by_listoil_shall_not_be_deemed_to_be_a_continuing_waiver_but_shall_apply_solely_to_the_instances_to_which_the_waiver_is_directed),
                  ParagraphComponent(traductor.t_c_22_listoil_shall_be_excused_from_performance_under_these_t_cs_to_the_extent_it_is_prevented_or_delayed_from_performing_in_whole_or_in_part_as_a_result_of_an_event_or_series_of_events_caused_by_or_resulting_from_a_acts_of_god_b_acts_of_war_acts_of_terrorism_insurrection_riots_civil_disorders_or_rebellion_c_quarantines_or_embargoes_d_labor_strikes_e_error_or_disruption_to_computer_hardware_or_networks_or_software_failures_or_g_any_other_causes_whether_similar_or_dissimilar_beyond_the_reasonable_control_of_listoil),
                  ParagraphComponent(traductor.t_c_23_in_no_event_shall_listoil_its_promoters_licensees_affiliates_subsidiaries_group_companies_as_applicable_and_their_respective___officers_directors_agents_and_employees_be_liable_for_any_direct_indirect___incidental___special_consequential_or_punitive_damages_arising_out_of_or_related_to_a_the_user_s_use_of_or_reliance_upon_the_application_and_any_other_content_or_information_contained_in_the_application_b_the_user_s_inability_to_use_the_application_d_the_quality_quantity_merchantability_or_performance_or_any_product_or_service_we_exclude_all_implied_conditions_warranties_representations_or_other_terms_that_may_apply_to_our_site_or_any_content_on_it),
                  ParagraphComponent(traductor.t_c_24_every_obligation_under_these_t_cs_shall_be_treated_as_a_separate_obligation_and_shall_be_severely_enforceable_as_such_and_in_the_event_of_any_obligation_or_obligations_being_or_becoming_unenforceable_in_whole_or_in_part_to_the_extent_that_any_provision_or_provisions_of_these_t_cs_are_unenforceable_listoil_may_amend_such_clauses_as_may_be_necessary_to_make_the_provision_valid_and_effective_notwithstanding_the_foregoing_any_provision_which_cannot_be_amended_as_may_be_necessary_to_make_it_valid_and_effective_may_be_deleted_by_listoil_from_these_t_cs_and_any_such_deletion_shall_not_affect_the_enforceability_of_the_remainder_of_these_terms),
                  ParagraphComponent(traductor.t_c_25_listoil_may_terminate_your_access_to_the_app_if),
                  ParagraphComponent(traductor.t_c_listoil_is_required_to_do_so_by_law_for_example_where_the_access_to_and_or_provision_of_the_app_to_you_becomes_unlawful_or),
                  ParagraphComponent(traductor.t_c_the_provision_of_the_app_to_you_is_no_longer_commercially_viable_or_feasible_for_us_or),
                  ParagraphComponent(traductor.t_c_listoil_otherwise_reasonably_believes_you_have_misused_the_app_or_any_of_its_services_or_for_any_other_reason_in_our_sole_discretion_or),
                  ParagraphComponent(traductor.t_c_user_breaches_this_agreement),
                  ParagraphComponent(traductor.t_c_26_listoil_may_terminate_this_agreement_at_any_time_with_or_without_notice_and_may_disable_user_access_to_the_app_and_or_bar_you_from_any_future_use_of_the_app),
                  ParagraphComponent(traductor.t_c_27_upon_termination_of_this_agreement_all_of_the_legal_rights_obligations_and_liabilities_that_the_user_and_listoil_have_benefited_from_been_subject_to_or_which_have_accrued_over_time_whilst_the_agreement_has_been_in_force_or_which_are_expressed_to_continue_indefinitely_shall_be_unaffected_by_this_cessation_and_shall_continue_to_apply_to_such_rights_obligations_and_liabilities_indefinitely),
                  ParagraphComponent(traductor.t_c_28_any_dispute_about_the_qr_save_scan_app_will_be_subject_to_the_jurisdiction_of_competent_courts_in_delhi_only),
                  ParagraphComponent(traductor.t_c_29_in_the_event_of_any_dispute_or_difference_between_the_user_and_listoil_arising_out_or_in_any_way_relating_to_these_t_cs_the_same_shall_be_referred_to_arbitration_to_be_conducted_by_a_sole_arbitrator_appointed_by_listoil_the_arbitration_proceedings_shall_be_conducted_in_delhi_by_the_provisions_of_the_arbitration_conciliation_act_1996),
                  ParagraphComponent(traductor.t_c_27_we_will_not_allow_to_access_this_app_from_any_rooted_device),
                  ParagraphComponent(traductor.t_c_users_are_expected_to_download_and_use_the_application_on_their_smartphones_with_a_standard_android_operating_system_only_any_deviation_from_the_above_or_use_of_specialised_devices_for_accessing_the_application_is_not_permissible_the_user_is_solely_responsible_for_any_actions_or_losses_incurred_due_to_any_non_permissible_use_of_the_application_as_stated_herein_and_listoil_will_not_be_held_responsible_or_accountable_for_any_such_deviation),

                ]

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
