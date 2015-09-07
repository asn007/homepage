function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (error) {
buf.push("<!DOCTYPE html><html><head><meta charset=\"utf-8\"></head><body>" + (jade.escape((jade_interp = error.status) == null ? '' : jade_interp)) + "<br>Error: " + (jade.escape((jade_interp = error.message) == null ? '' : jade_interp)) + "<br>Stack:<br><pre>" + (jade.escape((jade_interp = error.stack) == null ? '' : jade_interp)) + "</pre></body></html>");}.call(this,"error" in locals_for_with?locals_for_with.error:typeof error!=="undefined"?error:undefined));;return buf.join("");
}