<?php

/**
* template for just the "State of the Arctic" section, applies only to the content type "state-of-the-arctic"
 */
?><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php print $language->language; ?>" version="XHTML+RDFa 1.0" dir="<?php print $language->dir; ?>"<?php print $rdf_namespaces; ?>>

<head profile="<?php print $grddl_profile; ?>">
  <?php print $head; ?>
  <title><?php print $head_title; ?></title>  
  <?php print $styles; ?>
  
  <?php if (theme_get_setting('responsive_respond','nsidc')):
  global $base_path; global $base_root; ?>
  <!--[if lt IE 9]>
  <script src="<?php print $base_root . $base_path . path_to_theme() ?>/js/respond.min.js"></script>
  <![endif]-->
  <?php endif; ?>
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,400italic,600italic' rel='stylesheet' type='text/css'>
  	<link href='/css/nsidc-header.css' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/<?php print $base_root . $base_path . path_to_theme() ?>/section_library/sota.css">
    
  <?php print $scripts; ?>
  	<script src="/scripts/global/functionOnload.js"></script>
	<script src="/scripts/nsidc-main-nav.js"></script>
    <!--build Service Interruption Notice window -->
	<script src="/scripts/global/buildModalDiv.js"></script>
    <!--#include virtual="/ssi/analytics.ssi" -->
	<!-- google search script -->
	<script src="http://www.google.com/cse/brand?form=cref"></script>
    

</head>
<body class="sota" <?php print $attributes;?>>
  <div id="skip-link">
    <a href="#main-content" class="element-invisible element-focusable"><?php print t('Skip to main content'); ?></a>
  </div>
  <div id="wrapper">
  <?php print $page_top; ?>
  <?php print $page; ?>
  <?php print $page_bottom; ?>
  </div><!-- EOF: wrapper -->
</body>
</html>
