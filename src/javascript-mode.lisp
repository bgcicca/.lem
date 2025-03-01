(defpackage :config/javascript-mode 
  (:use :cl :lem))
(in-package :config/javascript-mode)

(lem-lsp-mode:define-language-spec (javascript-spec lem-js-mode:js-mode)
  :language-id "javascript"
  :root-uri-patterns '("package.json" "tsconfig.json")
  :command '("typescript-language-server" "--stdio")
  :install-command "npm install -g typescript-language-server typescript"
  :readme-url "https://github.com/typescript-language-server/typescript-language-server"
  :connection-mode :stdio)