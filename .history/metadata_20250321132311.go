package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/couchbase/gocb/v2"
)

type Credentials struct {
	Cb_host       string `yaml:"cb_host"`
	Cb_user       string `yaml:"cb_user"`
	Cb_password   string `yaml:"cb_password"`
	Cb_bucket     string `yaml:"cb_bucket"`
	Cb_scope      string `yaml:"cb_scope"`
	Cb_collection string `yaml:"cb_collection"`
}

func main() {
	credentials = getCredentials("credentials.yaml")
	host := credentials.
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
	cluster, err := gocb.Connect("couchbases://" + host, options)
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

func getCredentials(credentialsFilePath string) Credentials {
	creds := Credentials{}
	yamlFile, err := os.ReadFile(credentialsFilePath)
	if err != nil {
		log.Printf("yamlFile.Get err   #%v ", err)
	}
	err = yaml.Unmarshal(yamlFile, &creds)
	if err != nil {
		log.Fatalf("Unmarshal: %v", err)
	}
	return creds
}
