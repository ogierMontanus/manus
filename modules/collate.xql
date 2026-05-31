xquery version "3.1";

(:~
 : Render a .col.xml parallel-segmentation document as a juxta-collation HTML
 : fragment. Applies the imported `collate.xsl` (verbatim from the
 : standalone skt2 viewer) via a thin adapter `collate-fragment.xsl` that
 : strips the surrounding <html>/<head>/<body> and scopes the CSS to a
 : .collation-root wrapper so it can be embedded in the TP page shell.
 :)
module namespace collate="http://teipublisher.com/api/collate";

import module namespace transform="http://exist-db.org/xquery/transform";
import module namespace errors="http://e-editiones.org/roaster/errors";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare variable $collate:works := "/db/apps/manus-data/data/works";
declare variable $collate:fragment-xsl :=
    doc("/db/apps/manus/resources/xsl/collate-fragment.xsl");

declare function collate:render($request as map(*)) {
    let $id := $request?parameters?id
    let $path := $collate:works || "/" || $id || "/" || $id || ".col.xml"
    return
        if (not(doc-available($path))) then
            error($errors:NOT_FOUND, "No collation document for " || $id)
        else
            transform:transform(doc($path), $collate:fragment-xsl, ())
};
