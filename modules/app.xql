xquery version "3.1";

(: 
 : Module for app-specific template functions
 :
 : Add your own templating functions here, e.g. if you want to extend the template used for showing
 : the browsing view.
 :)
module namespace app="teipublisher.com/app";

import module namespace templates="http://exist-db.org/xquery/templates";
import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare
    %templates:wrap
function app:info($node as node(), $model as map(*), $collection as xs:string) {
    let $path := $config:data-articles || '/' || $collection || '/index.xml'
    let $index := doc($path)
    return
    <p>
        <pb-i18n key="browse.{$collection}.description">
           {data($index//tei:abstract[@xml:lang='da'])}
        </pb-i18n>
    </p>
};

declare
    %templates:wrap
function app:visu($node as node(), $model as map(*), $collection as xs:string) {
    <p>
        <img src="../andersen-data/data/articles/{$collection}/chessboard.svg" />
    </p>
};

declare
    %templates:wrap
    %templates:default("section", "dossier")

function app:list($node as node(), $model as map(*), $section as xs:string, $collection as xs:string) {
    let $path := $config:data-articles || '/' || substring-after($collection, 'works/') || '/index.xml'
    let $index := doc($path)
    let $items := $index//tei:list[tei:head[@n=$section]]/tei:item
    return
    <paper-card class="doclist" data-i18n="[heading]browse.{$section}" heading="{$section}">
        <div>
            <h2>{$collection}</h2>   
            <h3>{$path}</h3> 
            <ul>
            {
                for $d in $items 
                    let $path := $collection || '/' || normalize-space($d)
                    let $title := normalize-space(doc($config:data-root || '/' || $path)//tei:titleStmt/tei:title)
                return 
                    <li><a href="{$path}">{$title}</a></li>
            }
            </ul>
        </div>
    </paper-card>
};

declare
function app:index($request as map(*)) {
    let $index := doc($config:index)
        
        for $i in $index//tei:item 
        return
       
            let $link-da := 
                if ($i/tei:idno[@type="collection"]) then 
                    <a href="landing.html?collection=works/{$i/tei:idno[@type='collection']}" target="_blank">{distinct-values($i/tei:title[@xml:lang="da"][.!=''])}</a>
                else
                    distinct-values($i/tei:title[@xml:lang="da"][.!=''])

            let $link-en := 
                if ($i/tei:idno[@type="collection"]) then 
                    <a href="landing.html?collection=works/{$i/tei:idno[@type='collection']}" target="_blank">{distinct-values($i/tei:title[@xml:lang="en"][.!=''])}</a>
                else
                    distinct-values($i/tei:title[@xml:lang="en"][.!=''])
            
            return
                map {
                    "name": $link-da, 
                    "english": $link-en,
                    "date": $i/tei:date/string(),
                    "desc": if ($i/tei:desc/string()) then <div>{$i/tei:desc/node()}</div> else '',
                    "image": 
                        if ($i/tei:idno[@type="image"]/string()) then 
                            xmldb:encode-uri('../andersen-data/data/images/' || $i/tei:idno[@type="image"]/string()) 
                        else ''
                    }
    
};