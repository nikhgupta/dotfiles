;;; READ: http://nikhgupta.com/emacs-preamble/#sec-7

(with-eval-after-load
    'org (progn

           ;; set directories used by `org-mode'
           (setq org-directory (expand-file-name "~/OneDrive/Documents"))
           (setq org-archive-location (concat org-directory "/Org/archives" ))
           (setq org-special-directory (concat org-directory "/Org/special"))

           (setq org-global-properties
                 '(("Effort_ALL". "0 0:10 0:30 1:00 2:00 3:00 4:00")))

           ;; replace initial/scratch buffer with our primary `.org' file
           (setq initial-buffer-choice (concat org-special-directory "/start.org"))

           (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
           (setq fill-column 100
                 org-log-done 'time                        ; record information when task is marked as DONE
                 org-completion-use-ido t                  ; use ido-completion when possible
                 org-edit-timestamp-down-means-later t     ; S-down will increase time in timestamp
                 org-fast-tag-selection-single-key 'expert ; fast tag selection
                 org-tags-column -100                      ; indent tags to the right
                 org-special-ctrl-a/e 't                   ; make them jump to start/end of headings
                 org-src-fontify-natively t                ; syntax-highlight source blocks
                 org-bullets-bullet-list '("◉" "✿" "✸" "○")
                 org-export-kill-product-buffer-when-displayed t)

           (add-hook 'org-mode-hook 'turn-on-auto-fill)

           ;; AGENDA
           (setq org-agenda-start-on-weekday nil             ; monday as week's start
                 org-agenda-span 14                          ; show 2 weeks of agenda, by default
                 ;; org-agenda-include-diary 't                ; include `diary' in agenda
                 ;; org-agenda-window-setup 'other-window      ; use `other-window' for agenda
                 org-deadline-warning-days 14
                 org-agenda-skip-scheduled-if-done 't
                 org-habit-show-habits-only-for-today 't
                 org-agenda-dim-blocked-tasks 't
                 org-agenda-files (quote ("~/OneDrive/Documents/Org"
                                          "~/OneDrive/Documents/Org/articles"
                                          "~/OneDrive/Documents/Org/ideas"
                                          "~/OneDrive/Documents/Org/special"
                                          "~/OneDrive/Documents/Org/tidbits"
                                          "~/OneDrive/Documents/Org/work")))

           (add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))

           (setq org-agenda-custom-commands
                 '(("n" "Next Tasks to Work on" todo "NEXT"
                    ((org-agenda-max-entries 5)
                     (org-agenda-sorting-strategy '(priority-up effort-down))))
                   ("r" "Tasks that need refiling" tags-todo "REFILE")
                   ("i" "Important Tasks" tags-todo "important")))

           ;; REFILE/ARCHIVES
           ;; Refile targets include this file and any file contributing to the agenda - up to 2 levels deep
           (setq org-refile-targets (quote ((nil :maxlevel . 3) (org-agenda-files :maxlevel . 3))))
           ;; Use full outline paths for refile targets - we file directly with IDO
           (setq org-refile-use-outline-path t)
           ;; Targets complete directly with IDO
           (setq org-outline-path-complete-in-steps nil)
           ;; Allow refile to create parent tasks with confirmation
           (setq org-refile-allow-creating-parent-nodes (quote confirm))
           ;; Use IDO for org-completion
           (setq org-completion-use-ido t)
           ;; Use the current window for indirect buffer display
           (setq org-indirect-buffer-display 'current-window)

           ;; timestamp refiling
           (setq org-log-refile 'time)
           ;; update counters
           (add-hook 'org-after-refile-insert-hook 'org-update-parent-todo-statistics)

           ;; Exclude DONE state tasks from refile targets
           (defun my-spacemacs/verify-refile-target ()
             "Exclude todo keywords with a done state from refile targets"
             (not (member (nth 2 (org-heading-components)) org-done-keywords)))
           (setq org-refile-target-verify-function 'my-spacemacs/verify-refile-target)

           ;; Todo Keywords and Tagging
           (setq org-log-repeat 'time
                 org-log-redeadline 'note
                 org-log-reschedule 'time
                 org-use-fast-todo-selection 't
                 org-enforce-todo-dependencies 't
                 org-enforce-todo-checkbox-dependencies 't
                 org-treat-S-cursor-todo-selection-as-state-change 'nil
                 org-hierarchical-todo-statistics 'nil
                 org-enable-priority-commands t
                 org-highest-priority ?A
                 org-default-priority ?E
                 org-lowest-priority  ?E)

           (setq org-todo-keywords
                 (quote ((sequence "TODO(t)" "STARTED(s!)" "NEXT(n)" "REVIEW(r@/!)" "|" "DONE(d!)" "ARCHIVED(a)")
                         (sequence "REPORT(R!)" "BUG(b@/!)" "KNOWNCAUSE(k@/!)" "|" "FIXED(f@/!)")
                         (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "DUPE(D)"))))

           ;; Setting Colours (faces) for todo states to give clearer view of work
           (setq org-todo-keyword-faces
                 '(("TODO" . org-warning)
                   ("STARTED" . "yellow")
                   ("NEXT" . "magenta")
                   ("REVIEW" . "orange")
                   ("DONE" . "green")
                   ("ARCHIVED" . "blue")
                   ("WAITING" . "cyan")
                   ("HOLD" . "cyan")
                   ("SOMEDAY" . "grey")
                   ("CANCELLED" . outline-9)))

           ;; position the habit graph on the agenda to the right of the default
           (setq org-habit-graph-column 50)
           (run-at-time "10:00" 86400 '(lambda () (setq org-habit-show-habits t)))

           ;; configure most used tags for fast access
           ;; (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l) (:newline . nil)
           ;;                       ("@personal" . ?p)
           ;;                       ("relationships" . ?r) ("introspection" . ?i) (:newline . nil)
           ;;                       ("@devesh" . ?d)
           ;;                       ("code" . ?c) ("emacs" . ?e) ("zsh" . ?z)     (:newline . nil)))

           ;; CLOCKING
           ;; save the running clock and all clock history when exiting Emacs, load it on startup
           (setq org-clock-persist t
                 org-clock-in-resume t
                 org-clock-persistence-insinuate t
                 org-clock-in-switch-to-state "STARTED"  ;; change task state to STARTED when clocking in
                 org-clock-into-drawer t  ;; save clock data and notes in the LOGBOOK drawer
                 org-clock-out-remove-zero-time-clocks t  ;; removes clocked tasks with 0:00 duration
                 )
           ;; show the clocked-in task - if any - in the header line
           (defun preamble/show-org-clock-in-header-line ()
             (setq-default header-line-format '((" " org-mode-line-string " "))))
           (defun preamble/hide-org-clock-from-header-line ()
             (setq-default header-line-format nil))

           (add-hook 'org-clock-in-hook 'preamble/show-org-clock-in-header-line)
           (add-hook 'org-clock-out-hook 'preamble/hide-org-clock-from-header-line)
           (add-hook 'org-clock-cancel-hook 'preamble/hide-org-clock-from-header-line)

           ;; Captures
           ;; set files used by `org-capture'
           (setq org-journal-file (concat org-special-directory "/diary.org"))
           (setq org-default-notes-file (concat org-special-directory "/refile.org"))
           (setq org-default-tasks-file (concat org-special-directory "/tasks.org"))
           (defun org-journal-entry-time() (format-time-string "%I:%M %p"))

           ;; customizations for `org-capture'
           (setq org-capture-templates
                 '(("t" "Todo" entry (file+headline org-default-tasks-file "Captured")
                    "* TODO %?\n%i\n")
                   ("n" "Note" entry (file+datetree org-default-notes-file "Notes")
                    "* %? :NOTE:\n%U\n%a\n%?" :clock-in t :clock-resume t)
                   ("j" "Journal" entry (file+datetree org-journal-file "Journal")
                    "* at %(org-journal-entry-time) :crypt:\n  %U\n  %?" :clock-in t :clock-resume t)
                   ("l" "Link" plain (file org-default-notes-file "Links")
                    "- %?\n %x\n")
                   ("r" "respond" entry (file org-default-notes-file)
                    "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
                   ("w" "org-protocol" entry (file org-default-notes-file)
                    "* TODO Review %c\n%U\n" :immediate-finish t)
                   ("m" "Meeting" entry (file org-default-notes-file)
                    "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                   ("p" "Phone call" entry (file org-default-notes-file)
                    "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
                   ("h" "Habit" entry (file+headline org-default-tasks-file "Captured")
                    "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")))

           ;; ENCRYPTION
           ;; file encryption
           (setq epa-file-inhibit-auto-save 't)

           ;; encryption sections of a file
           (require 'org-crypt)
           (org-crypt-use-before-save-magic)
           (setq org-tags-exclude-from-inheritance (quote ("crypt")))
           ;; GPG key to use for encryption
           ;; Either the Key ID or set to nil to use symmetric encryption.
           (setq org-crypt-key "me@nikhgupta.com")
           (setq org-crypt-disable-auto-save 'encrypt)))
