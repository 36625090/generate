app=generate
default:
	go build -o $(app) main.go

linux:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o $(app) main.go

install:
	go install
