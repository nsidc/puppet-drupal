<?php
/**
 * Return a themed breadcrumb trail.
 *
 * @param $breadcrumb
 *   An array containing the breadcrumb links.
 * @return
 *   A string containing the breadcrumb output.
 */
function eloka_breadcrumb($variables){
  $breadcrumb = $variables['breadcrumb'];
  $breadcrumb_separator=theme_get_setting('breadcrumb_separator','eloka');
  
  $show_breadcrumb_home = theme_get_setting('breadcrumb_home');
  if (!$show_breadcrumb_home) {
  array_shift($breadcrumb);
  }
  
  if (!empty($breadcrumb)) {
    $breadcrumb[] = drupal_get_title();
    return '<div class="breadcrumb">' . implode(' <span class="breadcrumb-separator">' . $breadcrumb_separator . '</span>', $breadcrumb) . '</div>';
  }
}

function eloka_page_alter($page) {

	if (theme_get_setting('responsive_meta','eloka')):
	$mobileoptimized = array(
		'#type' => 'html_tag',
		'#tag' => 'meta',
		'#attributes' => array(
		'name' =>  'MobileOptimized',
		'content' =>  'width'
		)
	);

	$handheldfriendly = array(
		'#type' => 'html_tag',
		'#tag' => 'meta',
		'#attributes' => array(
		'name' =>  'HandheldFriendly',
		'content' =>  'true'
		)
	);

	$viewport = array(
		'#type' => 'html_tag',
		'#tag' => 'meta',
		'#attributes' => array(
		'name' =>  'viewport',
		'content' =>  'width=device-width, initial-scale=1'
		)
	);
	
	drupal_add_html_head($mobileoptimized, 'MobileOptimized');
	drupal_add_html_head($handheldfriendly, 'HandheldFriendly');
	drupal_add_html_head($viewport, 'viewport');
	endif;
	
}

function eloka_preprocess_html(&$variables) {

	if (!theme_get_setting('responsive_respond','eloka')):
	drupal_add_css(path_to_theme() . '/css/basic-layout.css', array('group' => CSS_THEME, 'browsers' => array('IE' => '(lte IE 8)&(!IEMobile)', '!IE' => FALSE), 'preprocess' => FALSE));
	endif;
	
	drupal_add_css(path_to_theme() . '/css/ie.css', array('group' => CSS_THEME, 'browsers' => array('IE' => '(lte IE 8)&(!IEMobile)', '!IE' => FALSE), 'preprocess' => FALSE));
}


function eloka_css_alter(&$css)
{
    unset($css[drupal_get_path('module', 'system').'/system.theme.css']);
    unset($css[drupal_get_path('module', 'system').'/system.messages.css']);
    unset($css[drupal_get_path('module', 'comment').'/comment.css']);
    unset($css[drupal_get_path('module', 'field').'/theme/field.css']);
    unset($css[drupal_get_path('module', 'node').'/node.css']);
    unset($css[drupal_get_path('module', 'search').'/search.css']);
    unset($css[drupal_get_path('module', 'user').'/user.css']);
    unset($css[drupal_get_path('module', 'views').'/css/views.css']);
    unset($css[drupal_get_path('module', 'ctools').'/css/ctools.css']);
    unset($css[drupal_get_path('module', 'panels').'/css/panels.css']);
    unset($css['sites/all/modules/ldap/ldap_user/ldap_user.css']);
    unset($css['sites/all/modules/ldap/ldap_servers/ldap_servers.admin.css']);
	unset($css['sites/all/modules/ckeditor/ckeditor.css']);
}

?>