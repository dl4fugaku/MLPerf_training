downloads
=========
(none)

fixes
=====
get a bunch of files from v0.5 repo -> already integrated

run
===
GOPARAMS=params/minitest.json python3.6 loop_init.py
GOPARAMS=params/minitest.json python3.6 loop_selfplay.py 1 0 2>&1
GOPARAMS=params/minitest.json python3.6 loop_train_eval.py 1 0 2>&1
