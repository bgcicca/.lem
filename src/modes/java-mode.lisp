(defpackage :config/java-mode 
  (:use :cl :lem))
(in-package :config/java-mode)

(lem-lsp-mode/lsp-mode::define-language-spec (java-spec lem-java-mode:java-mode)
  :language-id "java"
  :root-uri-patterns '("pom.xml" "build.gradle" "build.xml" ".project")
  :command '("jdtls")
  :connection-mode :stdio)
