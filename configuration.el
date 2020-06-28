(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(defvar my-packages '(ac-js2
                      ag
                      all-the-icons
                      atomic-chrome
                      auto-complete
                      autopair
                      beacon
                      browse-kill-ring
                      comment-tags
                      company
                      dap-mode
                      dashboard
                      deft
                      dired-subtree
                      dired-narrow
                      diminish
                      doom-modeline
                      dumb-jump
                      editorconfig
                      eglot
                      elfeed
                      elfeed-goodies
                      elixir-mode
                      evil
                      evil-escape
                      evil-leader
                      evil-mc
                      evil-numbers
                      evil-surround
                      enh-ruby-mode
                      exec-path-from-shell
                      eyebrowse
                      exunit
                      fira-code-mode
                      forge
                      flycheck
                      flycheck-credo
                      flycheck-flow
                      flycheck-rust
                      ghub
                      hide-mode-line
                      hydra
                      ido-vertical-mode
                      impatient-mode
                      ini-mode
                      ivy counsel swiper
                      json-mode
                      js2-mode
                      js2-refactor
                      magit
                      markdown-mode
                      neotree
                      package-lint
                      page-break-lines
                      parinfer
                      pdf-tools
                      projectile
                      rainbow-mode
                      rjsx-mode
                      rust-mode
                      ob-restclient
                      org-bullets
                      restclient
                      robe
                      rspec-mode
                      rust-mode
                      sass-mode
                      smartparens
                      smex
                      synosaurus
                      tide
                      visual-fill-column
                      vterm
                      web-mode
                      which-key
                      writegood-mode
                      writeroom-mode
                      yaml-mode
                      zenburn-theme))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

(defun zen-mode ()
  "Default theme and font size."
  (interactive)

  ;; Dark
  (load-theme 'zenburn t)
  (setq frame-background-mode (quote dark))
   )

(zen-mode)

(when (and window-system
           (eq system-type 'darwin)
           (not (version< emacs-version "26.1")))
  (setq frame-title-format nil
        ns-use-proxy-icon nil)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark)))

(toggle-frame-fullscreen)
(autopair-global-mode)

