;;; personal-c-mode.el --- Support for the C language -*- lexical-binding: t -*-
(prelude-require-package 'ggtags)

;; define the function for c-mode
(defun personal-c-mode-common-hook ()
  "Personal settings for C/C++ modes, overriding Prelude defaults."

  (when (derived-mode-p 'c-ts-mode 'c++-ts-mode)
    (remove-hook 'c-mode-common-hook 'prelude-c-mode-common-hook)
    (setq c-ts-mode-indent-style 'linux)
    (setq c-ts-mode-indent-offset 8)))

;; 注意：最后的 't' 参数非常重要！
;; 它表示 "append"（追加），确保你的 hook 在 Prelude 的默认 hook 之后执行，
;; 从而成功覆盖 Prelude 的 k&r 风格，同时保留 Prelude 的 LSP 启动功能。
(add-hook 'c-mode-common-hook 'personal-c-mode-common-hook t)
(add-hook 'c-ts-mode-hook 'personal-c-mode-common-hook t)
(add-hook 'c++-ts-mode-hook 'personal-c-mode-common-hook t)

;; define the function for ggtags-mode
(defun personal-ggtags-mode-hook ()
  ;; 增加了对 c-ts-mode 和 c++-ts-mode 的支持
  (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'c-ts-mode 'c++-ts-mode)
    (ggtags-mode 1)))

;; 同样将 ggtags 挂载到所有相关的 hook 上
(add-hook 'c-mode-common-hook 'personal-ggtags-mode-hook)
(add-hook 'c-ts-mode-hook 'personal-ggtags-mode-hook)
(add-hook 'c++-ts-mode-hook 'personal-ggtags-mode-hook)

(provide 'personal-c-mode)
;;; personal-c-mode.el ends here
