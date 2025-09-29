package main

import (
	"context"
	"log"

	"github.com/modelcontextprotocol/go-sdk/mcp"
)

// Input represents the tool input parameters
type Input struct {
	Name     string `json:"name" jsonschema:"the name of the person to greet"`
	Language string `json:"language" jsonschema:"the language for greeting (English, Spanish, French, German, Japanese, Chinese, Korean)"`
}

// Output represents the tool output
type Output struct {
	Greeting string `json:"greeting" jsonschema:"the greeting message"`
}

// SayGreetings handles the greeting tool call
func SayGreetings(ctx context.Context, req *mcp.CallToolRequest, input Input) (
	*mcp.CallToolResult,
	Output,
	error,
) {
	// Default to English if no language specified
	if input.Language == "" {
		input.Language = "English"
	}

	// Generate greeting based on language
	var greeting string
	switch input.Language {
	case "Spanish":
		greeting = "¡Hola, " + input.Name + "!"
	case "French":
		greeting = "Bonjour, " + input.Name + "!"
	case "German":
		greeting = "Hallo, " + input.Name + "!"
	case "Japanese":
		greeting = "こんにちは, " + input.Name + "!"
	case "Chinese":
		greeting = "你好, " + input.Name + "!"
	case "Korean":
		greeting = "안녕하세요, " + input.Name + "!"
	default:
		greeting = "Hello, " + input.Name + "!"
	}

	return nil, Output{Greeting: greeting}, nil
}

func main() {
	// Create server with official SDK
	server := mcp.NewServer(&mcp.Implementation{
		Name:    "greetings-server",
		Version: "1.1.0",
	}, nil)

	// Add the greetings tool using the official SDK
	mcp.AddTool(server, &mcp.Tool{
		Name:        "sayGreetings",
		Description: "Say hello to someone in different languages",
	}, SayGreetings)

	// Run the server over stdin/stdout using official transport
	if err := server.Run(context.Background(), &mcp.StdioTransport{}); err != nil {
		log.Fatal(err)
	}
}
