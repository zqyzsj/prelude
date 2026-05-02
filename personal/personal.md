# My personal prelude config

## Preliminaries of the Prelude project

### The loading sequence of the prelude config files
The loading sequence of the prelude config files is as follows.

1. personal/preload/*
2. core/
3. personal/prelude-modules.el (or deprecated prelude-modules.el)
4. personal/*

The `personal/prelude-modules.el` is a `enable/disable' file for which you use to chose your language modes. The default prelude project does not has a `personal/prelude-module.el` file, but it contains a sample file in the `sample/prelude-modules.el`. Each user can copy the sample file to the personal directory, and then enable/disable the language modes he/she needs. For example, I need the c-mode and rust-mode, so I uncomment the following modes in the prelude-modules.el.

```
(require 'prelude-c)
(require 'prelude-rust)
```

### How to customize your own config file
You'd better not modify any files of the prelude project, and only add your own config files in the personal directory. This helps you to update the prelude project from the upstream easily, and do not need to deal with conflicts with the upstream. I recommend customizing your prelude config files as the following steps.

1. Copy the `sample/prelude-modules.el` to `personal/prelude-modules.el`, and uncomment your needed language modes.
2. Put your config files of language into the personal directory, the prelude project will automatically load these files, and you don't need to load them manually. In my config, I add my own c-mode and rust-mode config files.

### How to write your own language mode files
Usually, the prelude project has a config file for the language you will use, such as C and Rust. If the prelude default config file does not match your requirements, the prelude provides a way to use your own config file without modifying the prelude config files.

The prelude config file for some programming language is in the `modules/prelude-X.el` file. The prelude config file usually is programmed in the following way.
1. In the file, the settings of the programming language is defined as a lisp function, usually in the form of `prelude-x-mode-defaults`, for example, the `prelude-c-mode-common-defaults` and `prelude-rust-mode-defaults`.
2. The prelude defines a variable to record the function, usually in the form of `prelude-x-mode-hook` (`prelude-c-mode-common-hook` and `prelude-rust-mode-hook` for C and Rust respectively): `(setq prelude-x-mode-hook 'prelude-x-mode-defaults)`.
3. The programming language's hook adds the hook variable: `(add-hook 'x-mode-hook (lambda() (run-hooks 'prelude-x-mode-hook)))`.

The above programming mode allows us to customize our own settings for some programming language's mode without modifying the prelude files.
1. Set the prelude hook variable to be nil: `(setq prelude-x-mode-hook nil)`. This disable all the settings of the prelude default config file.
2. Write our setting function for the programming language, and set the programming language's hook to be our setting function.

## personal-c-mode.el: my config files of c-mode and ggtags

### Enable c-ts-mode and c++-ts-mode
The new Emacs has built-in tree-sitter, so prelude prefer to c-ts-mode than c-mode and prelude's default c-mode setting maps the c-mode/c++-mode to c/c++-ts-mode. To enable c/c++-ts-mode in Emacs, the following two conditions should be satisfied.
1. The Emacs you installed indeed has built-in tree-sitter. This can be checked by evaluating `M-: (treesit-available-p)` or `M-: (fboundp 'treesit-ready-p)`. If the result is `t`, then the Emacs has built-in tree-sitter, otherwise, if the evaluation result is `nil`, then the Emacs has no tree-siter support.
2. Make sure that Emacs can find the tree-sitter grammer for the language, so we should install the tree-sitter grammer for the languages. This can be done by `M-x treesit-install-language-grammar` and then select the corresponding languages, such as c/cpp (the url of the tree-sitter is: /tree-sitter-c/cpp/rust.git).

Note. Emacs has built-in tree-sitter, so the `tree-sitter` and `tree-sitter-langs` packages are not required.

### C Style setting
I use my own config for c-ts-mode for C programming language, so I add a personal-c-mode.el in the personal directory. Before setting my own C style, I need to remove the setting of prelude-c.el by disabling the prelude-c-mode hook: `(remove-hook 'c-mode-common-hook 'prelude-c-mode-common-hook)`.

I like Linux kernel style for C, so I set the following two variables for c-ts-mode.
```
(setq c-ts-mode-indent-style 'linux)
(setq c-ts-mode-indent-offset 8)
```

I prefer to ggtags rather than the lsp for c-mode/cc-mode because ggtags does not need to compile the project. So I first install the global for tags generation, and then set the ggtags-mode in the personal-c-mode.el.
```
# install global for gtags
zsh%brew install global
# use gtags command to generate tags in the C source directory
zsh%gtags
```

## personal-macos-keys.el
In mac book pro keyboard, control (C) is bounded to the control key, meta (M) is bounded to the option key, and super (S) is bounded to the command key. Because the control key and option key are so close and the S key is not used very frequently (until now, I haven't used it yet), swapping the command and option mappings is recommended. So I add the personal-macos-keys.el in the personal directory.
```
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
```

## Issues encountered when using prelude

### Issue 1. Vertico detected an error
When first initializing Emacs using the my prelude, the `C-x C-f` command encounters the Vertico error. Recompile the `marginalia` and `vertico` packages can solve the issue.
```
M-x: package-recompile RET marginalia RET
M-x: package-recompile RET vertico RET
```
