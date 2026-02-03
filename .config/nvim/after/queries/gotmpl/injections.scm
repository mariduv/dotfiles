;; extends

; Also requires plugins/gotmpl-combined.lua

((text) @injection.content
  (#inject-go-tmpl!)
  (#set! injection.combined))
