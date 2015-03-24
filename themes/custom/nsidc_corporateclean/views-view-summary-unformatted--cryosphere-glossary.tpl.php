<?php

/**
 * Rewrite of the default view to accommodate the conflict between the exposed filter using a query string like ?key=climate that was getting passed to the href in the A-Z links for the glossary
 */
?>
<?php
$total = 0;
$letters = range ('A', 'Z');
foreach($rows as $id => $row){
  $existing_letters[] = $row->link;
  $urls[$row->link] = $row->url;
  $counts[$row->link] = $row->count;
  $total += $row->count;
}
$letters[] = 'all';
$existing_letters[] = 'all';
$urls['all'] = "/cryosphere/glosarry/all";
$counts['all'] = $total;
print '<div class="views-summary views-summary-unformatted">';
foreach($letters as $letter){
  if(in_array($letter, $existing_letters)){
    $nav[] = '<span class="result"> <a href="/cryosphere/glossary/' . $letter . '">' . $letter . '</a> </span>';
  }
  else {
    $nav[] = '<span class="no-result">' . $letter . '</span>';
  }
}
print implode(' | ', $nav);
print '</div>';
?>
