<?php
error_reporting(E_ERROR | E_PARSE);

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */
header('Content-Type: text/html; charset=utf-8');

$start = 0;
$rows = 20;
$query = isset($_REQUEST['q']) ? $_REQUEST['q'] : false;
$results = false;

$server = 'twain.lib.virginia.edu';
//$server = 'twain.internal.lib.virginia.edu';
$port = '443'; # this is removed in lib/Service.php anyway
$path = '/solr/tcore';

if ($query) {
    include_once 'lib/Service.php';

    $solr = new Apache_Solr_Service($server, $port, $path);

    $additionalParameters = array(
        'facet' => 'true',
        'facet.mincount' => 1,
        'facet.limit' => $rows,
        'facet.field' => 'facet_title',
        'hl' => 'true',
        'hl.snippets' => 1,
        'hl.fragsize' => '500',
        'hl.fl' => 'section'
    );

    if (isset($_REQUEST['fq'])) {
        $additionalParameters['fq'] = 'facet_title:"' . $_REQUEST['fq'] .'"';
    }

    if (isset($_REQUEST['start'])) {
        $start = $_REQUEST['start'];
    }
    try {
        $results = $solr->search('section:'.$query, $start, $rows, $additionalParameters);
    } catch (Exception $e) {
        die("<html><head><title>SEARCH EXCEPTION</title><body><pre>{$e->__toString()}</pre><!-- Matomo --> <script> var _paq = window._paq = window._paq || []; /* tracker methods like \"setCustomDimension\" should be called before \"trackPageView\" */ _paq.push(['trackPageView']); _paq.push(['enableLinkTracking']); (function() { var u=\"https://analytics.lib.virginia.edu/\"; _paq.push(['setTrackerUrl', u+'matomo.php']); _paq.push(['setSiteId', '46']); var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s); })(); </script> <!-- End Matomo Code -->
</body></html>");
    }
}

function displayResults($results, $start, $rows)
{

    $html = '';
    if ($results) {
        $total = (int) $results->response->numFound;
        $start = min($start+1, $total);
        $end = min($start+$rows-1, $total);

        $html = "<div>Results {$start} - {$end} of {$total}</div>";
        $html .= "<div id='results'>";

        foreach ($results->response->docs as $doc) {
            $title = htmlspecialchars($doc->__get('title'), ENT_NOQUOTES, 'utf-8');
            $id = $doc->__get('id');
            $snippet = $results->highlighting->$id->section[0];
            $url = $doc->__get('source').'#'.$doc->__get('div_id');

            $html .= "<div class='result'>";
            $html .= "<h3><a href='{$url}'>{$title}</a></h3>";
            $html .= "<p class='snippet'>{$snippet}</p>";
            $html .= "</div>";
        }

        $html .= '</div>';

    }

    return $html;

}

function displayFacets($results, $query)
{

    $html = '<ul class="page-nav">';

    foreach ((array)$results->facet_counts->facet_fields as $facet => $values) {
        foreach ($values as $label => $count) {
            $html .= '<li><a href="' . buildFacetString($label) . '">' . $label . '</a> ('.$count.')</li>';
        }
    }

    $html .= '</ul>';

    if (isset($_REQUEST['fq'])) {
        $html .= '<a href="'. removeFacet() .'" class="clear-facet">Reset</a>';
    }

    return $html;

}

function buildFacetString($facet)
{
    parse_str($_SERVER['QUERY_STRING'], $query_string);
    $query_string['fq'] = $facet;
    unset($query_string['start']);
    return '?' . http_build_query($query_string);
}

function removeFacet($facet)
{
    parse_str($_SERVER['QUERY_STRING'], $query_string);
    unset($query_string['fq']);
    return '?' . http_build_query($query_string);
}

function nextLink($start, $rows)
{
    parse_str($_SERVER['QUERY_STRING'], $query_string);
    $query_string['start'] = $start + $rows;
    return '?' . http_build_query($query_string);
}

function previousLink($start, $rows)
{
    parse_str($_SERVER['QUERY_STRING'], $query_string);
    $query_string['start'] = $start - $rows;
    return '?' . http_build_query($query_string);
}

?>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>Search Mark Twain's Texts</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="stylesheets/screen.css">
    <link rel="stylesheet" href="stylesheets/base.css">
    <script src="js/vendor/modernizr-2.5.3.min.js"></script>
    <style>
        #masthead {
            margin: 0 auto;
        }

        body {
           background-image: url('../../bkgrnd2.gif');
           background-repeat: repeat-x, repeat-y;
        }

        article, #sidebar {
            margin-top: 1.2em;
        }

        input[type=text] { font-size: 14px; height: 30px; padding: 0px;}
    </style>
