package main

import (
    "net/http"
    "log"
)

func handler(w http.ResponseWriter, r *http.Request) {
    http.ServeFile(w, r, "index.html")
}

func main() {
    http.HandleFunc("/", handler)
    log.Println("Server started at :8000")
    if err := http.ListenAndServe(":8000", nil); err != nil {
        log.Fatal("Failed to start server:", err)
    }
}
