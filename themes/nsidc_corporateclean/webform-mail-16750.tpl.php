<?php
// TEMPLATE TO SEND EMAIL FOR THE ICESAT/GLAS SUBSETTER FORM AT https://nsidc.org/data/order/icesat-glas-subsetter
?>
<?php print ($email['html'] ? '<p>' : '') . t('referring_page: https://nsidc.org/data/icesat/order.html') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('filled_form: glas_subset_form.html') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('file_returned: thanks.html') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('title: [submission:values:user_information:title]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('first_name: [submission:values:user_information:first_name]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('last_name: [submission:values:user_information:last_name]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('organization: [submission:values:user_information:organization]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('email: [submission:values:user_information:email]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('address_1: [submission:values:user_information:address_1]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('address_2: [submission:values:user_information:address_2]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('address_3: [submission:values:user_information:address_3]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('city: [submission:values:user_information:city]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('state_province: [submission:values:user_information:state_province]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('postal_code: [submission:values:user_information:postal_code]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('country: [submission:values:user_information:country]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('phone: [submission:values:user_information:phone]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('type: [submission:values:user_information:type]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php $dataset_title_array = explode(",",t('[submission:values:subsetting_preferences:glas_dataset_title:key]'));
$dataset_titles = implode(",",$dataset_title_array);
?>
<?php print ($email['html'] ? '<p>' : '') . t('glas_dataset_title: ') . $dataset_titles . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('fax:[submission:values:user_information:fax]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('type_other_name: [submission:values:user_information:type_other_name]') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('message_question_comment: [submission:values:message_question_comment]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('bounding_coordinates: [submission:values:subsetting_preferences:spatial_area_1:south_latitude] [submission:values:subsetting_preferences:spatial_area_1:west_longitude] [submission:values:subsetting_preferences:spatial_area_1:north_latitude] [submission:values:subsetting_preferences:spatial_area_1:east_longitude]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t("[submission:values:subsetting_preferences:spatial_area_2:south_latitude_2] [submission:values:subsetting_preferences:spatial_area_2:west_longitude_2] [submission:values:subsetting_preferences:spatial_area_2:north_latitude_2] [submission:values:subsetting_preferences:spatial_area_2:east_longitude_2]") . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_3:south_latitude_3] [submission:values:subsetting_preferences:spatial_area_3:west_longitude_3] [submission:values:subsetting_preferences:spatial_area_3:north_latitude_3] [submission:values:subsetting_preferences:spatial_area_3:east_longitude_3]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_4:south_latitude_4] [submission:values:subsetting_preferences:spatial_area_4:west_longitude_4] [submission:values:subsetting_preferences:spatial_area_4:north_latitude_4] [submission:values:subsetting_preferences:spatial_area_4:east_longitude_4]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_5:south_latitude_5] [submission:values:subsetting_preferences:spatial_area_5:west_longitude_5] [submission:values:subsetting_preferences:spatial_area_5:north_latitude_5] [submission:values:subsetting_preferences:spatial_area_5:east_longitude_5]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_6:south_latitude_6] [submission:values:subsetting_preferences:spatial_area_6:west_longitude_6] [submission:values:subsetting_preferences:spatial_area_6:north_latitude_6] [submission:values:subsetting_preferences:spatial_area_6:east_longitude_6]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_7:south_latitude_7] [submission:values:subsetting_preferences:spatial_area_7:west_longitude_7] [submission:values:subsetting_preferences:spatial_area_7:north_latitude_7] [submission:values:subsetting_preferences:spatial_area_7:east_longitude_7]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_8:south_latitude_8] [submission:values:subsetting_preferences:spatial_area_8:west_longitude_8] [submission:values:subsetting_preferences:spatial_area_8:north_latitude_8] [submission:values:subsetting_preferences:spatial_area_8:east_longitude_8]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_9:south_latitude_9] [submission:values:subsetting_preferences:spatial_area_9:west_longitude_9] [submission:values:subsetting_preferences:spatial_area_9:north_latitude_9] [submission:values:subsetting_preferences:spatial_area_9:east_longitude_9]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('[submission:values:subsetting_preferences:spatial_area_10:south_latitude_10] [submission:values:subsetting_preferences:spatial_area_10:west_longitude_10] [submission:values:subsetting_preferences:spatial_area_10:north_latitude_10] [submission:values:subsetting_preferences:spatial_area_10:east_longitude_10]') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('start_date: [submission:values:subsetting_preferences:date_range:start_date] 00:00:00') . ($email['html'] ? '</p>' : ''); ?><br />
<?php print ($email['html'] ? '<p>' : '') . t('end_date: [submission:values:subsetting_preferences:date_range:end_date] 00:00:00') . ($email['html'] ? '</p>' : ''); ?><br />

<?php print ($email['html'] ? '<p>' : '') . t('ip: [current-user:ip-address]') . ($email['html'] ? '</p>' : ''); ?><br />