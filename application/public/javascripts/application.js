// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.facebox.settings.addparam = "facebox";
jQuery.ajaxSetup({'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}})
jQuery(document).ready(function($) {$('a[rel*=facebox]').facebox() })

