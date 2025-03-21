package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/couchbase/gocb/v2"
)

func main() {
	host := os.Getenv("CB_HOST")
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
	// Sets a pre-configured profile called "wan-development" to help avoid latency issues
	// when accessing Capella from a different Wide Area Network
	// or Availability Zone (e.g. your laptop).
	if err := options.ApplyProfile(gocb.ClusterConfigProfileWanDevelopment); err != nil {
		log.Fatal(err)
	}

	// Initialize the Connection
	cluster, err := gocb.Connect("couchbases://"+connectionString, options)
	if err != nil {
		log.Fatal(err)
	}

	bucket := cluster.Bucket(bucketName)

	err = bucket.WaitUntilReady(5*time.Second, nil)
	if err != nil {
		log.Fatal(err)
	}
	col := bucket.Scope("_default").Collection(collectionName)

	// Perform a N1QL Query
	inventoryScope := bucket.Scope("_default")
	queryResult, err := inventoryScope.Query(
		fmt.Sprintf("SELECT * FROM airline WHERE id=10"),
		&gocb.QueryOptions{},
	)
	if err != nil {
		log.Fatal(err)
	}

}