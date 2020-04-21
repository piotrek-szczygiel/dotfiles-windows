(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'naysayer-theme)
(load-theme 'naysayer t)

(straight-use-package 'powershell)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))

(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      backup-directory-alist `((".*" . ,temporary-file-directory))
      default-directory "c:/dev/"
      electric-pair-preserve-balance nil
      gc-cons-threshold 20000000
      inhibit-startup-message t
      initial-scratch-message nil
      require-final-newline t
      vc-follow-symlinks t
      visible-bell t)

(setq-default indent-tabs-mode nil
              tab-width 4
              c-default-style "stroustrup")

(delete-selection-mode t)
(electric-pair-mode 1)
(global-auto-revert-mode t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(set-face-attribute 'default nil
		    :family "Consolas"
		    :height 120
		    :weight 'normal
		    :width 'normal)

(defun sensible-defaults/reset-text-size ()
  (interactive)
  (text-scale-set 0))

(define-key global-map (kbd "C-)") 'sensible-defaults/reset-text-size)
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C-_") 'text-scale-decrease)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'subword-mode)
(add-hook 'before-save-hook
            (lambda ()
              (when buffer-file-name
                (let ((dir (file-name-directory buffer-file-name)))
                  (when (and (not (file-exists-p dir))
                             (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                    (make-directory dir t))))))

(when (or window-system (daemonp))
  (setq default-frame-alist '((width . 120) (height . 40))))
