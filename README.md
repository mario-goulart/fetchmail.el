## fetchmail.el

fetchmail.el provides a compile.el-like interface to invoke fetchmail
asynchronously from inside Emacs.

It's not intended to be a full-featured frontend to fetchmail, just a
small interface to invoke fetchmail and show its output in an Emacs
buffer.

The only interactive function is fetchmail, which can be bound to a
key on, say, Gnus or VM. An example to set it as the f key in Gnus is:

    (require 'fetchmail)
    (add-hook 'gnus-started-hook
                (lambda () (local-set-key "f" 'fetchmail)))

When `f` is pressed, the command set in the fetchmail-command variable
(default = `"fetchmail"`) is invoked and its output is showed in a
buffer whose name can be configured with the `fetchmail-buffer`
variable (default = `*fetchmail*`).

![Screenshot](http://parenteses.org/mario/img/utils/fetchmail.el/fetchmail.el.png)
