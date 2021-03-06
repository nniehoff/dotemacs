;;;;;;;;;;
; Header ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; nick.niehoff's .emacs                                                        ;
;                                                                              ;
; My living, breathing .emacs                                                  ;
; Perfection is an elusive, mythical creature that I have yet to catch.        ;
;                                                                              ;
; A word on formatting. Each section has a short description of what kind of   ;
; information is contained therein. By convention a line of comments should    ;
; not exceed col 79.                                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;
; License ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Copyright 2017  Nick Niehoff                                               ;
;                                                                              ;
;   Licensed under the Apache License, Version 2.0 (the "License");            ;
;   you may not use this file except in compliance with the License.           ;
;   You may obtain a copy of the License at                                    ;
;                                                                              ;
;       http://www.apache.org/licenses/LICENSE-2.0                             ;
;                                                                              ;
;   Unless required by applicable law or agreed to in writing, software        ;
;   distributed under the License is distributed on an "AS IS" BASIS,          ;
;   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   ;
;   See the License for the specific language governing permissions and        ;
;   limitations under the License.                                             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;
; Change Log ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Fri, Nov 15 2013  13:11                                                      ;
; Cleanup, added nav and enabled semantic.                                     ;
;                                                                              ;
; ---------------------------------------------------------------------------- ;
;                                                                              ;
; Mon, Jun 17 2013  20:46                                                      ;
; Added markdown-mode, migrated fuctions to myfuncs.el                         ;
;                                                                              ;
; ---------------------------------------------------------------------------- ;
;                                                                              ;
; Mon, Jun 17 2013  16:36                                                      ;
; Major clean up and implementation of some new fcns. Start of change log.     ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;
; Basic Settings ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This section contains basic settings controlling emacs. They typically do    ;
; not have any dependencies on 3rd party lisp functions, etc.                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Load personal functions
(load "~/dotemacs/.elisp/myfuncs.el")

; Set text-mode as the default major mode
(setq-default major-mode 'text-mode)

; Add extension types 
(setq auto-mode-alist (cons '(".wsdl" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".xsd" . nxml-mode) auto-mode-alist))

; Replaces the audible bell with a visual flash
(setq visible-bell 1)

; Set the default directory (this may need to be changed based b/c of os)
(setq default-directory 
      (if (getenv "HOME") (getenv "HOME") "~/"))

; Highlights the current line
(global-hl-line-mode 1)

; Forces no blinking cursor
(blink-cursor-mode 0)

; Forces the block cursor
(setq bar-cursor nil)

; Turn off the toolbar
(if window-system
    (tool-bar-mode 0))

; Force the font lock mode to true, this will enable syntax highlighting
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

; Format the title bar and the icons
(setq frame-title-format '("%f [mode: %m]" ) ; "filename [mode]" in title bar
      icon-title-format '("emacs: %b"))      ; "emacs: buffername" in icon

; Display the time in the mode line
(display-time-mode 1)

; Force the line and column numbers in the bar
(line-number-mode 1)
(column-number-mode 1)

; Removes the ugly splash screen
(setq inhibit-splash-screen t)

; Indentation and tab handling
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

; Setup the emacs desktop This is a PITA
; (desktop-save-mode 1)

; Due to a bug use different desktop files if you are in gui or console
;(if window-system
;    (setq desktop-base-file-name ".emacs-desktop.gui")
;  (setq desktop-base-file-name ".emacs-desktop.console"))

; Highlight matching parenthesis
(show-paren-mode 1)

; Backup file handling
(setq make-backup-files nil) ; do not create backup files

; Let your yes be yes and your no be no
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

; Don't word wrap
;(toggle-truncate-lines t)

; This handles loaded buffers with the same name
; The reverse means that the name is first followed by the directory.
; For example, tmp/Mod.java and temp/Mod.java would be presented as:
; Mod.java\tmp and Mod.java\temp. This is nice because it doesn't
; mess with the buffer switching autocomplete.
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;;;;;;;;;;;;;;;;;;;;;;;;;
; Third Party Functions ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Adds functionality provided by third party packages.                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Add the script directory
(add-to-list 'load-path "~/dotemacs/.elisp")

;; Enable SVN support
(require 'psvn)

; Add Git support
(add-to-list 'load-path "~/dotemacs/.elisp/git")
(require 'git)
(require 'git-blame)

;; For themes, I use the color-theme package.
;; http://www.nongnu.org/color-theme
;; http://www.emacswiki.org/emacs/ColorTheme
(add-to-list 'load-path "~/dotemacs/.elisp/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-gruber-darker))
  )
;; Select by M-x color-theme TAB RET
;; Or by M-x color-theme-select

; Loads the linum code (displays line numbers in the gutter)
; You must load this after you initialize the theme else the gutter numbers 
; will be funky colors.
(require 'linum)
(global-linum-mode 1)

; A simple little table editing mode that gives you a simple spreadsheet style 
; of editing. Tables can also be saved to HTML.
;(require 'table)
;(add-hook 'text-mode-hook 'table-recognize)

; A cool template capability
(load "~/dotemacs/.elisp/defaultcontent/defaultcontent.el")
(require 'defaultcontent)
(setq dc-auto-insert-directory "~/dotemacs/.elisp/defaultcontent/templates/")
(setq dc-fast-variable-handling t)

; Add templates here
(add-to-list 'dc-auto-insert-alist '("\\.cs$" . "template.cs"))
(add-to-list 'dc-auto-insert-alist '("\\.xsd$" . "template.xsd"))
(add-to-list 'dc-auto-insert-alist '("\\.java$" . "template.java"))
(add-to-list 'dc-auto-insert-alist '("\\.wsdl$" . "template.wsdl"))

; For auto completion within a buffer.
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/dotemacs/.elisp/ac-dict")
(ac-config-default)

; Org mode!!!
(setq load-path (cons "~/dotemacs/.elisp/org-7.8.03/lisp" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

; Mark it down, way down.
(require 'markdown-mode)
;autoload 'markdown-mode "markdown-mode"
;   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

; Saves the previous layout
(desktop-save-mode 1)


; Starts with a new junk buffer
(add-hook 'after-init-hook 
          '(lambda () 
          (switch-to-buffer 
          (get-buffer-create "*junk*"))))

; Semantic setup for IDE-like behavior
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
 
(semantic-mode 1)

(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

; A simple directory/source navigation tool 
(add-to-list 'load-path "~/dotemacs/.elisp/emacs-nav-49")
(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
(global-set-key [f8] 'nav-toggle)

; Set up Auto Complete
(require 'package)
;; If you want to use last tagged version
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
; Initialize package.el
(package-initialize)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path
              "~/dotemacs/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include")
)
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

; Fix iedit bug in Mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

; start flymake-google-cpplint-load
; let's define a function for flymake initialization
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/cpplint"))
  (flymake-google-cpplint-load)
)
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

; start google-c-style with emacs
(add-to-list 'load-path
              "~/dotemacs/plugins/google-c-style")
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode
(global-ede-mode 1)
; you can use system-include-path for setting up the system header file locations.
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)

; load bash completion
(require 'bash-completion)
(bash-completion-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (json-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
