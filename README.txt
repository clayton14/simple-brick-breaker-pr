SPDX-FileNotice: 🅭🄍1.0 This file was dedicated to the public domain using the CC0 1.0 Universal Public Domain Dedication <https://creativecommons.org/publicdomain/zero/1.0/>.
SPDX-FileContributor: Jason Yundt <swagfortress@gmail.com> (2021)
SPDX-FileType: TEXT
SPDX-FileType: DOCUMENTATION



Simple Brick Breaker
~~~~~~~~~~~~~~~~~~~~

pre-commit
~~~~~~~~~~
If you decide to contribute to this project, then you may want pre-commit <https://pre-commit.com/> to automatically check your contributions. To do so:
1. Make sure that the pre-commit <https://pre-commit.com/> command is installed:
	Run
		pre-commit --version
	If you see something along the lines of “pre-commit 2.15.0”, then the pre-commit command is installed. If you don’t, then follow the instructions at <https://pre-commit.com/#installation> to install the pre-commit command.
2. Install the pre-commit hook:
	Change directory to the root of this repo, and run
		pre-commit install

Now, when ever you git commit, pre-commit will run a series of tests and stop you if any of them fail.
