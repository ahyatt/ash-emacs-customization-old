;; Font setup, mostly copied from Amit Patel
; TODO: running in daemon mode confuses my-font-size
(defvar my-font-size (if (equal ":0.0" (getenv "DISPLAY")) 140 120))
(defvar ash-default-font "Inconsolata")
(defvar ash-fixed-pitch-font "Inconsolata")
(defvar ash-lucida-sans-font "Lucida Sans")
(defvar ash-lucida-sans-italic-font "Lucida Sans Italic")

;;; Try to load a package, but continue if it doesn't exist.  This
;;; allows my emacs startup file to work on a larger variety of
;;; systems and Emacs versions.
(defmacro try-require (package &rest forms)
  "Execute FORMS only if (require PACKAGE) succeeds."
  (declare (indent 1))
  `(when (condition-case nil
             (require ,package)
           (error (message "Package %s could not be loaded" ,package) nil))
     ,@forms))

;; I want some colors to be different in a GUI and in a TTY.  With
;; MultiTTY, I need to reset these colors for each frame, because some
;; frames are GUI and some are TTY.  The variable my-frame-faces
;; stores the attributes that vary for GUI and TTY;
;; set-frame-face-attributes adds to this list.  There might be a way to
;; do this with custom but I haven't investigated it. TODO: need this
;; for ediff-*, pabbrev-suggestions-face
(defvar my-frame-faces nil
  "Face attributes that are different for TTY and GUI. Should be list of
(face (GUI attribute list) (TTY attribute list)).")

(defun set-frame-face-attributes (face gui-spec tty-spec)
  "Add face-attributes to FACE that apply for GUI and TTY. For example:

(set-frame-face-attributes
    'mode-line '(:background \"skyblue\") '(:background \"blue\"))

allows you to set the mode-line background to skyblue for GUI frames
and blue for TTY frames."
  (let ((new-value (list gui-spec tty-spec))
        (cell (assq face my-frame-faces)))
    (if cell
        (setcdr cell new-value)
      (add-to-list 'my-frame-faces (cons face new-value) t))))

(defun set-frame-faces (&optional frame)
  "Set faces that depend on the type of frame. These frames are listed in
my-frame-faces, and are set by calling set-frame-face-attributes. The optional
frame argument is the frame for which colors are set, or nil for global faces.
This function is normally not called directly; it is added to frame creation
hooks."
  (let ((window-system (if (fboundp 'window-system)
                           (window-system frame)
                           window-system)))
    (loop for spec in my-frame-faces do
          (apply 'set-face-attribute
                 (list* (car spec) frame
                        (if window-system (nth 1 spec) (nth 2 spec)))))))

(set-frame-face-attributes
 'default
 '(:background "#f6f6f2")
 '(:background unspecified))

(try-require 'font-lock
  (set-frame-face-attributes
   'font-lock-string-face
   '(:background "#e8e8e8" :foreground "#000000")
   '(:background unspecified :foreground "green"))
  (set-frame-face-attributes
   'font-lock-doc-face
   '(:background "#e8e8e8" :foreground "#448844")
   '(:background unspecified :foreground "green"))
  (set-face-foreground 'font-lock-comment-face "#006699")
  (make-face-bold 'font-lock-comment-face)
  (set-face-foreground 'font-lock-comment-delimiter-face "#4499cc")
  (set-face-foreground 'font-lock-constant-face "#553399")
  (set-face-foreground 'font-lock-type-face "blue4")
  (set-face-foreground 'font-lock-variable-name-face "blue4")
  (set-face-foreground 'font-lock-function-name-face "#2244d0")
  (set-face-foreground 'font-lock-preprocessor-face "purple")
  (set-face-foreground 'font-lock-warning-face "red")
  (set-face-foreground 'font-lock-keyword-face "gray30")
  (set-face-foreground 'font-lock-builtin-face "green4")
  (set-face-foreground 'font-lock-negation-char-face "red")
  (make-face-unbold 'font-lock-warning-face))

(make-face 'lazy-highlight)
(set-face-background 'isearch "yellow")
(set-face-foreground 'isearch nil)
(set-face-background 'lazy-highlight "#ffffcc")
(set-face-foreground 'lazy-highlight nil)

(make-face 'trailing-whitespace)
(set-frame-face-attributes
 'trailing-whitespace
 '(:background "#ccccdd")
 '(:background "cyan"))

(set-face-foreground 'fringe "cyan4")
(set-face-foreground 'completions-common-part "gray30")
(set-face-underline-p 'completions-first-difference t)

;; The mode-line has an inactive and active state, which almost
;; matches what I did with XEmacs, except when the application doesn't
;; have focus, one of the mode-lines still is considered active.
(set-frame-face-attributes
 'mode-line
 '(:foreground "white" :background "#4e5caf" :inverse-video nil)
 '(:foreground "white" :background "blue" :inverse-video nil))
(set-frame-face-attributes
 'mode-line-inactive
 '(:foreground "black" :background "#bfc1c5" :inverse-video nil)
 '(:foreground "white" :background "black" :inverse-video nil))
(set-frame-face-attributes
 'mode-line-emphasis
 '(:foreground "red" :background "#ffffcc" :inverse-video nil)
 '(:foreground "red" :background "yellow" :inverse-video nil))
(set-face-attribute
 'mode-line nil
 :box '(:line-width 1 :color "#bbabb4" :style released-button))
(set-face-attribute
 'mode-line-inactive nil
 :box '(:line-width 1 :color "gray70" :style released-button))
(set-face-attribute
 'mode-line-highlight nil
 :box '(:line-width 2 :color "purple" :style pressed-button))

;; There's a minibuffer-prompt face, so I no longer need minibuffer-setup-hook
(set-face-background 'minibuffer-prompt "yellow")
(set-face-foreground 'minibuffer-prompt "black")

(make-face 'query-replace)
(set-face-background 'query-replace "green4")
(set-face-foreground 'query-replace "white")

(set-face-background 'region "#99ddff")
(set-face-foreground 'region "black")

(set-face-background 'highlight "blue")
(set-face-foreground 'highlight "white")

(set-face-background 'match "#99ddaa")
(set-face-foreground 'match nil)

(make-face 'show-paren-match)
(make-face 'show-paren-mismatch)
(set-frame-face-attributes
 'show-paren-match
 '(:background "#99ff99" :foreground "black")
 '(:background "cyan" :foreground "black"))
(set-frame-face-attributes
 'show-paren-mismatch
 '(:background "#ff9999" :foreground "black")
 '(:background "red" :foreground "white"))

;; Anonymous Pro from http://www.ms-studio.com/FontSales/anonymouspro.html
(set-face-attribute 'default nil :family ash-default-font :height my-font-size :background "white" :foreground "black")
(set-face-attribute 'fixed-pitch nil :family ash-fixed-pitch-font :height my-font-size)
(set-face-attribute 'variable-pitch nil :family ash-lucida-sans-font :height my-font-size)
(set-face-attribute 'modeline nil :family ash-lucida-sans-font :height (- my-font-size 30))
(set-face-attribute 'font-lock-function-name-face nil
                    :family ash-lucida-sans-italic-font :height (+ 20 my-font-size) :italic t)

(set-face-attribute 'font-lock-comment-face nil :family ash-lucida-sans-font :height my-font-size)
(set-face-foreground 'font-lock-comment-face "black")
(set-face-background 'font-lock-comment-face "#ddddcc")
(make-face-unitalic 'font-lock-comment-face)
(make-face-bold 'font-lock-comment-face)

(provide 'ash-faces)
