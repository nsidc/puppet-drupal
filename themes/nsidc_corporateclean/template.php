<?php
function nsidc_corporateclean_preprocess_html(&$vars) {
	drupal_add_css(drupal_get_path('theme', 'nsidc_corporateclean') . '/style.css', array('group' => CSS_THEME, 'type' => 'file', 'media' => 'screen'));
	drupal_add_css(drupal_get_path('theme', 'nsidc_corporateclean') . '/color/colors.css', array('group' => CSS_THEME, 'type' => 'file', 'media' => 'screen'));
	drupal_add_css(drupal_get_path('theme', 'nsidc_corporateclean') . '/css/1100.css', array('group' => CSS_THEME, 'type' => 'file', 'media' => 'screen and (min-width: 1100px)'));
	drupal_add_css(drupal_get_path('theme', 'nsidc_corporateclean') . '/css/960.css', array('group' => CSS_THEME, 'type' => 'file', 'media' => 'screen and (min-width: 980px) and (max-width: 1100px)'));
	drupal_add_css(drupal_get_path('theme', 'nsidc_corporateclean') . '/css/720.css', array('group' => CSS_THEME, 'type' => 'file', 'media' => 'screen and (min-width: 760px) and (max-width: 980px)'));
	drupal_add_css(drupal_get_path('theme', 'nsidc_corporateclean') . '/css/mobile.css', array('group' => CSS_THEME, 'type' => 'file', 'media' => 'screen and (max-width: 760px)'));
// Use a content type html.tpl.php file if one is available in the root of the theme
	if ($node = menu_get_object()) {
    	$vars['theme_hook_suggestions'][] = 'html__'. $node->type;
    }
}
function nsidc_corporateclean_preprocess_page(&$vars, $hook) {
  if (isset($vars['node'])) {
    // If the node type is "blog_madness" the template suggestion will be "page--blog-madness.tpl.php".
    $vars['theme_hook_suggestions'][] = 'page__'. $vars['node']->type;
  }
}
// applys only to the news page view -- adds a wrapper div to the content that needs to overlay the image -- name is different on staging and production
function nsidc_corporateclean_preprocess_views_view_fields(&$vars, $hook){
  if (($vars['view']->name == 'news_page') || ($vars['view']->name == 'newsroom')) {
    $vars['fields']['field_publish_date']->wrapper_prefix = '<div class="slideshow-content-wrapper">' . $vars['fields']['field_publish_date']->wrapper_prefix;
    $vars['fields']['body']->wrapper_suffix .= '</div>';
  }
}
function nsidc_corporateclean_css_alter(&$css)
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
}

// overwrite login and registration forms from logintobaggan module
function nsidc_corporateclean_form_user_register_form_alter(&$form, &$form_state, $form_id) {

    $form['account']['name']['#title'] = t('Your Name (first and last)');

}
function nsidc_corporateclean_lt_username_title($variables) {
  switch ($variables['form_id']) {
    case 'user_login':
      // Label text for the username field on the /user/login page.
      return t('E-mail address OR NSIDC LDAP user name');
      break;

    case 'user_login_block':
      // Label text for the username field when shown in a block.
      return t('User name');
      break;
  }
}
function nsidc_corporateclean_lt_username_description($variables) {
  switch ($variables['form_id']) {
    case 'user_login':
      // The username field's description when shown on the /user/login page.
      return t('NSIDC employees -- use your LDAP user name.');
      break;
    case 'user_login_block':
      return '';
      break;
  }
}
function nsidc_corporateclean_lt_password_description($variables) {
  switch ($variables['form_id']) {
    case 'user_login':
      // The password field's description on the /user/login page.
      return t('Password is case sensitive. NSIDC employees use LDAP password.');
      break;

    case 'user_login_block':
      // If showing the login form in a block, don't print any descriptive text.
      return '';
      break;
  }
}

function nsidc_corporateclean_lt_unified_login_page($variables) {

  $login_form = $variables['login_form'];
  $register_form = $variables['register_form'];
  $active_form = $variables['active_form'];
  $output = '';

  $output .= '<div class="toboggan-unified ' . $active_form . '">';

  // Create the initial message and links that people can click on.
	//  $output .= '<div id="login-message"><h2>' . t('Please log in.') . '</h2></div>';


  $output .= '<div id="nsidc-login-links">';
  $output .= '<p>NOTE: All NSIDC employees have accounts using their LDAP credentials. Others must first create an account to log in.</p>';
  $output .= l(t('I have an account'), 'user/login', array('attributes' => array('class' => array('login-link'), 'id' => 'login-link')));
  $output .= l(t('Create an account'), 'user/register', array('attributes' => array('class' => array('login-link'), 'id' => 'register-link')));

  $output .= '</div>';

  // Add the login and registration forms in.
  $output .= '<div id="login-form"><div id="login-message"><h2>Please log in</h2></div>' . $login_form . '</div>';
  $output .= '<div id="register-form"><div id="login-message"><h2>Please register for an account</h2></div>' . $register_form . '</div>';

  $output .= '</div>';

  return $output;
}

function nsidc_corporateclean_lt_loggedinblock($variables){
	$output = '<h3>You are currently logged in.</h3>';
	$output .= l(t('Log out'), 'user/logout');
  return $output;
}
?>