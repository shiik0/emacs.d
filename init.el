;;; package --- Chico Pereira <olachico@icloud.com> Emacs config
;;; Commentary:
;; - All of the configuration is within `configuration.org`
;;; Code:

(package-initialize)

(defun load-config()
  "Load the actual configuration in literate 'org-mode' elisp."
  (interactive)
  (org-babel-load-file "~/.emacs.d/configuration.org"))

(load-config)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Documents/org/sample.org")))
 '(package-selected-packages
   (quote
    (zenburn-theme yaml-mode writeroom-mode writegood-mode which-key web-mode visual-fill-column tide synosaurus smex smartparens sass-mode rust-mode robe restclient org-bullets ob-restclient rjsx-mode rainbow-mode projectile pdf-tools parinfer page-break-lines package-lint neotree markdown-mode magit lsp-mode js2-refactor js2-mode json-mode swiper counsel ivy ini-mode impatient-mode ido-vertical-mode hide-mode-line ghub flycheck-rust flycheck-flow flycheck forge eyebrowse exec-path-from-shell erc-image enh-ruby-mode evil-surround evil-numbers evil-mc evil-leader evil-escape evil elixir-mode elfeed-goodies elfeed editorconfig dumb-jump doom-modeline diminish dired-narrow dashboard company comment-tags browse-kill-ring beacon autopair auto-complete atomic-chrome all-the-icons ag ac-js2)))
 '(pdf-tools-handle-upgrades nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
