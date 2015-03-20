<?php

/**
 * @file
 * Customized implementation to display a single Drupal page while offline.
 *
 * All the available variables are mirrored in html.tpl.php and page.tpl.php.
 * Some may be blank but they are provided for consistency.
 *
 * @see template_preprocess()
 * @see template_preprocess_maintenance_page()
 *
 * @ingroup themeable
 */
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php print $language->language ?>" lang="<?php print $language->language ?>" dir="<?php print $language->dir ?>">

<head>
  <title><?php print $head_title; ?></title>
  <?php print $head; ?>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,400italic,600italic' rel='stylesheet' type='text/css'>
        <link href="/css/nsidc-header.css" rel="stylesheet" type="text/css" media="all">
    <style>
    html { background: url("/images/bkg/bkg14.jpg") no-repeat fixed center center / cover  #283B5A }
	body {
    font: 0.9em/175% 'Open Sans',Segoe UI,Arial,Helvetica,sans-serif;
    margin: 0;
    outline: 0 none;
    padding: 0;
    vertical-align: baseline;
	color: #474747;
	background: none;
}
#wrapper {
    margin-left: auto;
    margin-right: auto;
    width: 40%;
	margin-top: 10%;
}
#header, #footer-wrapper {
    box-shadow: 0 3px 5px #0F264C;
    clear: both;
    height: 64px;
	min-width: 100%;
	background: none repeat scroll 0 0 #002248;
}
#header #logo {
    margin: 0 0 0 15px;
    background-image: url("http://nsidc.org/images/nsidc-id-264.png");
    background-position: 0 8px;
    background-repeat: no-repeat;
    float: left;
    height: 64px;
    padding: 0;
    width: 300px;
}
#header #logo h1 {
    font-size: 6px;
    margin: 0;
    padding: 0;
    text-indent: -9999px;
    width: 200px;
}
#header #logo h1 a {
    display: block;
    height: 50px;
    margin: 0;
    padding: 0;
    width: 200px;
}
#content {
    box-shadow: 3px 5px 5px #0F264C;
    clear: both;
    color: #06070B;
    float: left;
    padding: 20px;
	background: rgba(255, 255, 255, 0.6);
}
h1, h2, h3, h4, h5, h6 {
    color: #1487D4;
    text-shadow: 1px 1px 1px #666666;
}
h1 {
    font-family: Interval, Impact, helvetica, sans-serif;
    font-size: 32px;
    font-weight: normal;
    margin: 0 0 20px;
}
h1, h2, h3, h4, h5, h6 {
    line-height: 120%;
}
#footer {
	color: #fff;
	padding: 20px;
	background: #002248;
}
#footer a {
	color: #1487d4;
}
    </style>


  <?php print $scripts; ?>
	<script type="application/javascript" src="/scripts/global/jquery-background.js"></script>
</head>
<body class="<?php print $classes; ?>">
  <div id="wrapper">
  <div id="header">
	<div id="header-inside-left" class="grid_4"><div id="logo"><h1><a href="/">National Snow and Ice Data Center</a></h1></div>
  </div> <!-- /header -->

        <div id="content">
          <h1 class="title" id="page-title">We'll be back soon.</h1>
          
          <p><?php print $content; ?></p>
        </div> <!-- /content -->


    <div id="footer-wrapper">
      <div id="footer">
        <?php if (!empty($footer)): print $footer; endif; ?>
                  <p>Need to talk to us? You can always contact our friendly User Services Office at <a href="mailto:nsidc@nsidc.org">nsidc@nsidc.org</a> or + 1 303.492.6199.</p>
      </div> <!-- /footer -->
    </div> <!-- /footer-wrapper -->

  </div> <!-- /page -->

</body>
</html>
