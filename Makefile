install: install-zsh install-git install-emacs

install-zsh: 
	rm -f ~/.zshrc
	ln -s `pwd`/zsh/zshrc ~/.zshrc
	ln -sfn `pwd`/zsh/custom ~/.zsh-custom

install-git:
	rm -f ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-emacs:
	rm -rf ~/.cask
	curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
	rm -rf ~/.emacs.d
	mkdir ~/.emacs.d
	cp `pwd`/emacs/emacs.d/*.el ~/.emacs.d
	cp `pwd`/emacs/emacs.d/Cask ~/.emacs.d
	cp `pwd`/emacs/emacs.d/configuration.org ~/.emacs.d
	~/.cask/bin/cask --path ~/.emacs.d/ install
