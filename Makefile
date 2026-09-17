NAME		?=	images
VERSION		?=	1.0.0
ENV			?=	


PACKAGES	=	JPEG					\
				PNG						\
				tbaricault_colors		\
				tbaricault_filesystem	\
				tbaricault_math

TARGETS		=	gdi32					\
				JPEG::JPEG				\
				PNG::PNG				\
				tbaricault::colors		\
				tbaricault::filesystem	\
				tbaricault::math

SRC			=	Image


all: build

configure:
	@cmake							\
		-B build 					\
		-DNAME="$(NAME)"			\
		-DVERSION="$(VERSION)"		\
		-DENV="$(ENV)"				\
		-DPACKAGES="$(PACKAGES)"	\
		-DTARGETS="$(TARGETS)"		\
		-DSRC="$(SRC)"

build: configure
	@cmake --build build

clean:
	@rm -dfr build

re: clean build

install: build
	@cmake --install build
	@cmake -P cmake/generate_uninstall.cmake

uninstall:
	@if [ -f uninstall.cmake ]; then	\
		cmake -P uninstall.cmake;		\
		rm -f uninstall.cmake;			\
	fi

reinstall: uninstall install


.PHONY: all configure build clean re install uninstall reinstall
