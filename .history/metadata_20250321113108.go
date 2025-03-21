package main

import (
	"fmt"
	"log"
	"time"

	"github.com/couchbase/gocb/v2"
)

func main() {
	username
	// Connect to Couchbase Server
	cluster, err := gocb.Connect(
		"localhost",
		gocb.ClusterOptions{
			Username: "Administrator
			Password
		},