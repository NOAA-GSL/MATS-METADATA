package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/couchbase/gocb/v2"
)

func main() {
	username := os.Getenv("CB_USERNAME")
	password := os.Getenv("CB_PASSWORD")
	bucketName := os.Getenv("CB_BUCKET")
	collectionName := os.Getenv("CB_COLLECTION")

	options := gocb.ClusterOptions{
		Authenticator: gocb.PasswordAuthenticator{
			Username: username,
			Password: password,
		},
	}

	// Connect to Couchbase Server
	cluster, err := gocb.Connect(
		"localhost",
		gocb.ClusterOptions{
			Username: username,
			Password: password,
		},
	}
