(asdf/parse-defsystem:defsystem "lem-site-init"
  :depends-on ("lem-pareto")
  :components ((:module "src"
                :components ((:file "editor-config")
                             (:file "themes")
                             (:file "keybindings")
                             (:file "completions")
                             (:file "repl")
                             (:module "modes"
                              :components ((:file "lisp-mode")
                                           (:file "guile-mode")
                                           (:file "java-mode")
                                           (:file "c-mode")
                                           (:file "css-mode")
                                           (:file "html-mode")
                                           (:file "javascript-mode")))))))
