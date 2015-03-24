<?php
function ds_eloka_ds() {
  return array(
    'label' => t('ELOKA Right Sidebar'),
    'regions' => array(
      'left' => t('Left'),
      'right' => t('Right')
    ),
    // Add this line if there is a default css file.
    'css' => TRUE,
    // Add this line if you're using DS 2.x for icon preview
    'image' => TRUE,
  );
}
?>