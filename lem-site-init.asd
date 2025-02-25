(asdf:defsystem "lem-config"
  :description "My lem config"
  :serial t
  :components ((:file "init")
                :components ((:file "repl")
                             (:file "completions")
                             (:file "keybindings")
                             (:file "prompt"))))