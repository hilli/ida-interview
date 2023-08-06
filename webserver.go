package main

import (
	"fmt"
	"net/http"
)

func main() {
	fs := http.FileServer(http.Dir("static"))
	http.Handle("/", fs)
	fmt.Println("Starting server on http://localhost:8080")
	http.ListenAndServe(":8080", nil)
}
