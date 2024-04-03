// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

import "controllers"
import "trix"
import "@rails/actiontext"

import "popper"
import "bootstrap"

//= require jquery
//= require jquery-ui
//= require jquery_ujs

console.log('Hello World from application.js');
