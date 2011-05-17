jQuery(function(){
    // search todos
    jQuery("#search_query").live('keyup', function() {
        var query = jQuery(this).val();
        jQuery.ajax({
            type: 'get',
            url: '/todos/search',
            dataType: "script",
            data: {
                'query': query
            },
                    
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept", "text/javascript");
                jQuery('#loading').show();
            },
            complete: function(){
                jQuery('#loading').hide();
            },
            success: function(g) {
            }
        });
    
    });
    
    jQuery("#todo_status").live('click', function() {
        var status = jQuery(this).is(':checked')
        var todo_id = jQuery(this).closest('tr').attr('title');
        var base_item = jQuery(this).closest('tr');
        //        console.log();
        jQuery.ajax({
            type: 'post',
            url: '/todos/update_todo_status',
            dataType: "script",
            data: {
                'status': status, 
                'todo_id': todo_id
            },
                    
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept", "text/javascript");
                jQuery('#loading').show();
            },
            complete: function(){
                jQuery('#loading').hide();
            },
            success: function(g){
                if(g != "Error"){
                    if(status == true){
                        base_item.addClass("mystrike");
                        jQuery("#summary_count").html(g.split('-')[0]);
                        jQuery("#summary_hour").html(g.split('-')[1]);
                        var delete_link = "<a rel='nofollow' data-method='delete' data-confirm='Are you sure?' href='/todos/" + todo_id + "'>Destroy</a>"
                        base_item.children().last().html(delete_link);
                    }else{
                        base_item.removeClass("mystrike");
                        jQuery("#summary_count").html(g.split('-')[0]);
                        jQuery("#summary_hour").html(g.split('-')[1]);
                        base_item.children().last().html("");
                    }
                }
            }
        });
    
    });
    
    jQuery( ".select_date" ).datepicker({
        dateFormat: 'dd/mm/yy'
    });
    
    jQuery('.pagination a').live('click',function (){  
        jQuery.getScript(this.href);  
        return false;  
    });


});
