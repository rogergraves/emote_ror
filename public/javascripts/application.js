// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function setContentWin(){
    var el = $("#content-win-centr");
    var win_height = $(window).height();
    var doc_height = $(document).height();
    if(win_height < doc_height){
	//centring by document
	var top = Math.ceil((doc_height - 400) / 2);
	el.css({'top' : top + 'px', 'margin-top' : '0'});
    }else{
	el.css({'top' :'50%', 'margin-top' : '-200px'});
    }
}




$(document).ready(function(){
    setContentWin();
    $(window).resize(function() {
	setContentWin();
    });

    $("#buttons .dropdown").mouseenter(function(){
	var el = $(this).children("ul:first");
	if(el.is(':hidden')){
	    el.animate({height: 'toggle'},100);
	    var el_img = $(this).children("a:first").children("div:first");
	    if(! el_img.hasClass('on')) el_img.addClass('over').removeClass('off');
	}
    }).mouseleave(function(){
	var el = $(this).children("ul:first");
	if( ! el.is(':hidden')){
	    el.animate({height: 'toggle'},100);
	    var el_img = $(this).children("a:first").children("div:first");
	    if(! el_img.hasClass('on')) el_img.addClass('off').removeClass('over');
	}
    });

    $(".menu-body li").hover(
	function(){
	    $(this).children('a:first').css({'color' : '#000000'});
	},
	function(){
	    $(this).children('a:first').css({'color' : '#aaaaaa'});
	}
    );
});