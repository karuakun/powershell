$inputFilePath = "C:\temp\sample.png"

$apiKey = "{apiKey}"
$visonApiEnv = @{
    url = "https://westcentralus.api.cognitive.microsoft.com/vision/v1.0/ocr"
    headers = @{ "Content-Type" = "application/octet-stream";  "Ocp-Apim-Subscription-Key" = $apiKey}
    }
$result = Invoke-RestMethod -Uri $visonApiEnv.url -Method POST -Headers $visonApiEnv.headers -InFile $inputFilePath