;;; personal-macos-keys.el --- support for the key bindings for macos

;;; swap the option and command key bindings
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)   ;; 让 Command 变成 Meta
  (setq mac-option-modifier 'super))  ;; 让 Option 变成 Super

(provide 'personal-macos-keys)
