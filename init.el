;; font settings
(when (member "Menlo" (font-family-list))
  (set-frame-font "Menlo-16" t t))

;; splash image
(setq fancy-splash-image "~/.emacs.d/Splash.svg")


;; change window size and colors
(if (display-graphic-p)
    (setq initial-frame-alist
	  '(
	    (tool-bar-lines . 0)
	    (width . 108)
	    (height . 36)
	    (background-color . "MintCream")
	    (left . 96))))
(setq initial-fram-alist '( (tool-bar-lines . 0)))

(setq default-frame-alist initial-frame-alist)

;; stop creating those #auto-save# files
(setq auto-save-default nil)

;; stop creating .#lock files
(setq create-lockfiles nil)

;; save all files, no ask
(defun xah-save-all-unsaved ()
  "Save all unsaved files. no ask.
Version 2019-11-05"
  (interactive)
  (save-some-buffers t ))

(if (version< emacs-version "27")
    (add-hook 'focus-out-hook 'xah-save-all-unsaved)
  (setq after-focus-change-function 'xah-save-all-unsaved))

;; set file to auto refresh when change detected (For example, changed by other)
(global-auto-revert-mode 1)

;; make backup to a designated dir, mirroring the full path
(defun xah-backup-nested-dir-file-path (Fpath)
  "Return a new file path and create dirs.
If the new path's directories does not exist, create them.
version 2022-06-09"
  (let* ($backupRoot $backupFilePath)
    (setq $backupRoot "~/.emacs.d/backup/")
    ;; remove Windows driver letter in path, e.g. C:
    (setq $backupFilePath
          (format "%s%s~" $backupRoot (replace-regexp-in-string "^[A-Za-z]:/" "" Fpath)))
    (make-directory
     (file-name-directory $backupFilePath)
     (file-name-directory $backupFilePath))
    $backupFilePath
    ))

;; don't change file creation date from backups
(setq make-backup-file-name-function 'xah-backup-nested-dir-file-path)
