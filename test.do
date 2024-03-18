// hello_test.go
package main

import (
    "testing"
    "bytes"
    "os"
)

func TestMain(m *testing.M) {
    // Run tests
    code := m.Run()

    // Clean up (if needed)
    // ...

    os.Exit(code)
}

func TestHelloWorld(t *testing.T) {
    // Redirect stdout for testing
    var buf bytes.Buffer
    oldStdout := os.Stdout
    os.Stdout = &buf
    defer func() {
        os.Stdout = oldStdout
    }()

    // Run the function
    main()

    // Capture the output
    output := buf.String()

    // Test if the output matches
    expected := "Hello, World!\n"
    if output != expected {
        t.Errorf("Expected: %s\nActual: %s", expected, output)
    }
}

