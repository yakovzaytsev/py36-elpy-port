# $FreeBSD$

PORTNAME=	elpy
DISTVERSION=	1.17.0
CATEGORIES=	misc
MASTER_SITES=	https://github.com/jorgenschaefer/elpy/archive/
DISTNAME=       elpy-${PORTVERSION}
DISTFILES=      ${PORTVERSION}.tar.gz
MAINTAINER=	me@ysz.io
COMMENT=	Emacs Python Development Environment
# MY_DEPENDS=     python36:lang/python36 \
#                 pip-3.6:devel/py36-pip
#                 emacs:editors/emacs25
# #BUILD_DEPENDS=  ${MY_DEPENDS}
# RUN_DEPENDS=    ${MY_DEPENDS}

do-build:
	

# XXX
do-install:
	cd ${WRKSRC} && python3.6 setup.py install
	${CP} ${WRKSRC}/elpy-django.el   \
              ${WRKSRC}/elpy-pkg.el      \
              ${WRKSRC}/elpy-profile.el  \
              ${WRKSRC}/elpy-refactor.el \
              ${WRKSRC}/elpy.el          \
              /usr/local/share/emacs/site-lisp
	emacs -nw --no-init-file --eval                      \
	             "(progn                                 \
                        (require 'package)                   \
                        (add-to-list 'package-archives       \
                                    '(\"melpa-stable\" . \"https://stable.melpa.org/packages/\") t) \
	                (package-initialize)                 \
                        (package-refresh-contents)           \
                        (setq package-user-dir \"/usr/local/share/emacs/25.3/site-lisp/elpa\") \
	                (toggle-debug-on-error)              \
	                (dolist (pkg '(company               \
                                       find-file-in-project  \
	                               highlight-indentation \
                                       pyvenv                \
	                               yasnippet             \
	                               s))                   \
	                  (package-install pkg))             \
                        (save-buffers-kill-terminal))"

.include <bsd.port.mk>

