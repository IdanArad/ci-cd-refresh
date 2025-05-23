package main

import (
  "fmt"
  "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Hello again from the Jenkins")
}

func main() {
  http.HandleFunc("/", handler)
  fmt.Println("Starting server on :8080")
  if err := http.ListenAndServe(":8080", nil); err != nil {
    panic(err)
  }
}
