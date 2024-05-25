import 'package:flutter/material.dart';

import '../../../../domain/constants/language_constants.dart';
import '../../../widgets/atoms/composite_component.dart';
import '../../../widgets/atoms/link_component.dart';
import '../../../widgets/atoms/list_component.dart';
import '../../../widgets/atoms/paragraph_component.dart';
import '../../../widgets/atoms/title_component.dart';
import '../../../widgets/organisms/custom_sliver_appbar.dart';

class CompositeFaqs extends StatefulWidget {
  const CompositeFaqs({super.key, required this.username});

  final String username;

  @override
  State<CompositeFaqs> createState() => _CompositeFaqsState();
}

class _CompositeFaqsState extends State<CompositeFaqs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppbar(
              title: translation(context)!.faqs,
              leading: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CompositeComponent(
                      name: translation(context)!.faqs_registration,
                      children: [
                        TitleComponent(
                            title: translation(context)!.faqs_registration),
                        CompositeComponent(
                            name: translation(context)!
                                .faqs_1_how_do_i_register_on_the_application_,
                            children: [
                              ParagraphComponent(translation(context)!
                                  .faqs_download_the_app_from_the_play_store_for_android_devices_or_the_app_store_for_apple_devices_on_the_first_screen__enter_your_mobile_number__and_proceed_to_complete_your_registration_),
                              LinkComponent(
                                headerMail:
                                    translation(context)!.faqs_registration,
                                bodyMail: translation(context)!
                                    .faqs_download_the_app_from_the_play_store_for_android_devices_or_the_app_store_for_apple_devices_on_the_first_screen__enter_your_mobile_number__and_proceed_to_complete_your_registration_,
                                username: widget.username,
                              ),
                            ]),
                        CompositeComponent(
                            name: translation(context)!
                                .faqs_2_which_mobile_number_do_i_enter__i_have_different_mobile_numbers__which_one_do_i_enter_,
                            children: [
                              ParagraphComponent(translation(context)!
                                  .faqs_it_is_recommended_that_you_use_the_same_mobile_number_used_with_the_smartphone_you_are_downloading_the_qr_cash_app_on_if_this_isn_t_the_case__ensure_that_you_have_access_to_the_phone_linked_to_the_mobile_number_you_entered_),
                              LinkComponent(
                                headerMail: translation(context)!
                                    .faqs_2_which_mobile_number_do_i_enter__i_have_different_mobile_numbers__which_one_do_i_enter_,
                                bodyMail: translation(context)!
                                    .faqs_it_is_recommended_that_you_use_the_same_mobile_number_used_with_the_smartphone_you_are_downloading_the_qr_cash_app_on_if_this_isn_t_the_case__ensure_that_you_have_access_to_the_phone_linked_to_the_mobile_number_you_entered_,
                                username: widget.username,
                              ),
                            ]),
                        CompositeComponent(
                            name: translation(context)!
                                .faqs_3_can_i_create_multiple_profiles_on_the_app_on_the_same_device_,
                            children: [
                              ParagraphComponent(translation(context)!
                                  .faqs_no__you_are_required_to_create_only_one_profile_and_will_not_be_permitted_to_access_the_application_on_the_same_device_with_multiple_profiles_),
                              LinkComponent(
                                headerMail: translation(context)!
                                    .faqs_3_can_i_create_multiple_profiles_on_the_app_on_the_same_device_,
                                bodyMail: translation(context)!
                                    .faqs_no__you_are_required_to_create_only_one_profile_and_will_not_be_permitted_to_access_the_application_on_the_same_device_with_multiple_profiles_,
                                username: widget.username,
                              ),
                            ]),
                        CompositeComponent(
                            name: translation(context)!
                                .faqs_4_i_am_unable_to_proceed_with_the_registration_and_receiving_a_message___please_grant_permission_to_capture_location_what_do_i_do_,
                            children: [
                              ParagraphComponent(translation(context)!
                                  .faqs_no__you_are_required_to_create_only_one_profile_and_will_not_be_permitted_to_access_the_application_on_the_same_device_with_multiple_profiles_),
                              LinkComponent(
                                headerMail: translation(context)!
                                    .faqs_4_i_am_unable_to_proceed_with_the_registration_and_receiving_a_message___please_grant_permission_to_capture_location_what_do_i_do_,
                                bodyMail: translation(context)!
                                    .faqs_no__you_are_required_to_create_only_one_profile_and_will_not_be_permitted_to_access_the_application_on_the_same_device_with_multiple_profiles_,
                                username: widget.username,
                              ),
                            ]),
                        CompositeComponent(
                            name: translation(context)!
                                .faqs_6_i_need_to_set_my_password_what_are_the_minimum_requirements_to_set_a_safe_password_,
                            children: [
                              ParagraphComponent(translation(context)!
                                  .faqs_the_password_you_set_needs_to_be_a_minimum_of_6_characters_with_at_least_one_number__one_alphabet__small_and_caps___and_one_special_character__e_g____________etc___),
                              LinkComponent(
                                headerMail: translation(context)!
                                    .faqs_6_i_need_to_set_my_password_what_are_the_minimum_requirements_to_set_a_safe_password_,
                                bodyMail: translation(context)!
                                    .faqs_the_password_you_set_needs_to_be_a_minimum_of_6_characters_with_at_least_one_number__one_alphabet__small_and_caps___and_one_special_character__e_g____________etc___,
                                username: widget.username,
                              ),
                            ]),
                        CompositeComponent(
                            name: translation(context)!
                                .faqs_7_i_don_t_know_my_bank_account_number_and_or_ifsc_code_where_do_i_get_that_from_,
                            children: [
                              ParagraphComponent(translation(context)!
                                  .faqs_the_bank_account_number_and_ifsc_code_are_both_printed_on_your_cheque_refer_to_your_cheque_leaflet_for_both_details_),
                              LinkComponent(
                                headerMail: translation(context)!
                                    .faqs_7_i_don_t_know_my_bank_account_number_and_or_ifsc_code_where_do_i_get_that_from_,
                                bodyMail: translation(context)!
                                    .faqs_the_bank_account_number_and_ifsc_code_are_both_printed_on_your_cheque_refer_to_your_cheque_leaflet_for_both_details_,
                                username: widget.username,
                              ),
                            ]),
                        CompositeComponent(
                            name: translation(context)!
                                .faqs_8_i_want_to_change_my_bank_account_details_can_i_,
                            children: [
                              ParagraphComponent(translation(context)!
                                  .faqs_you_can_change_it_a_maximum_of_three_times_please_go_to_the_account_section_on_the_bottom_right_corner_of_the_home_page_and_click_on_bank_details_to_update_your_information_),
                              LinkComponent(
                                headerMail: translation(context)!
                                    .faqs_8_i_want_to_change_my_bank_account_details_can_i_,
                                bodyMail: translation(context)!
                                    .faqs_you_can_change_it_a_maximum_of_three_times_please_go_to_the_account_section_on_the_bottom_right_corner_of_the_home_page_and_click_on_bank_details_to_update_your_information_,
                                username: widget.username,
                              ),
                            ]),
                      ],
                    ),
                    CompositeComponent(
                        name: translation(context)!.faqs_scanning,
                        children: [
                          TitleComponent(
                              title: translation(context)!.faqs_scanning),
                          CompositeComponent(
                              name: translation(context)!
                                  .faqs_1_i_have_scanned_a_valid_qr_code__but_it_is_partially_damaged_and_not_getting_read_what_should_i_do_,
                              children: [
                                ParagraphComponent(translation(context)!
                                    .faqs_please_use_the_manual_entry_option_present_on_the_home_screen_enter_the_12_digit_alphanumeric_code_printed_on_the_card_to_redeem_your_coupon_),
                                LinkComponent(
                                  headerMail: translation(context)!
                                      .faqs_1_i_have_scanned_a_valid_qr_code__but_it_is_partially_damaged_and_not_getting_read_what_should_i_do_,
                                  bodyMail: translation(context)!
                                      .faqs_please_use_the_manual_entry_option_present_on_the_home_screen_enter_the_12_digit_alphanumeric_code_printed_on_the_card_to_redeem_your_coupon_,
                                  username: widget.username,
                                ),
                              ]),
                          CompositeComponent(
                              name: translation(context)!
                                  .faqs_2_what_is_a_duplicate_scan_and_invalid_scan_,
                              children: [
                                ParagraphComponent(translation(context)!
                                    .faqs_a_duplicate_scan_is_an_error_that_will_pop_up_if_you_are_trying_to_scan_a_coupon_that_has_already_been_successfully_scanned_),
                                ParagraphComponent(translation(context)!
                                    .faqs_an_invalid_scan_is_an_error_that_will_pop_up_if_you_are_trying_to_scan_a_coupon_that_was_not_issued_by_listoil_there_are_limited_attempts_at_scanning_such_coupons__after_which_the_account_will_be_suspended_),
                                LinkComponent(
                                  headerMail: translation(context)!
                                      .faqs_2_what_is_a_duplicate_scan_and_invalid_scan_,
                                  bodyMail:
                                      "${translation(context)!.faqs_a_duplicate_scan_is_an_error_that_will_pop_up_if_you_are_trying_to_scan_a_coupon_that_has_already_been_successfully_scanned_}\n${translation(context)!.faqs_an_invalid_scan_is_an_error_that_will_pop_up_if_you_are_trying_to_scan_a_coupon_that_was_not_issued_by_listoil_there_are_limited_attempts_at_scanning_such_coupons__after_which_the_account_will_be_suspended_}",
                                  username: widget.username,
                                ),
                              ]),
                        ]),
                    CompositeComponent(
                        name: translation(context)!.faqs_report,
                        children: [
                          TitleComponent(
                              title: translation(context)!.faqs_report),
                          CompositeComponent(
                              name: translation(context)!
                                  .faqs_1_i_have_redeemed_few_coupons_and_would_like_to_check_the_payment_status_on_my_app_,
                              children: [
                                ParagraphComponent(translation(context)!
                                    .faqs_on_the_home_page__just_below_the_header__there_is_a_section_called_today_s_transactions_that_provides_a_break_up_of_the_coupons_redeemed_today_also_click_on_report_that_is_the_second_page_on_this_page_you_can_check_the_status_of_your_scans_made_on_the_current_day_the_types_of_transactions_mentioned_there_are),
                                ListComponent(children: [
                                  translation(context)!
                                      .faqs_processing___transaction_being_processed_by_fast_scan,
                                  translation(context)!
                                      .faqs_credited___transactions_already_credited_to_your_bank_account,
                                  translation(context)!
                                      .faqs_failure___transactions_that_have_failed__check_bank_account_details_entered_and_then_reinitiate_payment__n_click_on_detailed_report__on_the_mini_report_screen_to_get_an_overview_report_of_scans_made_for_a_chosen_date_range_,
                                ]),
                                LinkComponent(
                                  headerMail: translation(context)!
                                      .faqs_1_i_have_redeemed_few_coupons_and_would_like_to_check_the_payment_status_on_my_app_,
                                  bodyMail:
                                      translation(context)!.faqs_on_the_home_page__just_below_the_header__there_is_a_section_called_today_s_transactions_that_provides_a_break_up_of_the_coupons_redeemed_today_also_click_on_report_that_is_the_second_page_on_this_page_you_can_check_the_status_of_your_scans_made_on_the_current_day_the_types_of_transactions_mentioned_there_are,
                                  username: widget.username,
                                ),
                              ])
                        ]),
                    CompositeComponent(
                        name: translation(context)!.faqs_payments,
                        children: [
                          TitleComponent(
                              title: translation(context)!.faqs_payments),
                          CompositeComponent(
                              name: translation(context)!
                                  .faqs_1_i_can_see_a_prompt_on_my_home_page_that_states___yy_transactions_failed_worth_rs_xx_re_initiate_now_what_should_i_do_in_this_case_,
                              children: [
                                ParagraphComponent(translation(context)!
                                    .faqs_payments_could_have_failed_due_to_a_temporary_issue_at_your_bank_or_due_to_any_change_in_bank_account_information_if_you_have_a_new_bank_account__kindly_go_to_the_account_section_and_access_your_bank_details_to_verify_the_accuracy_of_the_information_if_it_is_incorrect__please_update_the_right_information_if_it_is_correct__kindly_click_on_the_re_initiate_now_tab_on_the_home_page_notification__and_we_will_re_trigger_these_transactions_),

                                LinkComponent(
                                  headerMail: translation(context)!
                                      .faqs_1_i_can_see_a_prompt_on_my_home_page_that_states___yy_transactions_failed_worth_rs_xx_re_initiate_now_what_should_i_do_in_this_case_,
                                  bodyMail:
                                  translation(context)!.faqs_payments_could_have_failed_due_to_a_temporary_issue_at_your_bank_or_due_to_any_change_in_bank_account_information_if_you_have_a_new_bank_account__kindly_go_to_the_account_section_and_access_your_bank_details_to_verify_the_accuracy_of_the_information_if_it_is_incorrect__please_update_the_right_information_if_it_is_correct__kindly_click_on_the_re_initiate_now_tab_on_the_home_page_notification__and_we_will_re_trigger_these_transactions_,
                                  username: widget.username,
                                ),
                              ]),
                          CompositeComponent(
                              name: translation(context)!
                                  .faqs_2_there_are_some_coupons_that_i_scanned__but_they_haven_t_been_credited_to_my_bank_account_,
                              children: [
                                ParagraphComponent(translation(context)!
                                    .faqs_it_could_take_up_to_7_working_days_for_us_to_successfully_complete_payments_in_some_instances_if_you_still_have_not_received_your_funds_within_this_period__please_contact_our_customer_care),
                                LinkComponent(
                                  headerMail: translation(context)!
                                      .faqs_2_there_are_some_coupons_that_i_scanned__but_they_haven_t_been_credited_to_my_bank_account_,
                                  bodyMail:
                                  translation(context)!.faqs_it_could_take_up_to_7_working_days_for_us_to_successfully_complete_payments_in_some_instances_if_you_still_have_not_received_your_funds_within_this_period__please_contact_our_customer_care,
                                  username: widget.username,
                                ),
                              ]),
                        ]),
                    CompositeComponent(
                        name: translation(context)!.faqs_support,
                        children: [
                          TitleComponent(
                              title: translation(context)!.faqs_support),
                          CompositeComponent(
                              name: translation(context)!
                                  .faqs_1_my_app_access_is_currently_suspended_what_should_i_do_,
                              children: [
                                ParagraphComponent(translation(context)!
                                    .faqs_please_contact_our_customer_care_inside_the_app),
                                LinkComponent(
                                  headerMail: translation(context)!
                                      .faqs_1_my_app_access_is_currently_suspended_what_should_i_do_,
                                  bodyMail:
                                  translation(context)!.faqs_please_contact_our_customer_care_inside_the_app,
                                  username: widget.username,
                                ),
                              ])
                        ]),
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