(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; Removes load average from modeline
(setq display-time-default-load-average nil)

(doom-modeline-mode 1)


;; If non-nil, a word count will be added to the selection-info modeline segment.
(setq doom-modeline-enable-word-count nil)

(setq doom-modeline-display-default-persp-name nil)

(setq doom-modeline-project-detection 'projectile)

(setq doom-modeline-buffer-file-state-icon nil)

(dashboard-setup-startup-hook)
 (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
 (setq dashboard-startup-banner 3)
 (setq dashboard-banner-logo-title "Howdy!")
 (setq dashboard-items '((recents  . 5) (bookmarks . 5) (projects . 5)
(agenda . 5)))
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons nil)
(setq dashboard-set-file-icons t)
(setq dashboard-set-footer nil)

(setq gc-cons-threshold 20000000)

(setq make-backup-files nil)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq confirm-kill-emacs 'y-or-n-p)

(fset 'yes-or-no-p 'y-or-n-p)

(global-auto-revert-mode t)

(defun zoom-in ()
  (interactive)
  (let ((x (+ (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(defun zoom-out ()
  (interactive)
  (let ((x (- (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(define-key global-map (kbd "C-1") 'zoom-in)
(define-key global-map (kbd "C-0") 'zoom-out)

(display-time-mode t)

(tool-bar-mode 0)

(add-hook 'org-mode-hook 'auto-fill-mode)

(put 'narrow-to-region 'disabled nil)

(scroll-bar-mode -1)

(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

(setq ring-bell-function 'ignore)

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun kill-dired-buffers ()
  "Kill all open dired buffers."
  (interactive)
  (mapc (lambda (buffer)
          (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
            (kill-buffer buffer)))
        (buffer-list)))

(beacon-mode 1)

(add-hook 'org-mode-hook 'which-key-mode)

(setq dired-mode-map (make-keymap))
(suppress-keymap dired-mode-map)
(define-key dired-mode-map "j" 'dired-next-line)
(define-key dired-mode-map "k" 'dired-previous-line)
(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle)
(define-key dired-mode-map (kbd "<C-tab>") 'dired-subtree-cycle)
(define-key dired-mode-map (kbd "<S-iso-lefttab>") 'dired-subtree-remove)
(define-key dired-mode-map "p"
    (lambda ()
      (interactive)
      (find-alternate-file "..")))

(ac-config-default)

(setq-default tab-width 2)

(setq-default tab-width 2 indent-tabs-mode nil)

(setq-default indent-tabs-mode nil)

(setq js-indent-level 2)

(setq css-indent-offset 2)

(add-hook 'sh-mode-hook
          (lambda ()
            (setq sh-basic-offset 2
                  sh-indentation 2)))

(setq web-mode-markup-indent-offset 2)

(add-hook 'after-init-hook 'global-flycheck-mode)

(define-key global-map (kbd "RET") 'newline-and-indent)

(show-paren-mode t)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(add-hook 'prog-mode-hook '(lambda ()
                             (if (version<= emacs-version "26.0.50")
                                 (linum-mode)
                               (display-line-numbers-mode))))

(setq ruby-indent-level 2)
;; scss-mode blocks Emacs when opening bigger files, so open them with css-mode
(add-to-list 'auto-mode-alist '("\\.scss?\\'" . css-mode))

(add-to-list 'auto-mode-alist '("\\.rb?\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake?\\'" . enh-ruby-mode))

(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)
(add-to-list 'auto-mode-alist '("\\.erb?\\'" . robe-mode))

(add-hook 'enh-ruby-mode-hook 'auto-complete-mode)

(require 'rjsx-mode)
(define-key rjsx-mode-map (kbd "C-c C-r") 'tide-rename-symbol)
(define-key rjsx-mode-map (kbd "C-c C-d") 'tide-documentation-at-point)

(defun setup-tide-mode ()
  (interactive)
  ;; For bigger JS projects and intense tasks like =tide=references=
  ;; the default of 2s will time out
  (setq tide-sync-request-timeout 10)
  (tide-setup)
  ;; Increase sync request timeout for bigger projects
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1))

(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'rjsx-mode-hook #'setup-tide-mode)

;;TSX support
(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . web-mode))
(add-hook 'web-mode-hook
        (lambda ()
          (when (string-equal "tsx" (file-name-extension buffer-file-name))
            (setup-tide-mode))))

(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(setq js2-highlight-level 3)
(setq js-indent-level 2)

(add-hook 'rust-mode-hook 'eglot-ensure)
(add-hook 'rust-mode-hook #'flycheck-rust-setup)

(require 'eglot)
(add-to-list 'eglot-server-programs '((c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)

(require 'eglot)
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs '(elixir-mode "~/Projects/opensource/elixir-ls/release/language_server.sh"))

(require 'dap-elixir)
(dap-ui-mode)
(dap-mode)

(add-to-list 'load-path "~/Projects/opensource/exunit.el")
(require 'exunit)

(add-hook 'prog-mode-hook 'rainbow-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; Ruby templates
(add-to-list 'auto-mode-alist '("\\.erb?\\'" . web-mode))
;; JSON
(add-to-list 'auto-mode-alist '("\\.json?\\'" . web-mode))
;; Svelte
(add-to-list 'auto-mode-alist '("\\.svelte?\\'" . web-mode))

(setq web-mode-enable-current-element-highlight t)
(setq web-mode-ac-sources-alist
  '(("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(add-hook 'markdown-mode-hook 'flyspell-mode)

(add-hook 'markdown-mode-hook 'visual-clean)

(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'with-editor-mode-hook 'evil-normal-state)

(with-eval-after-load 'magit
  (require 'forge))

(with-eval-after-load 'magit
  (magit-add-section-hook 'magit-status-sections-hook 'forge-insert-assigned-issues   nil t)
  (magit-add-section-hook 'magit-status-sections-hook 'forge-insert-assigned-pullreqs   nil t))

(setq projectile-project-search-path '("~/Projects/"))
(projectile-mode +1)

(dumb-jump-mode)
(setq dumb-jump-selector 'ivy)

(eyebrowse-mode t)

(defhydra hydra-projectile (global-map "C-c p"
                            :columns 3
                            :exit t)
  "Projectile"
  ("a" projectile-ag                "Silver Searcher" ) 
  ("b" projectile-switch-to-buffer  "Buffers"         )
  ("c" projectile-invalidate-cache  "Invalidate Cache")
  ("d" projectile-find-dir          "Find directory"  )
  ("f" projectile-find-file         "Find file"       )
  ("s" projectile-switch-project    "Switch project"  )
)

(defhydra hydra-eyebrowse (global-map "C-c w"
                           :columns 3
                           :exit t)
  "Eyebrowse"
    ("p" eyebrowse-prev-window-config             "Previous window"   )
    ("n" eyebrowse-next-window-config             "Next window"       )
    ("l" eyebrowse-last-window-config             "Last window"       )
    ("r" eyebrowse-rename-window-config           "Rename window"     )
    ("c" eyebrowse-create-window-config           "Create window"     )
    ("C" eyebrowse-close-window-config            "Close window"      )
    ("0" eyebrowse-switch-to-window-config-0      "0"                 )
    ("1" eyebrowse-switch-to-window-config-1      "1"                 )
    ("2" eyebrowse-switch-to-window-config-2      "2"                 )
    ("3" eyebrowse-switch-to-window-config-3      "3"                 )
    ("4" eyebrowse-switch-to-window-config-4      "4"                 )
    ("5" eyebrowse-switch-to-window-config-5      "5"                 )
  )

(evil-mode t)
;; Enable "M-x" in evil mode
(global-set-key (kbd "M-x") 'execute-extended-command)

(global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "w" 'basic-save-buffer
  "s" 'flyspell-buffer
  "b" 'evil-buffer
  "q" 'evil-quit)

(global-evil-surround-mode 1)

(global-evil-mc-mode 1)

(define-key evil-normal-state-map (kbd "{") 'evil-next-buffer)
(define-key evil-normal-state-map (kbd "}") 'evil-prev-buffer)

(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

(define-key evil-insert-state-map (kbd "C-v") 'evil-visual-paste)

(mapc (lambda (mode)
       (evil-set-initial-state mode 'emacs)) '(elfeed-show-mode
                                               elfeed-search-mode
                                               forge-pullreq-list-mode
                                               forge-topic-list-mode
                                               dired-mode
                                               tide-references-mode
                                               image-dired-mode
                                               dashboard-mode
                                               image-dired-thumbnail-mode
                                               eww-mode))

(add-hook 'org-mode-hook 'which-key-mode)
(add-hook 'cider-mode-hook 'which-key-mode)

(setq which-key-allow-evil-operators t)
(setq which-key-show-operator-state-maps t)

(setq ORG-DIRECtORY "~/Documents/org/")
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq deft-extensions '("org", "txt"))
(setq deft-directory "~/Documents/org/")

(org-babel-do-load-languages
'org-babel-load-languages
'(
  (shell . t)
  (dot . t)
  (js . t)
  (ruby . t)
  ))

 (add-hook 'org-mode-hook 'auto-fill-mode)

(setq org-todo-keywords
          '((sequence "TODO" "|" "DONE")
            (sequence "PROJECT" "AGENDA" "|" "MINUTES")
            (sequence "WAITING" "|" "PROGRESS")))

(setq org-duration-format 'h:mm)

(custom-set-variables
    '(pdf-tools-handle-upgrades nil))

(setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")

(evil-set-initial-state 'pdf-view-mode 'emacs)
(add-hook 'pdf-view-mode-hook
  (lambda ()
    (set (make-local-variable 'evil-emacs-state-cursor) (list nil))))

(require 'elfeed)
(require 'elfeed-goodies)

(global-set-key (kbd "C-x w") 'elfeed)
(setq-default elfeed-search-filter "@1-week-ago +unread ")
(elfeed-goodies/setup)

(add-hook 'elfeed-show-mode-hook 'visual-clean)

(define-key elfeed-show-mode-map (kbd "C-e") 'evil-scroll-line-down)
(define-key elfeed-show-mode-map (kbd "C-y") 'evil-scroll-line-up)

(load "~/.emacs.d/elfeed-feeds.el")

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-directory "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org")
    (setq org-default-notes-file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/refile.org")
    ;; Use C-c c to start capture mode
    (global-set-key (kbd "C-c c") 'org-capture)

    ;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/journal.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("p" "projects" entry (file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/projects.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

(org-babel-do-load-languages
'org-babel-load-languages
'(
  (shell . t)
  (dot . t)
  (js . t)
  (ruby . t)
  ))

 (add-hook 'org-mode-hook 'auto-fill-mode)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-duration-format 'h:mm)

(custom-set-variables
    '(pdf-tools-handle-upgrades nil))

(setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")

(evil-set-initial-state 'pdf-view-mode 'emacs)
(add-hook 'pdf-view-mode-hook
  (lambda ()
    (set (make-local-variable 'evil-emacs-state-cursor) (list nil))))

(require 'elfeed)
(require 'elfeed-goodies)

(global-set-key (kbd "C-x w") 'elfeed)
(setq-default elfeed-search-filter "@1-week-ago +unread ")
(elfeed-goodies/setup)

(add-hook 'elfeed-show-mode-hook 'visual-clean)

(define-key elfeed-show-mode-map (kbd "C-e") 'evil-scroll-line-down)
(define-key elfeed-show-mode-map (kbd "C-y") 'evil-scroll-line-up)

(load "~/.emacs.d/elfeed-feeds.el")

(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)

(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-vertical-show-count t)

(setq enable-recursive-minibuffers t)
(global-set-key (kbd "<f6>") 'ivy-resume)

(setq ivy-count-format "(%d/%d) ")

(setq ivy-wrap t)

(global-set-key "\C-s" 'swiper)

(global-set-key (kbd "C-x b") 'counsel-ibuffer)
;; Run `counsel-ag` against the current directory and not against the
;; whole project
(global-set-key (kbd "C-c k") '(lambda()
                                 (interactive)
                                 (counsel-ag "" default-directory nil nil)))
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(global-set-key (kbd "M-x") (lambda ()
                              (interactive)
                              (counsel-M-x "")))

(add-hook 'pdf-view-mode-hook '(lambda()
                                 (define-key pdf-view-mode-map "\C-s" 'isearch-forward)))

(setq projectile-completion-system 'ivy)

(setq synosaurus-choose-method 'ivy-read)

(global-set-key (kbd "C-x b") 'counsel-ibuffer)
;; Run `counsel-ag` against the current directory and not against the
;; whole project
(global-set-key (kbd "C-c k") '(lambda()
                                 (interactive)
                                 (counsel-ag "" default-directory nil nil)))
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(global-set-key (kbd "M-x") (lambda ()
                              (interactive)
                              (counsel-M-x "")))

(add-hook 'pdf-view-mode-hook '(lambda()
                                 (define-key pdf-view-mode-map "\C-s" 'isearch-forward)))

(setq projectile-completion-system 'ivy)

(setq synosaurus-choose-method 'ivy-read)

(add-to-list 'load-path "path/to/writegood-mode")
(require 'writegood-mode)
(global-set-key "\C-cg" 'writegood-mode)

(global-fira-code-mode)

(when (eq system-type 'darwin)
  ; use spotlight to search with m-x locate
  (setq locate-command "mdfind"))
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
