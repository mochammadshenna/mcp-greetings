package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
)

type JSONRPCRequest struct {
	JSONRPC string      `json:"jsonrpc"`
	ID      int         `json:"id"`
	Method  string      `json:"method"`
	Params  interface{} `json:"params,omitempty"`
}

type JSONRPCResponse struct {
	JSONRPC string      `json:"jsonrpc"`
	ID      int         `json:"id"`
	Result  interface{} `json:"result,omitempty"`
	Error   interface{} `json:"error,omitempty"`
}

type InitializeResult struct {
	ProtocolVersion string `json:"protocolVersion"`
	Capabilities    struct {
		Tools struct{} `json:"tools"`
	} `json:"capabilities"`
	ServerInfo struct {
		Name    string `json:"name"`
		Version string `json:"version"`
	} `json:"serverInfo"`
}

type ToolsListResult struct {
	Tools []struct {
		Name        string `json:"name"`
		Description string `json:"description"`
		InputSchema struct {
			Type       string `json:"type"`
			Properties struct {
				Name struct {
					Type        string `json:"type"`
					Description string `json:"description"`
				} `json:"name"`
				Language struct {
					Type        string   `json:"type"`
					Description string   `json:"description"`
					Enum        []string `json:"enum"`
				} `json:"language"`
			} `json:"properties"`
			Required []string `json:"required"`
		} `json:"inputSchema"`
	} `json:"tools"`
}

type ToolCallResult struct {
	Content []struct {
		Type string `json:"type"`
		Text string `json:"text"`
	} `json:"content"`
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()

		var req JSONRPCRequest
		if err := json.Unmarshal([]byte(line), &req); err != nil {
			continue
		}

		var response JSONRPCResponse
		response.JSONRPC = "2.0"
		response.ID = req.ID

		switch req.Method {
		case "initialize":
			response.Result = InitializeResult{
				ProtocolVersion: "2024-11-05",
				Capabilities: struct {
					Tools struct{} `json:"tools"`
				}{},
				ServerInfo: struct {
					Name    string `json:"name"`
					Version string `json:"version"`
				}{
					Name:    "greetings-server",
					Version: "1.0.0",
				},
			}

		case "tools/list":
			response.Result = ToolsListResult{
				Tools: []struct {
					Name        string `json:"name"`
					Description string `json:"description"`
					InputSchema struct {
						Type       string `json:"type"`
						Properties struct {
							Name struct {
								Type        string `json:"type"`
								Description string `json:"description"`
							} `json:"name"`
							Language struct {
								Type        string   `json:"type"`
								Description string   `json:"description"`
								Enum        []string `json:"enum"`
							} `json:"language"`
						} `json:"properties"`
						Required []string `json:"required"`
					} `json:"inputSchema"`
				}{
					{
						Name:        "sayGreetings",
						Description: "Say hello to someone in different languages",
						InputSchema: struct {
							Type       string `json:"type"`
							Properties struct {
								Name struct {
									Type        string `json:"type"`
									Description string `json:"description"`
								} `json:"name"`
								Language struct {
									Type        string   `json:"type"`
									Description string   `json:"description"`
									Enum        []string `json:"enum"`
								} `json:"language"`
							} `json:"properties"`
							Required []string `json:"required"`
						}{
							Type: "object",
							Properties: struct {
								Name struct {
									Type        string `json:"type"`
									Description string `json:"description"`
								} `json:"name"`
								Language struct {
									Type        string   `json:"type"`
									Description string   `json:"description"`
									Enum        []string `json:"enum"`
								} `json:"language"`
							}{
								Name: struct {
									Type        string `json:"type"`
									Description string `json:"description"`
								}{
									Type:        "string",
									Description: "Name of the person to greet",
								},
								Language: struct {
									Type        string   `json:"type"`
									Description string   `json:"description"`
									Enum        []string `json:"enum"`
								}{
									Type:        "string",
									Description: "Language for greeting (optional, default: English)",
									Enum:        []string{"English", "Spanish", "French", "German", "Japanese", "Chinese", "Korean"},
								},
							},
							Required: []string{"name"},
						},
					},
				},
			}

		case "tools/call":
			// Parse the tool call parameters
			paramsMap, ok := req.Params.(map[string]interface{})
			if !ok {
				response.Error = map[string]string{"message": "Invalid parameters"}
				break
			}

			toolName, ok := paramsMap["name"].(string)
			if !ok || toolName != "sayGreetings" {
				response.Error = map[string]string{"message": "Unknown tool"}
				break
			}

			arguments, ok := paramsMap["arguments"].(map[string]interface{})
			if !ok {
				response.Error = map[string]string{"message": "Invalid arguments"}
				break
			}

			name, ok := arguments["name"].(string)
			if !ok {
				response.Error = map[string]string{"message": "Name is required"}
				break
			}

			language, _ := arguments["language"].(string)
			if language == "" {
				language = "English"
			}

			var greeting string
			switch language {
			case "Spanish":
				greeting = "¡Hola, " + name + "!"
			case "French":
				greeting = "Bonjour, " + name + "!"
			case "German":
				greeting = "Hallo, " + name + "!"
			case "Japanese":
				greeting = "こんにちは, " + name + "!"
			case "Chinese":
				greeting = "你好, " + name + "!"
			case "Korean":
				greeting = "안녕하세요, " + name + "!"
			default:
				greeting = "Hello, " + name + "!"
			}

			response.Result = ToolCallResult{
				Content: []struct {
					Type string `json:"type"`
					Text string `json:"text"`
				}{
					{
						Type: "text",
						Text: greeting,
					},
				},
			}
		}

		// Send response
		responseJSON, _ := json.Marshal(response)
		fmt.Println(string(responseJSON))
	}
}
