package main

import (
	"fmt"
	"log"
	"os"
	"time"
	"strings"
	"encoding/json"
	"gopkg.in/yaml.v3"
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
	var credentials Credentials
	// Get the credentials from the credentials file
	homedir, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
	}
	credentialsPath := homedir + "/credentials"
	if _, err := os.Stat(credentialsPath); err == nil {
		credentials = getCredentials(credentialsPath)
	} else {
		log.Fatal("Credentials file not found")
	}

	// Get the metadata path
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	metadataPath := dir + "/metadata"
	if _, err := os.Stat(metadataPath); err == nil {
		fmt.Println ("writing metadata files to " + metadataPath)
	} else {
		log.Fatal("Metadata directory not found")
	}

	// Connect to the database
	host := credentials.Cb_host
	if ! strings.Contains(host, "couchbase") {
		host = "couchbases://" + host
	}
	username := credentials.Cb_user
	password := credentials.Cb_password
	bucketName := credentials.Cb_bucket
	scopeName := credentials.Cb_scope
	collectionName := credentials.Cb_collection

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
	cluster, err := gocb.Connect(host, options)
	if err != nil {
		log.Fatal(err)
	}

	bucket := cluster.Bucket(bucketName)

	err = bucket.WaitUntilReady(5*time.Second, nil)
	if err != nil {
		log.Fatal(err)
	}
	collection := cluster.Bucket(bucketName).Scope(scopeName).Collection(collectionName)

	// query for the document ids
	queryResult, err := cluster.Query (
		fmt.Sprintf("SELECT raw meta().id FROM vxdata._default.METAR WHERE type='MD' AND version='V01' AND subset = 'METAR' AND docType != 'station' AND generated IS MISSING;"),
		&gocb.QueryOptions{},
	)
	if err != nil {
		log.Fatal(err)
 	}
	for queryResult.Next() {
		var row interface{}
		err := queryResult.Row(&row)
		if err != nil {
			log.Fatal(err)
		}
		id := row.(string)
		// write out the document
		writeDocument(collection, id + ".json", metadataPath)
	}
}

func writeDocument(collection *gocb.Collection, id string, metadatapath string) {
	// Get the document from the source bucket by its id
	getResult, err := collection.Get(id, nil)
	if err != nil {
		log.Fatal(err)
	}

	var doc interface{}
	err = getResult.Content(&doc)
	if err != nil {
		panic(err)
	}
	docJson, err := json.MarshalIndent(doc, "", "    ")
	if err != nil {
		log.Fatal(err)
	}
	err = os.WriteFile(metadatapath + "/" + id, docJson, 0644)
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
