default: binary

prepare:
	mkdir -p bin/

clean:
	rm -f bin/ss-local bin/ss-server

binary: clean server local

server:
	go build -o bin/ss-server cmd/shadowsocks-server/*.go

local:
	go build -o bin/ss-local cmd/shadowsocks-local/*.go

test:
	cd shadowsocks; go test
