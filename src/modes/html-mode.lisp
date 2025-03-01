(defpackage :config/html-mode 
  (:use :cl :lem))
(in-package :config/html-mode)

;; HTML mode
(lem-lsp-mode/lsp-mode::define-language-spec (html-spec lem-html-mode:html-mode)
  :language-id "html"
  :root-uri-patterns '("index.html" ".html")
  :command '("vscode-html-language-server" "--stdio")
  :connection-mode :stdio)
