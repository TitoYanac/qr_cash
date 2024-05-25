import 'package:flutter/material.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../widgets/atoms/list_component.dart';
import '../../../widgets/atoms/paragraph_component.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';

class CompositeTermsAndConditionsScreen extends StatelessWidget {
  const CompositeTermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final traductor = translation(context)!;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: traductor.terms_and_conditions,
              leading: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ParagraphComponent(traductor.t_c_1_program_this_program_is_a_qr_code_scanning_based_points_accumulation_program_for_the_public_each_a_participant_as_determined_by_listoil_under_which_program_the_participants_get_rewards_on_scanning_of_qr_codes_available_on_the_goods_purchased_from_of_listoil_and_shall_be_called_the_qr_save_scan_program_program_these_terms_and_conditions_also_set_out_in_detail_the_information_that_a_user_will_be_required_to_provide_to_use_the_app_and_how_such_information_will_be_processed_by_listoil_please_read_through_these_terms_and_conditions_in_detail_for_better_understanding),
                    ParagraphComponent(traductor
                        .t_c_2_this_offer_entitles_the_end_user_to_cashback_on_their_bank_account_or_upi_the_customer_will_be_responsible_for_their_choice_of_the_cashback_transfer_method_the_denomination_of_the_cashback_will_be_mentioned_on_the_voucher_scratch_card),
                    ParagraphComponent(traductor
                        .t_c_3_any_consumer_purchasing_a_promotional_product_shall_be_eligible_to_receive_a_voucher_inside_the_pack_the_customer_shall_receive_a_cashback_of_an_amount_equivalent_to_the_value_as_mentioned_in_the_voucher_cashback_voucher_amount),
                    ParagraphComponent(traductor
                        .t_c_4_by_redeeming_the_offer_provided_on_the_same_a_participant_agrees_to_be_bound_by_the_terms_and_conditions_below_conditions),
                    ParagraphComponent(traductor
                        .t_c_5_application_each_participant_is_required_to_install_and_use_the_qr_save_scan_app_listoil_s_qr_save_scan_app_app_will_be_used_for_the_program_and_the_terms_of_use_of_the_app_are_given_below_these_t_cs_each_participant_shall_be_deemed_to_have_accepted_the_terms_of_use_for_the_app_and_to_the_extent_required_the_same_terms_will_be_deemed_to_have_been_incorporated_into_these_t_cs_as_well),
                    ParagraphComponent(traductor
                        .t_c_6_entire_agreement_this_program_will_be_governed_by_the_terms_and_conditions_t_cs_contained_herein_below_these_t_cs_contain_the_entire_agreement_between_a_participant_and_listoil_listoil_reserves_a_right_to_amend_these_t_cs_at_any_time_in_its_sole_discretion_without_any_notice_and_or_reason_the_decision_of_listoil_shall_be_final_and_binding_in_all_matters_relating_to_the_program_each_participant_is_required_to_frequently_visit_the_app_and_read_these_t_cs_to_understand_any_updates),
                    ParagraphComponent(traductor
                        .t_c_7_organizer_the_organizer_of_the_program_is_vistony_india_private_limited_listoil_listoil_may_from_time_to_time_appoint_independent_third_party_service_providers_to_operate_the_program_and_or_receive_any_services_related_to_it_castrol_may_also_engage_any_of_its_affiliates_in_its_sole_discretion_to_operate_the_program),
                    ParagraphComponent(traductor
                        .t_c_8_participation_the_program_is_extended_by_invitation_only_to_those_participants_who_have_during_the_validity_period_program_cycle_purchased_listoil_products_from_authorized_listoil_dealers_retailer_and_registered_themselves_on_qr_save_scan_app_and_scanned_qr_s_using_this_app_for_availing_the_program_benefits_listoil_reserves_the_right_to_choose_the_participants_for_this_program_at_its_discretion),
                    ParagraphComponent(traductor
                        .t_c_9_the_validity_of_the_program_opted_for_by_the_participant_will_be_articulated_on_listoil_s_qr_save_scan_app),
                    ParagraphComponent(
                        traductor.t_c_10_registration),
                    ListComponent(children: [
                      traductor.t_c_a_each_participant_will_be_required_to_register_himself_as_a_user_and_a_participant_in_the_program_on_the_app_each_participant_shall_be_deemed_to_have_read_through_these_t_cs_the_terms_of_use_of_the_app_and_all_other_policies_uploaded_on_the_app_from_time_to_time,
                      traductor.t_c_b_each_participant_shall_also_register_on_the_app_their_bank_account_details_for_receiving_credits_in_their_bank_accounts_it_is_agreed_and_understood_that_each_participant_should_only_mention_their_bank_account_details_to_receive_the_program_benefits_listoil_shall_engage_a_third_party_to_transfer_such_benefits_to_the_participants_listoil_shall_not_verify_the_bank_details_and_the_participant_shall_solely_be_responsible_for_providing_correct_and_accurate_bank_account_details_and_such_details_shall_be_deemed_as_the_participant_s_details_without_the_need_for_any___verification_whatsoever_each_participant_shall_keep_its_details_updated_in_case_a_participant_is_unable_to_do_the_same_please_write_to_listoil_at_qrcash_listoil_com,
                      traductor.t_c_c_the_participant_shall_also_provide_their_mobile_number_at_the_time_of_registration_with_castrol,
                      traductor.t_c_d_participants_shall_also_be_required_to_provide_their_accurate_pan_number_while_registering_on_the_app_listoil_may_appoint_a_third_party_to_verify_the_pan_details_of_the_participant_in_case_of_any_error_in_the_details_the_qr_save_scan_app_shall_provide_a_prompt_or_message_or_show_notification_that_the_details_are_not_validated_in_which_case_the_participant_shall_promptly_have_the_correct_details_added_for_verification_in_the_interim_listoil_may_in_its_sole_discretion_decide_to_provide_the_participant_program_benefits_subject_to_the_deduction_of_taxes_at_the_applicable_rates_which_rates_may_be_higher_in_the_absence_of_the_pan_details_it_shall_be_the_sole_responsibility_of_the_participant_to_have_the_valid_pan_details_added_and_verified_before_scanning_the_qr_code_listoil_shall_not_reimburse_the_participant_for_any_additional_tax_deductions_the_participant_acknowledges_that_relevant_state_and_central_taxes_may_be_deducted_by_the_merchant_while_redeeming_the_discount_offer_and_therefore_the_amount_reflected_in_the_voucher_may_not_be_the_same_as_the_final_redemption_value_received_by_the_participant,
                      traductor.t_c_e_listoil_may_from_time_to_time_require_the_participants_to_re_verify_their_bank_account_details_and_pan_number_and_upload_other_relevant_details_as_may_be_required_under_the_applicable_laws_for_processing_the_program_benefits_and_each_participant_agrees_to_have_the_same_updated_from_time_to_time,
                      traductor.t_c_f_participants_acknowledge_that_if_any_incorrect_or_inconsistent_information_is_provided_by_a_participant_listoil_shall_have_a_right_to_reject_the_transfer_of_any_benefits_under_the_program_or_transfer_benefits_after_deduction_of_taxes_at_the_applicable_rates_which_rates_may_be_higher_in_case_the_information_provided_is_incorrect_false_faulty_listoil_also_retains_a_right_to_disqualify_any_participant_at_any_time_in_case_of_false_or_incorrect_information_being_provided,
                      traductor.t_c_g_participants_should_link_their_valid_bank_accounts_with_the_mobile_number_registered_on_the_qr_save_scan_app_to_receive_periodic_updates_on_the_transfer_of_the_benefits,
                      traductor.t_c_h_each_participant_s_participation_in_the_program_and_receipt_of_benefits_from_the_program_shall_be_valid_only_on_the_mobile_number_given_at_the_time_of_registration_of_the_app_and_as_per_participant_profile_details_and_in_listoil_records_downloading_the_qr_save_scan_app_on_any_mobile_number_other_than_the_registered_number_will_disqualify_the_participant_from_the_program,
                    ]),
                    ParagraphComponent(traductor.t_c_11_program_benefits_point_accumulation_redemption),
                    ListComponent(children: [
                      traductor.t_c_a_a_participant_would_be_able_to_earn_points_and_other_bonuses_as_announced_from_time_to_time_based_on_the_listoil_product_purchased_and_the_qr_scanned_using_the_qr_save_scan_app_listoil_reserves_the_right_to_determine_the_point_earning_applicability_and_mechanism_of_each_product_and_the_accumulation_of_points_under_this_program,
                      traductor.t_c_b_the_validity_of_points_earned_would_be_12_months_from_the_date_of_scanning_listoil_may_in_its_sole_discretion_decide_to_extend_the_validity_of_such_points,
                      traductor.t_c_c_there_would_be_limits_set_on_the_accumulation_of_points_under_this_program_listoil_reserves_the_right_to_alter_change_or_modify_the_limits_on_the_points_that_can_be_accumulated_under_this_program_and_the_time_limit_for_accumulation_of_the_points_under_the_program_points_earned_will_be_displayed_on_the_qr_save_scan_app,
                      traductor.t_c_d_all_participants_are_required_to_accumulate_minimum_threshold_points_set_by_listoil_before_being_eligible_for_redemption_if_a_participant_does_not_earn_the_maximum_threshold_points_by_the_end_of_the_program_period_the_participant_will_forfeit_the_points_accumulated,
                      traductor.t_c_e_redemption_of_points_can_be_done_through_multiple_redemption_options_available_on_the_qr_save_scan_app_listoil_reserves_the_right_to_introduce_or_withdraw_any_of_the_redemption_options_without_prior_intimation_to_users,
                      traductor.t_c_f_points_to_value_conversion_for_redemption_will_be_mentioned_on_the_program_construct_listoil_reserves_the_right_to_alter_change_or_modify_the_points_to_value_conversion_under_this_program,
                      traductor.t_c_g_redemption_of_accumulated_points_will_be_using_direct_credit_to_the_bank_account_registered_on_the_qr_save_scan_app,
                      traductor.t_c_h_redemption_requests_once_made_cannot_be_cancelled,
                      traductor.t_c_i_all_benefits_under_the_program_are_subject_to_taxes_listoil_may_be_required_under_the_applicable_law_to_deduct_taxes_at_source_which_deduction_shall_be_made_based_on_the_information_uploaded_by_the_participants_on_the_app_all_such_deductions_shall_be_made_at_the_applicable_rates_irrespective_of_the_deductions_made_each_participant_shall_himself_herself_be_liable_for_disclosing_the_program_benefits_received_by_them_if_required_under_the_applicable_law_computing_their_income_taxes_and_having_the_same_deposited_with_the_relevant_governmental_authorities,
                    ]),
                    ParagraphComponent(traductor.t_c_9_tax_all_program_benefits_are_subject_to_the_applicable_income_tax_and_other_applicable_taxes_in_force_participants_shall_be_responsible_for_payment_of_all_applicable_taxes_including_but_not_limited_to_goods_and_service_tax_gst_and_other_taxes_duties_fines_penalties_etc_without_any_recourse_and_or_reimbursement_from_listoil),
                    ParagraphComponent(traductor.t_c_10_intellectual_property_rights_4_confidentiality_all_intellectual_property_rights_ipr_related_to_listoil_its_products_and_the_offer_including_documents_will_vest_solely_with_listoil_and_or_its_affiliates_globally_nothing_herein_provides_the_participants_a_right_and_or_licence_to_use_the_ipr_for_any_purpose_whatsoever_program_and_t_cs_are_confidential_and_shall_not_be_shared_with_any_third_party_confidentiality_obligations_shall_survive_the_termination_of_the_program),
                    ParagraphComponent(traductor.t_c_11_limited_liability_in_no_event_shall_listoil_and_or_its_affiliates_and_their_respective_officers_directors_agents_and_employees_be_liable_for_any_direct_indirect_incidental___special_consequential_or_punitive_damages_arising_out_of_or_related_to_this_program_in_no_event_shall_the_maximum_liability_exceed_the_value_of_the_voucher_as_the_case_may_be),
                    ParagraphComponent(traductor.t_c_12_indemnity_each_participant_shall_keep_listoil_indemnified_against_all_liabilities_arising_out_of_its_failure_to_pay_any_tax_and_or_due_to_all_other_actions_proceedings_claims_damages_charges_costs_and_expenses_whatsoever_about_this_program),
                    ParagraphComponent(traductor.t_c_13_privacy_each_participant_agrees_that_he_has_read_through_these_terms_in_detail_and_after_understanding_consents_to_the_collection_sharing_including_with_third_parties_for_implementing_the_offer_or_communicating_other_offers_activities_in_the_future_storing_processing_use_of_their_information_i_e_name_address_phone_number_email_id_bank_account_email_ids_and_other_information_provided_on_the_app_etc_for_the_purposes_detailed_herein_as_per_listoil_s_privacy_policy_available_at_https_www_castrol_com_en_in_india_home_privacy_statement_html_listoil_may_share_the_information_within_the_bp_group_companies_and_or_with_other_third_party_service_providers_including_data_processors_from_or_outside_india_in_case_you_wish_to_withdraw_your_consent_for_such_processing_please_write_to_us_please_also_note_that_on_withdrawal_listoil_will_be_unable_to_process_any_redemption_requests_it_is_also_understood_that_denial_or_removal_of_the_information_may_also_lead_to_certain_functionalities_of_the_app_not_being_available_it_is_also_understood_that_a_removal_request_would_not_mean_the_deletion_of_the_information_listoil_may_still_be_required_to_retain_the_user_s_information_for_a_certain_period_to_comply_with_the_applicable_legal_requirements_you_are_also_required_to_keep_correct_information_updated_on_the_app),
                    ParagraphComponent(traductor.t_c_14_the_participant_shall_keep_the_details_of_this_program_and_also_his_her_login_details_confidential),
                    ParagraphComponent(traductor.t_c_15_listoil_will_not_be_responsible_for_any_claims_losses_or_liabilities_if_a_participant_shares_their_details_with_any_third_party),
                    ParagraphComponent(traductor.t_c_16_listoil_reserves_the_right_to_alter_change_or_modify_the_t_cs_of_the_program_at_any_time_it_is_in_force_at_its_discretion_and_without_any_prior_notice_and_without_assigning_any_reason),
                    ParagraphComponent(traductor.t_c_17_in_the_event_of_any_inconsistency_between_these_t_cs_and_any_advertising_publicity_and_other_materials_relating_to_or_in_connection_with_the_program_these_t_cs_shall_prevail),
                    ParagraphComponent(traductor.t_c_18_listoil_reserves_the_right_to_postpone_cancel_the_program_for_any_reason_whatsoever_including_due_to_the_provisions_of_any_applicable_statutes_laws_or_rules_or_regulations_as_may_be_in_force_from_time_to_time),
                    ParagraphComponent(traductor.t_c_19_any_participant_found_obtaining_points_by_improper_means_in_the_opinion_of_listoil_would_be_disqualified_from_the_program_and_the_discretion_of_reinstating_his_membership_and_points_will_lie_with_listoil),
                    ParagraphComponent(traductor.t_c_20_the_participant_shall_not_bring_any_action_claim_damages_or_other_proceedings_against_listoil_its_directors_agents_employees_licensees_or_assignees_the_event_sponsors_or_any_of_its_affiliates_or_persons_associated_with_listoil_about_the_program),
                    ParagraphComponent(traductor.t_c_21_participants_represent_and_warrant_that_they_are_a_resident_of_india_above_the_age_of_18_and_are_competent_to_contract_notwithstanding_anything_contained_herein_listoil_hereby_reserves_the_right_to_deny_access_to_the_system_or_any_part_thereof_to_any_person_without_assigning_any_reason_therefore),
                    ParagraphComponent(traductor.t_c_22_listoil_shall_be_excused_from_performance_under_these_t_c_to_the_extent_it_is_prevented_or_delayed_from_performing_in_whole_or_in_part_as_a_result_of_an_event_or_series_of_events_caused_by_or_resulting_from_a_acts_of_god_b_acts_of_war_acts_of_terrorism_insurrection_riots_civil_disorders_or_rebellion_c_pandemics_quarantines_or_embargoes_d_labor_strikes_e_error_or_disruption_to_computer_hardware_or_networks_or_software_failures_or_g_any_other_causes_whether_similar_or_dissimilar_beyond_the_reasonable_control_of_listoil),
                    ParagraphComponent(traductor.t_c_23_the_participant_shall_not_assign_these_t_c_or_any_rights_benefits_or_obligations_here_without_the_express_written_permission_of_listoil_any_attempted_assignment_that_does_not_comply_with_these_t_cs_shall_be_null_and_void_listoil_may_assign_these_t_cs_in_whole_or_in_part_to_any_third_party_at_its_sole_discretion),
                    ParagraphComponent(traductor.t_c_24_the_participant_acknowledges_and_agrees_to_comply_with_all_applicable_laws_regulations_and_guidelines_concerning_the_transactions_contemplated_under_these_t_cs),
                    ParagraphComponent(traductor.t_c_25_this_program_and_these_terms_and_conditions_shall_be_read_and_interpreted_as_per_the_laws_of_india_any_dispute_about_the_program_will_be_subject_to_the_exclusive_jurisdiction_of_competent_courts_in_mumbai_only),
                    ParagraphComponent(traductor.t_c_26_the_payment_processing_partner_reserves_the_right_to_restrict_cashback_for_any_account_with_suspicious_behaviour_or_invalid_details_credentials),
                    ParagraphComponent(traductor.t_c_27_this_offer_is_subject_to_promotional_availability_and_government_regulations),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
