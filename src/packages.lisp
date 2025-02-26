(in-package :lem)

(lem-extension-manager:lem-use-package
 "lisp-critic"
 :source (:type :git
          :url "https://github.com/g000001/lisp-critic.git"))

(lem-extension-manager:lem-use-package
 "arrow-macros"
 :source (:type :git
          :url "https://github.com/hipeta/arrow-macros.git"))

(sb-ext:unlock-package :lem)
(use-package :lisp-critic)
(use-package :arrow-macros)
(sb-ext:lock-package :lem)
