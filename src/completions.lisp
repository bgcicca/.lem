(defpackage :config/completions
  (:use :cl :lem))
(in-package :config/completions)

(add-hook *prompt-after-activate-hook*         
          (lambda ()           
            (call-command 'lem/prompt-window::prompt-completion nil)))(add-hook *prompt-deactivate-hook*   
                                                                                (lambda ()           
                                                                                  (setf lem-core::*default-prompt-gravity* :bottom-display)
                                                                                  (setf lem/prompt-window::*prompt-completion-window-gravity* :horizontally-above-window)
                                                                                  (setf lem/prompt-window::*fill-width* t)
                                                                                  (lem/completion-mode:completion-end)))
