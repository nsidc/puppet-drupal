<!-- begin nsidc.ssi -->
<!--#include virtual="/ssi/nsidc.ssi" -->
<!-- end nsidc.ssi include -->
<!-- #banner -->
<div id="banner">

	<?php print render($page['banner']); ?>
	     
</div><!-- EOF: #banner -->
<div id="uso-navigation" class="clearfix">
            <?php if ($page['navigation']) :?>
            <?php print drupal_render($page['navigation']); ?>
            <?php endif; ?>
</div>

<!-- #content -->
<div id="content">
	<!-- #content-inside -->
    <div id="content-inside" class="container_16 clearfix">
    
        <?php if ($page['sidebar_first']) :?>
        <!-- #sidebar-first -->
        <div id="sidebar-first" class="grid_9">
        	<?php print render($page['sidebar_first']); ?>
        </div><!-- EOF: #sidebar-first -->
        <?php endif; ?>
        
        <?php if ($page['sidebar_first'] && $page['sidebar_second']) { ?>
        <div class="grid_14">
        <?php } elseif ((!$page['sidebar_first']) && ($page['sidebar_second'])) { ?>
        <div id="main" class="grid_13">
		<?php } else { ?>
        <div id="main" class="grid_16">    
        <?php } ?>
            
            <?php if (theme_get_setting('breadcrumb_display','nsidc_corporateclean')): print $breadcrumb; endif; ?>
            
            <?php if ($page['highlighted']): ?><div id="highlighted"><?php print render($page['highlighted']); ?></div><?php endif; ?>
       
            <?php if ($messages): ?>
            <div id="console" class="clearfix">
            <?php print $messages; ?>
            </div>
            <?php endif; ?>
     
            <?php if ($page['help']): ?>
            <div id="help">
            <?php print render($page['help']); ?>
            </div>
            <?php endif; ?>
            
            <?php if ($action_links): ?>
            <ul class="action-links">
            <?php print render($action_links); ?>
            </ul>
            <?php endif; ?>
            
			<?php print render($title_prefix); ?>
            <?php if ($title): ?>
            <h1><?php print $title ?></h1>
            <?php endif; ?>
            <?php print render($title_suffix); ?>
            
            <?php if ($tabs): ?><?php print render($tabs); ?><?php endif; ?>
            
            <?php print render($page['content']); ?>
            
            <?php print $feed_icons; ?>
            
        </div><!-- EOF: #main -->
        
        <?php if ($page['sidebar_second']) :?>
        <!-- #sidebar-second -->
        <div id="sidebar-second" class="grid_3">
        	<?php print render($page['sidebar_second']); ?>
        </div><!-- EOF: #sidebar-second -->
        <?php endif; ?>  

    </div><!-- EOF: #content-inside -->

</div><!-- EOF: #content -->

<!-- #footer -->    
<div id="footer">
<div id="footer-bottom-inside" class="container_16 clearfix">
<!-- begin nsidc_footer.ssi -->  
  
<!--#include virtual="/ssi/nsidc_footer.ssi" -->

<!-- end nsdic_footer.ssi -->
</div><!-- EOF: footer-bottom-inside -->
</div><!-- EOF: #footer -->