xquery version "3.1";

(:~
 : Non-standard extension functions, mainly used for the documentation.
 :)
module namespace pmf="http://www.tei-c.org/tei-simple/xquery/ext-html";

import module namespace html="http://www.tei-c.org/tei-simple/xquery/functions";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function pmf:template($config as map(*), $node as element(), $class as xs:string+, $content as node()*) {
    $config?apply-children($config, $node, $content)
};