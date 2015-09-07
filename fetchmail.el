;;; fetchmail.el --- run fetchmail from inside Emacs

;; Copyright (C) 2004, 2005
;;  Mario Domenech Goulart

;; Author: Mario Domenech Goulart 
;; Maintainer: Mario Domenech Goulart
;; Keywords: mail, fetchmail
;; Version: 0.1

;; This file is not part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This package provides a compile.el-like interface to invoke
;; fetchamail from inside Emacs


;;; Code:

(defvar fetchmail-command "fetchmail")

(defvar fetchmail-window-height 12)

(defvar fetchmail-buffer "*fetchmail*")


(defun fetchmail-set-window-height (window)
  "Set the height of WINDOW according to `fetchmail-window-height'."
  (and fetchmail-window-height
       (= (window-width window) (frame-width (window-frame window)))
       ;; If window is alone in its frame, aside from a minibuffer,
       ;; don't change its height.
       (not (eq window (frame-root-window (window-frame window))))
       ;; This save-excursion prevents us from changing the current buffer,
       ;; which might not be the same as the selected window's buffer.
       (save-excursion
	 (let ((w (selected-window)))
	   (unwind-protect
	       (progn
		 (select-window window)
		 (enlarge-window (- fetchmail-window-height
				    (window-height))))
	     ;; The enlarge-window above may have deleted W, if
	     ;; fetchmail-window-height is large enough.
	     (when (window-live-p w)
	       (select-window w)))))))


(defun fetchmail ()
  (interactive)
  (message "Fetching mail...")
  (if (get-buffer fetchmail-buffer)
      (delete-windows-on fetchmail-buffer))
  (start-process "fetchmail" fetchmail-buffer fetchmail-command)
  (setq outwin (display-buffer fetchmail-buffer nil t))
  (fetchmail-set-window-height outwin)
  (save-selected-window
    (pop-to-buffer fetchmail-buffer)
    (goto-char (point-max))))

(provide 'fetchmail)
