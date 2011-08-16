/*
function setContentWin(){
    
    if(sbscrEl){
	if(win_height > 600){
	    var newHeight = win_height - 220;
    	    if(newHeight > 600) newHeight = 600;
	    var margin_top =  Math.ceil(win_height/2) - 10;
	    margin_top = "-" + margin_top;
//	    alert(newHeight);
//	    margin_top =;
	    sbscrEl.css({'height' : newHeight + 'px', 'margin-top' : margin_top + 'px'});
	}else{
	    sbscrEl.css({'height' : '350px', 'margin-top' : '-285px'});
	}
    }
    if(el){
	if(win_height < doc_height){
	//centring by document
	    var top = Math.ceil((doc_height - 400) / 2);
	    el.css({'top' : top + 'px', 'margin-top' : '0'});
	}else{
	    el.css({'top' :'50%', 'margin-top' : '-200px'});
        }
    }
}
*/

function setContentWin(){
//    var el = $("#content-win-control") || $("#content-win-info");
    var el = $("#content-win-control");
    if(!el.size()){
	el = $("#content-win-info");
	var info = true;
    }

    if(! el.size()) return;
    
        
    var hf_height = 140;
    
    var win_height = $(window).height();
    var doc_height = $(document).height();
    var el_height = el.height();
    
    if(doc_height >= win_height){
	var min_height = doc_height - hf_height;
	if(info){
	    min_height -= 38;
	}
	el.css({"min-height" : min_height + "px"});
    }
}

$(document).ready(function(){

    setContentWin();
    $(window).resize(function() {
	setContentWin();
    });

    $("#survey_new .field input[type='text']").keyup( function(){
	$("#input-text").html($(this).val());
    });


    var defaulttext_inputs = $(".defaultText");

    defaulttext_inputs.each(function(index, thisInput){
        $(this).parents('form:first').submit(function(){
            if ($(thisInput).val() == $(thisInput).attr('default_text')){
                $(thisInput).val("");
            }
        })
    });

    defaulttext_inputs.focus(function(src)
    {
        if ($(this).val() == $(this).attr('default_text')){
            $(this).removeClass("defaultTextActive");
            $(this).val("");
        }
    });

    defaulttext_inputs.blur(function()
    {
        if ($(this).val() == ""){
            $(this).addClass("defaultTextActive");
            $(this).val($(this).attr('default_text'));
        }
    });

    defaulttext_inputs.blur();

    $('.locked-selectall').click(function(){
        this.select();
    });
    $('.locked-selectall').attr('readonly', true);


});