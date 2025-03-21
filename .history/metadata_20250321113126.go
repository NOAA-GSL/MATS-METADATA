package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/couchbase/gocb/v2"
)

func main() {
	username := os.
	// Connect to Couchbase Server
	cluster, err := gocb.Connect(
		"localhost",
		gocb.ClusterOptions{
			Username: "Administrator
			Password
		},