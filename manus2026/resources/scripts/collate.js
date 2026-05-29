/*Juxtavisning, Karsten Kynde 2016-04-08*/
/*Juxta/CollateXvisning, KK 2020-04-18*/

var allVar, query_done= "";

window.onload= function() {
  var Wits= document.querySelectorAll("th"),
      Inputs= document.querySelectorAll("input"),
      $Anchor=  document.querySelectorAll( "a" ),
      i;
  allVar= "";
  for( i=0 ; i<Wits.length ; i++ ) {
    allVar= allVar + Wits[i].className;
  }
  for( i=0 ; i<Inputs.length ; i++ ) {
    Inputs[i].checked= "checked";
  }
  for( i=0 ; i<$Anchor.length ; i++ ) {
    $Anchor[i].addEventListener( "click", function() {
    var x= "675", y= screen.availHeight-100,
        w= window.open( this.href, this.target, "width="+x+",height="+y+",resizable=yes,scrollbars=yes,status=no,menubar=no,titlebar=no,location=yes",true);
    w.focus();
    return false;
 }, false );
  }
  var hash= window.location.hash;
  if ( hash && hash!=query_done ) { // position new window on hash
    window.location= hash;
    query_done= hash;
    window.scrollBy( 0,-50 );
  }
}

//var toggleStart; 

function toggleCol( chkd, juxId ) {
  //var start= new Date(); toggleStart= start.getTime();
  var cmd, head= document.getElementById("head-"+juxId);
  blinkdrop( head, "Kolonnen "+(chkd?"vises":"fjernes") );
  //console.log( "Ok, here we go! -- "+chkd+" -- "+juxId );
  cmd= "do" + (chkd ? "Show" : "Hide" ) + "('" + juxId + "')";
  window.setTimeout( cmd, 100 );
}

function doShow( juxId ) {
  showCol( juxId );
  showVar( juxId );
  blankdrop( document.getElementById("head-"+juxId) );
  //var end= new Date();
  //console.log( "The end of the show -- "+(end.getTime()-toggleStart)+"ms" );
}

function doHide( juxId ) {
  hideCol( juxId );
  hideVar( juxId );
  blankdrop( document.getElementById("head-"+juxId) );
  //var end= new Date();
  //console.log( "The end of the hide -- "+(end.getTime()-toggleStart)+"ms" );
}

function hideCol( juxId ) {
  // hide the coloumn belonging to the edition identified by juxId
  var COL= document.querySelectorAll( "div" );
  for( var i=0 ; i<COL.length ; i++) {
    if( COL[i].className=="col-"+juxId ) {
      COL[i].style.display= "none";
    }
  }
  allVar= allVar.replace( juxId, "" );
}

function showCol( juxId ) {
  var COL= document.querySelectorAll( "div" );
  for( var i=0 ; i<COL.length ; i++) {
    if( COL[i].className=="col-"+juxId ) {
      COL[i].style.display= "block";
    }
  }
  allVar= allVar+juxId;
}

function hideVar( juxId ) { // hide variants of the edition juxId
  var V= document.querySelectorAll( "span" ),
      classSet, classArr;
  for( var i=0 ; i<V.length ; i++) {
    V[i].className= V[i].className.replace( juxId, "_"+juxId );
      // disguise it by prefixing with "_"
    classArr= V[i].className.split( " " );
    classSet= allVar;
    for( var j=0 ; j<classArr.length ; j++ ) {
      classSet= classSet.replace( classArr[j], "" );
    }
    if( classSet=="" ) { // all variants are present
      V[i].className= V[i].className.replace( /(^| )([^ _]+)/g, "$1.$2" );
        // disguise the rest by prefixing with "."
      if( V[i].textContent=="^" )
        V[i].style.display= "none";
    }
  }
}

function showVar( juxId ) {
  var V= document.querySelectorAll( "span" ),
      classSet, classArr;
  for( var i=0 ; i<V.length ; i++) {
    V[i].className= V[i].className.replace( "_"+juxId, juxId );
    V[i].className= V[i].className.replace( /\./g, "" );
    V[i].style.display= "inline";
    classArr= V[i].className.split( " " );
    classSet= allVar;
    for( var j=0 ; j<classArr.length ; j++ ) {
      classSet= classSet.replace( classArr[j], "" );
    }
    if( classSet=="" ) { // all variants are present
      V[i].className= V[i].className.replace( /(^| )([^ _]+)/g, "$1.$2" ); 
        // disguise the rest
      if( V[i].textContent=="^" )
        V[i].style.display= "none";
    }
  }
}

function blankdrop( droparea ) {
  droparea.innerHTML= ""; 
  }

function blinkdrop( droparea, msg ) {
  if ( !msg ) { msg= "Vent"; }
  droparea.innerHTML= "<span style=\"text-decoration:blink;background-color:magenta;color:white\">"+msg+" ...</span>"; 
  }