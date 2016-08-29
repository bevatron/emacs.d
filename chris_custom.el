(setq system-time-locale "C")

;;; set global
(define-prefix-command 'gtag-map)
;;(global-set-key (kbd "C-c s") 'gtag-map)
;;(global-set-key (kbd "C-c s a") 'cscope-set-initial-directory)
;;(global-set-key (kbd "C-c s r") 'cscope-unset-initial-directory)
;;(global-set-key (kbd "C-c s i") 'cscope-index-files)

;;; personal command prefix
(define-prefix-command 'my-map)
(global-set-key (kbd "M-`") 'my-map)
;;(global-set-key (kbd "C-c s a") 'cscope-set-initial-directory)
;;(global-set-key (kbd "C-c s r") 'cscope-unset-initial-directory)
;;(global-set-key (kbd "C-c s i") 'cscope-index-files)

;;; set cscope
(setq cscope-option-use-inverted-index 't)
(setq cscope-option-do-not-update-database 't)

;;(global-set-key (kbd "M-<f7>") 'cscope-find-egrep-pattern)
;;(global-set-key (kbd "M-<f6>") 'cscope-find-this-symbol)
;;(global-set-key (kbd "M-<f5>") 'cscope-display-buffer-toggle)
(global-set-key (kbd "M-<f4>") 'cscope-find-egrep-pattern)
(global-set-key (kbd "M-<f3>") 'cscope-find-called-functions)
(global-set-key (kbd "M-<f2>") 'cscope-pop-mark)
(global-set-key (kbd "M-<f1>") 'cscope-find-global-definition-no-prompting)

;;; set ag
(defun ag-project-under-cursor ()
  "find the word under cursor using ag-project"
  (interactive)
  (ag-project (thing-at-point 'symbol))
  )
(global-set-key (kbd "M-` M-h") 'ag-project-under-cursor)

;;; set exit keybindings
;;(global-set-key (kbd "S-<f12>") 'save-buffers-kill-terminal)
;;(global-unset-key (kbd "C-x C-c"))

;;; remove memubar
(menu-bar-mode -1)

;;; set dired details  by default
(setq dired-details-initially-hide 'nil)
(setq diredp-hide-details-initially-flag 'nil)
;;; set dired to reuse buffers
(toggle-diredp-find-file-reuse-dir 1)
;;;(setq dired-details-hidden-string "[...]")

;;; set ignore buffers
(setq ido-ignore-buffers '("*Ibuffer" "*Minibuf-1"))

;;; set ibuffer sort by recent
(setq ibuffer-sorting-mode 'recency)

;;; set font size
(set-default-font "DejaVu Sans Mono-14")

;;; set global file name abbreviation length
;;(setq ggtags-global-abbreviate-filename 120)

;;; set comment face to a lighter one
;;(set-face-foreground 'font-lock-comment-face "#7A8F94")

;;; set which function font
;;(set-face-foreground 'which-func "yellow")

;;; set hightlight region if no window system

(if (not window-system)
    (progn
;;      (set-face-attribute 'region nil :background "gray" :foreground "blue")
      (define-key global-map (kbd "C-@") 'set-mark-command)
      (define-key global-map (kbd "M-@") 'er/expand-region)
      (define-key global-map (kbd "C-M-2") 'er/contract-region)
      (set-face-foreground 'diredp-dir-heading "black")
;;      (set-face-background 'ggtags-global-line "blue")
      )
  )
(define-key global-map (kbd "M-@") 'er/expand-region)
;;; set proxy
;; (setq url-proxy-services '(("http" . "127.0.0.1:8087")
;; 			   ("https" . "127.0.0.1:8087")
;;                ;; ("socks" . "proxy01-socks.sc.intel.com:1080")
;;                )
;; )

;;; set indent tab
;;(toggle-indent-tab)
;;; reset ret to just start a newline
;;;(define-key global-map (kbd "RET") 'newline)

;;; set sr-speedbar
;;(setq speedbar-show-unknown-files t)
;;(setq speedbar-use-images nil)
;;(setq sr-speedbar-width-x 30)
;;(setq sr-speedbar-right-side nil)

;;; set man page width
(setenv "MANWIDTH" "72")

;;; c-style
(require 'fill-column-indicator)

;;Define own hook
(defun MyCHook ()
  (setq c-doc-comment-style
        '((c-mode . 'gtkdoc)
          (c++-mode . 'gtkdoc)
          ))

  (fci-mode)
  (setq fci-rule-column '80)
  (setq fci-rule-width 5)

  (require 'whitespace)
    ;; make whitespace-mode use just basic coloring
    (set-face-attribute 'whitespace-space nil :background nil :foreground "red30")

    (setq whitespace-style '(face trailing lines-tail))
    (setq whitespace-line-column 80)
    (whitespace-mode 1)

  (setq comment-start "/* " comment-end " */")
;;  (c-set-offset 'case-label '+)
  )
(add-hook 'c-mode-hook 'MyCHook)
(add-hook 'c++-mode-hook 'MyCHook)

;;; enable highlight symble
(global-set-key (kbd "M-` M-j") 'highlight-symbol-at-point)
(global-set-key (kbd "M-` M-k") 'highlight-symbol-next)
(global-set-key (kbd "M-` M-h") 'highlight-symbol-prev)
(global-set-key (kbd "M-` M-m") 'highlight-symbol-remove-all)

;;; short key magit-status
(global-set-key (kbd "M-` M-u") 'magit-status)
;;(global-set-key (kbd "s-i") 'popup-which-function)

;;; setup which-func-mode
(setq which-func-modes '(c++-mode c-mode org-mode java-mode))

; blink cursor
(defvar blink-cursor-colors (list  "#92c48f" "#6785c5" "#be369c" "#d9ca65")
  "On each blink the cursor will cycle to the next color in this list.")

(setq blink-cursor-count 0)
(defun blink-cursor-timer-function ()
  "Zarza wrote this cyberpunk variant of timer `blink-cursor-timer'.
Warning: overwrites original version in `frame.el'.

This one changes the cursor color on each blink. Define colors in `blink-cursor-colors'."
  (when (not (internal-show-cursor-p))
    (when (>= blink-cursor-count (length blink-cursor-colors))
      (setq blink-cursor-count 0))
    (set-cursor-color (nth blink-cursor-count blink-cursor-colors))
    (setq blink-cursor-count (+ 1 blink-cursor-count))
    )
  (internal-show-cursor nil (not (internal-show-cursor-p)))
  )

;;; change mouse pointer color
(set-mouse-color "white")

;;; create empty buffer
(defun xah-new-empty-buffer ()
  "Open a new empty buffer.
URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2016-08-11"
  (interactive)
  (let ((-buf (generate-new-buffer "untitled")))
    (switch-to-buffer -buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)))
(global-set-key (kbd "M-` M-s") 'xah-new-empty-buffer)