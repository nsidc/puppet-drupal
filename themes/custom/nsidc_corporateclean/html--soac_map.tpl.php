<?php

/**
* template for just the "Satellite Observations of Arctic Change" section, requires/applies to the content type "soac-map"
 */
  $url = "http://$_SERVER[HTTP_HOST]";
	$parsedUrl = parse_url($url);
	$host = explode('.', $parsedUrl['host']);
	if ($host[0] !== 'nsidc') {
	$subdomain = $host[0] . ".";
	}
?><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php print $language->language; ?>" version="XHTML+RDFa 1.0" dir="<?php print $language->dir; ?>"<?php print $rdf_namespaces; ?>>

<head profile="<?php print $grddl_profile; ?>">
  <?php print $head; ?>
  <title><?php print $head_title; ?> :: Satellite Observations of Arctic Change</title> 
  <meta name="description" content="Explore and learn about changes taking place in the Arctic over time with interactive maps of satellite data."> 
  <?php print $styles; ?>
  	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,400italic,600italic' rel='stylesheet' type='text/css'>
  	<link href='/css/nsidc-header-2014.css' rel='stylesheet' type='text/css'>
     <link rel="stylesheet" type="text/css" href="http://<?php print $subdomain ?>soac.apps.nsidc.org/vendor/jquery-ui/themes/base/jquery-ui.css"/>
    <link rel="stylesheet" type="text/css" href="http://<?php print $subdomain ?>soac.apps.nsidc.org/vendor/leaflet-dist/leaflet.css" />
    <link rel="stylesheet" type="text/css" href="http://<?php print $subdomain ?>soac.apps.nsidc.org/vendor/bootstrap/dist/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="http://<?php print $subdomain ?>soac.apps.nsidc.org/css/sota.css"/>
    <link rel="stylesheet" type="text/css" href="http://<?php print $subdomain ?>soac.apps.nsidc.org/css/custom-bootstrap.css"/> 
    <link rel="stylesheet" type="text/css" href="/<?php print $base_root . $base_path . path_to_theme() ?>/section_library/soac.css">   
	<link rel="stylesheet" type="text/css" href="/<?php print $base_root . $base_path . path_to_theme() ?>/section_library/soac-map.css"> 

  <?php print $scripts; ?>
	<script type="application/javascript" src="/<?php print $base_root . $base_path . path_to_theme() ?>/js/show-more-less.js"></script>
  	<script type="application/javascript" src="/scripts/global/functionOnload.js"></script>
	<script type="application/javascript" src="/scripts/nsidc-nav.js"></script>
	<script src="/scripts/global/buildModalDiv.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.selectboxit/3.8.0/jquery.selectBoxIt.min.js"></script>
	<!-- google search script -->
	<script type="application/javascript" src="http://www.google.com/cse/brand?form=cref"></script> 
     <!--#include virtual="/ssi/analytics.ssi" -->
  <?php if (theme_get_setting('responsive_respond','nsidc_corporateclean')):
  global $base_path; global $base_root; ?>
  <!--[if lt IE 9]>
  <script src="/<?php print $base_root . $base_path . path_to_theme() ?>/js/respond.min.js"></script>
  <![endif]-->
  <?php endif; ?>
  <script type="application/javascript" src="/<?php print $base_root . $base_path . path_to_theme() ?>/section_library/soac-map.js"></script>
    <script data-main="http://<?php print $subdomain ?>soac.apps.nsidc.org/js/app/main.js" src="http://<?php print $subdomain ?>soac.apps.nsidc.org/vendor/requirejs/require.js"></script>
 
 
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
