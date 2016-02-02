;;(add-to-list 'load-path "~/")
;;(require 'cua)
;;(CUA-mode t)
;;
;;(add-to-list 'load-path "/data/git/go-mode.el/")
;;(require 'go-mode-autoloads)
(require 'speedbar)
(speedbar-change-initial-expansion-list "buffers")
(global-set-key  [f8] 'speedbar-get-focus)
(show-paren-mode 1) 
(global-set-key "%" 'match-paren)
          
          (defun match-paren (arg)
            "Go to the matching paren if on a paren; otherwise insert %."
            (interactive "p")
            (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
                  ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
                  (t (self-insert-command (or arg 1)))))

(which-function-mode 1)

(add-hook 'c-mode-common-hook 
  (lambda ()
    (which-function-mode t)))

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(auto-show-mode t t)
 '(case-fold-search t)
 '(cua-highlight-region-shift-only t)
 '(cua-mode t)
 '(cua-remap-control-v t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t nil (paren))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(cua-mode t)
    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
    (transient-mark-mode 1)               ;; No region when it is not highlighted
    (setq cua-keep-region-after-copy t) 
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
(global-set-key [(meta m)] 'menu-bar-open)
(global-set-key [(control o)] 'find-file)              ; use Ctrl-o to open a (new) file
(global-set-key [(control n)] 'find-file-other-frame)  ; open a file in a new window with Ctrl-n
(global-set-key [(control s)] 'save-buffer)            ; save with Ctrl-s
(global-set-key [(meta s)]    'write-file)             ; 'save file as...' with Alt-s ('meta' is
                                                       ; just another name for the 'Alt' key)
(global-set-key [(control q)] 'save-buffers-kill-emacs); exit XEmacs with Ctrl-q
(global-set-key [(meta q)]    'kill-this-buffer)       ; delete changes (don't save) with Alt-q

(global-set-key [(control t)] 'ispell-buffer)          ; spell-check with Ctrl-t
(global-set-key [(control r)] 'replace-string)         ; search and replace with Ctrl-r
(add-to-list 'load-path' "~/")
;;(require 'redo)                                        ; load the 'redo' package
;(global-set-key [(meta z)]    'redo)                   ; 'redo', that is, revert the last 'undo'
;;(global-set-key [(control u)] 'redo)
;(require 'redo+)

; A first attempt to make "control z" work as undo. 
(global-set-key [(control z)] 'undo)

; The above does not work on newer versions of XEmacs. Then, highjack 
; Xemacs's zap-up-to-char function itself and force it to work as "undo".
(defun zap-up-to-char () 
  (interactive) 
  (undo)
)

; search forward with Ctrl-f
(global-set-key [(control f)] 'isearch-forward)
(define-key isearch-mode-map [(control f)] (lookup-key isearch-mode-map "\C-s"))
(define-key minibuffer-local-isearch-map [(control f)]
  (lookup-key minibuffer-local-isearch-map "\C-s"))

; search backward with Alt-f
(global-set-key [(meta f)] 'isearch-backward)
(define-key isearch-mode-map [(meta f)] (lookup-key isearch-mode-map "\C-r"))
(define-key minibuffer-local-isearch-map [(meta f)]
  (lookup-key minibuffer-local-isearch-map "\C-r"))

(global-set-key [f5] 'ebrowse-tree-mode)
(add-to-list 'auto-mode-alist '("BROWSE\\.*" . ebrowse-tree-mode))
(setq load-path (cons "/usr/share/emacs/site-lisp/" load-path))
;;(require 'xcscope)

;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(defun my-isearch-yank-clipboard ()
  (interactive)
  (isearch-yank-string (or (x-get-selection 'PRIMARY)
                           (x-get-selection 'CLIPBOARD)
                           "")))

(define-key isearch-mode-map (kbd "M-s c") 'my-isearch-yank-clipboard)

(setq c-default-style "linux"  c-basic-offset 4)

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;;   ;; Your init file should contain only one such instance.
      '(indent-tabs-mode nil))
  
(setq default-tab-width 4)

(set-default-font "-Misc-Fixed-Medium-R-Normal--20-200-75-75-C-100-ISO8859-1")
(modify-frame-parameters nil '((wait-for-wm . nil)))

(global-set-key "\C-l" 'goto-line)

(which-function-mode)

(setq mode-line-format (delete (assoc 'which-func-mode
                                      mode-line-format) mode-line-format)
      which-func-header-line-format '(which-func-mode ("" which-func-format)))
(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (setq mode-line-format (delete (assoc 'which-func-mode
                                          mode-line-format) mode-line-format)
          header-line-format which-func-header-line-format)))


(setq line-number-mode t)
	
;; Set a Mode Line that tells me which machine, which directory,
     ;; and which line I am on, plus the other customary information.
     (setq-default mode-line-format
      (quote
       (#("-" 0 1
          (help-echo
           "mouse-1: select window, mouse-2: delete others ..."))
        mode-line-mule-info
        mode-line-modified
        mode-line-frame-identification
        (line-number-mode " Line %l ")
        "    "
        mode-line-buffer-identification
        "    "
        
        (:eval (substring
                (system-name) 0 (string-match "\\..+" (system-name))))
        ":"
        default-directory
        #(" " 0 1
          (help-echo
           "mouse-1: select window, mouse-2: delete others ..."))
        global-mode-string
        #("   %[(" 0 6
          (help-echo
           "mouse-1: select window, mouse-2: delete others ..."))
        ;;(:eval (mode-line-mode-name))
        mode-line-process
        minor-mode-alist
        #("%n" 0 2 (help-echo "mouse-2: widen" local-map (keymap ...)))
        ")%] "
        (-3 . "%P")
        ;;   "-%-"
        )))
;;(ido-mode 1)
(defvar my-shells
  '("*shell0*" "*shell1*" "*shell2*" "*shell3*"))
(defun make-my-shell-output-read-only (text)
  "Add to comint-output-filter-functions to make stdout read only in my shells."
  (if (member (buffer-name) my-shells)
      (let ((inhibit-read-only t)
            (output-end (process-mark (get-buffer-process (current-buffer)))))
        (put-text-property comint-last-output-start output-end 'read-only t))))
(add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)

(global-set-key [C-tab] 'next-buffer)
(setq grep-command "grep -r -nH ")
(global-set-key "\C-g" 'grep)
;;(global-set-key "\C-i" 'compile)
;;(global-set-key "\C-e" 'term)
;;(global-set-key "\C-e" 'alt-shell-dwim)
(custom-set-variables
 '(comint-prompt-read-only t))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
 (defun alt-shell-dwim (arg)
   "Run an inferior shell like `shell'. If an inferior shell as its I/O
 through the current buffer, then pop the next buffer in `buffer-list'
 whose name is generated from the string \"*shell*\". When called with
 an argument, start a new inferior shell whose I/O will go to a buffer
 named after the string \"*shell*\" using `generate-new-buffer-name'."
   (interactive "P")
   (let* ((shell-buffer-list
 	  (let (blist)
	     (dolist (buff (buffer-list) blist)
	       (when (string-match "^\\*shell\\*" (buffer-name buff))
	 	(setq blist (cons buff blist))))))
	  (name (if arg
	 	   (generate-new-buffer-name "*shell*")
	 	 (car shell-buffer-list))))
     (shell name)))


(defun create-shell ()
    "creates a shell with a given name"
    (interactive);; "Prompt\n shell name:")
    (let ((shell-name (read-string "shell name: " nil)))
    (shell (concat "*" shell-name "*"))))


