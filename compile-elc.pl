use strict;
use warnings FATAL=>'all';
use File::Find;
use Cwd;

# prover directories from makefile
my @PROVERS=qw(acl2 ccc coq hol98 isar lego hol-light phox pgshell pgocaml pghaskell);
# other elisp from makefile
my @OTHER_ELISP=qw(generic lib contrib/mmm);
# current working directory
my $PWD = getcwd; 
# get all the dependencies any of the elisp files could possibly have
my $ELISP_DIRS = "@PROVERS @OTHER_ELISP";

my $command = 'emacs --batch --no-site-file -q';

my $ELISP_BATCH_SCRIPT = <<ELISP;
(setq load-path 
    (append 
        (mapcar (lambda (d) (concat "${PWD}/" (symbol-name d))) (quote (${ELISP_DIRS})))
        load-path))
(progn 
    (require (quote bytecomp))
    (require (quote mouse))
    (require (quote tool-bar))
    (require (quote fontset))
    (setq byte-compile-warnings 
        ; kinds of warnings to ignore
        (remove (quote cl-functions) 
            (remove (quote noruntime) 
                byte-compile-warning-types))) 
    (setq byte-compile-error-on-warn t))
;; my own addition to force compilation
(byte-compile-file buffer-file-name)
ELISP

sub wanted {
    $_ =~ /\.el$/ or return 0;
    my $exit_status = 
        system(qq[$command '$File::Find::name' --eval '$ELISP_BATCH_SCRIPT']);
    die "failed to compile file $_" unless $exit_status == 0;
}

find(\&wanted, $PWD);
