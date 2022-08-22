// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
// require("jquery")
//= require @nathanvda/cocoon
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require select2
//= require cocoon
//= require_tree

// let i = 1;
console.log('hello');

$(function () {
    $("#projects .pagination .page-link").on('click', '.page-item', function () {
        console.log("cl")
        $.getScript(this.href);
        return false;
    });
    $("#projects_search input").keyup(function(){
        $.get($("#projects_search").attr('action'), $("#projects_search").serialize(), null, "script");
        return false;
    });

});