</head>
<body>

    <div id="content">

        <div id="masthead">
            <img alt="masthead" src="../searchMThp.jpg">
        </div>

        <article>
            <header><h1>Search Mark Twain's Writings</h1></header>

            <div class="entry-content">

                <form accept-charset="utf-8" method="get" class="well form-search">
                    <input type="text" name="q" class="input-xlarge search-query" id="q" value="<?php echo htmlspecialchars($query, ENT_QUOTES, 'utf-8'); ?>" />
                    <button class="btn" type="submit">Search</button>
                </form>
                <?php echo displayResults($results, $start, $rows); ?>
                <?php if (!$results): ?>
                    <div class="intro">
                    <p> &nbsp; &nbsp; What you can <font size="-1">SEARCH</font> here are the works by which MT's achievement was defined in his time.  <i>Above</i> is the 25-volume edition of <i>Mark Twain's Writings</i> that was published near the end of his life and
      advertised to prospective buyers as "<a href="http://twain.lib.virginia.edu/sc_as_mt/yourmt.html" target="_top">Your Mark Twain</a>."  Over
      the next decade, as it was reprinted by different publishers and in different editions, some shorter pieces were moved from one volume to another, but the basic canon of "Mark Twain's Writings" remained constant.  It is important to realize that the "Mark Twain" captured by this edition is not exactly the same as <i>our</i> "Mark Twain."  Many of the MT
      works that define his achievement in our times -- "The War Prayer," for example, or "The United States of Lyncherdom" -- were not included, either
      because Samuel Clemens never allowed "Mark Twain" to publish them, or because -- like the anti-imperialist pieces he did publish during his lifetime --
      they were not considered a relevant or significant part of his legacy.</p>

      <p> &nbsp; &nbsp; The site's searchable titles are listed <i>at left</i>.  The first nineteen comprised the standard 25-volume edition, and are listed in order of their volume numbers.  (Note the precedence given to MT's travel writings even at the end of his career.)  The three additional books were published between 1909 and 1916, after the edition's contents were codified.  MT himself authorized the first two publications; the version of <i>The Mysterious Stranger</i> here is the one his literary executor, Albert Bigelow Paine, brought out six years after MT's death.</p>
                    </div>
                <?php endif; ?>

                <div class="pager">
                    <ul>
                        <?php if ($start > 0): ?>
                            <li class="previous"><a href="<?php echo previousLink($start, $rows); ?>">&larr; Prev</a></li>
                        <?php endif; ?>
                        <?php if ($start + $rows < (int) $results->response->numFound): ?>
                            <li class="next"><a href="<?php echo nextLink($start, $rows); ?>">Next &rarr;</a></li>
                        <?php endif; ?>
                    </ul>
                </div>

            </div>


        </article>
        <div id="sidebar">
            <?php if ($results): ?>
                <h3>Limit by Title</h3>
            <?php endif; ?>
            <?php echo displayFacets($results, $query); ?>
        </div>
    </div>
<!-- Matomo --> <script> var _paq = window._paq = window._paq || []; /* tracker methods like "setCustomDimension" should be called before "trackPageView" */ _paq.push(['trackPageView']); _paq.push(['enableLinkTracking']); (function() { var u="https://analytics.lib.virginia.edu/"; _paq.push(['setTrackerUrl', u+'matomo.php']); _paq.push(['setSiteId', '46']); var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s); })(); </script> <!-- End Matomo Code -->
</body>
</html>
