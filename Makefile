
VERSION := "10.2.2" # ---> upstream 1.2.2
BUILD_TIME=$(shell date -u +%Y-%m-%d_%H:%M:%S_%Z)
PKG := "github.com/bbklab/shadowsocks-go"
gitCommit=$(shell git rev-parse --short HEAD)
gitDirty=$(shell git status --porcelain --untracked-files=no)
GIT_COMMIT=$(gitCommit)
ifneq ($(gitDirty),)  # ---> gitDirty != ""
GIT_COMMIT=$(gitCommit)-dirty
endif
BUILD_FLAGS=-X $(PKG)/shadowsocks.version=$(VERSION) -X $(PKG)/shadowsocks.gitCommit=$(GIT_COMMIT) -X $(PKG)/shadowsocks.buildAt=$(BUILD_TIME) -w -s

default: binary

prepare:
	mkdir -p bin/

clean:
	rm -f bin/ss-local bin/ss-server

binary: clean server local

server:
	env CGO_ENABLED=0 GOOS=linux go build -a -ldflags "${BUILD_FLAGS}" -o bin/ss-server cmd/shadowsocks-server/*.go

local:
	env CGO_ENABLED=0 GOOS=linux go build -a -ldflags "${BUILD_FLAGS}" -o bin/ss-local cmd/shadowsocks-local/*.go

test:
	cd shadowsocks; go test
