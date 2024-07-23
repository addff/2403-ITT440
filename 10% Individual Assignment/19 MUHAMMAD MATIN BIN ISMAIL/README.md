# 🖥️ Website Analysis Shell Script Tutorial

Welcome to this comprehensive guide on writing a **complex shell script** that performs an in-depth analysis of websites! 🌐 This script checks various aspects of a website, including HTTP status, WHOIS data, DNS and IP information, and hosting details.

## 📝 Overview

In this tutorial, you'll learn how to:

1. Prompt users to enter a website URL.
2. Retrieve and process HTTP status codes.
3. Fetch and parse WHOIS information.
4. Extract DNS and IP details.
5. Determine the hosting provider.
6. Offer users the option to check additional websites or exit the script.

## 🚀 Prerequisites

Before you start, ensure you have:

- Basic knowledge of shell scripting.
- A Unix-like environment (Linux, macOS, or FreeBSD).
- Installed utilities: `curl`, `whois`, `dig` or `host`, and `awk`.

## 🛠️ Script Walkthrough

### 1. Script Initialization
Specify the shell interpreter and add a description.
```bash
#!/usr/local/bin/bash
# This script checks the HTTP status code of a web server and provides additional information.
```

### 2. Continuous User Interaction
Use a `while true` loop to allow checking multiple websites.
```bash
while true; do
  # Prompt the user to enter the website URL
  read -p "Enter the website URL (e.g., http://example.com): " URL
```

### 3. Extract Domain from URL
Extract the domain from the provided URL using `awk`.
```bash
  DOMAIN=$(echo $URL | awk -F[/:] '{print $4}')
```

### 4. Check HTTP Status Code
Retrieve the HTTP status code with `curl`.
```bash
  HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" $URL)
```

### 5. Fetch WHOIS Information
Retrieve WHOIS data for the domain.
```bash
  WHOIS_INFO=$(whois $DOMAIN)
```

### 6. Fetch DNS Information
Check if `dig` is available and use it. If not, fall back to `host`.
```bash
  if command -v dig > /dev/null 2>&1; then
    DNS_INFO=$(dig +short $DOMAIN)
  else
    DNS_INFO=$(host -t A $DOMAIN | awk '{print $4}')
  fi
```

### 7. Fetch HTTP Headers
Get HTTP headers with `curl`.
```bash
  HEADERS=$(curl -I $URL 2>/dev/null)
```

### 8. Extract Relevant WHOIS Information
Extract registrar, creation date, and location from WHOIS data.
```bash
  REGISTRAR=$(echo "$WHOIS_INFO" | grep -i "Registrar:" | head -1 | awk -F: '{print $2}' | xargs)
  CREATION_DATE=$(echo "$WHOIS_INFO" | grep -i "Creation Date:" | head -1 | awk -F: '{print $2}' | xargs)
  LOCATION=$(echo "$WHOIS_INFO" | grep -i "Country:" | head -1 | awk -F: '{print $2}' | xargs)
```

### 9. Extract IP Address and Fetch IP Location and ASN
Retrieve IP address and additional details using `ipinfo.io`.
```bash
  IP_ADDRESS=$(echo "$DNS_INFO" | grep -E "^[0-9.]+$" | head -1)
  if [ -n "$IP_ADDRESS" ]; then
    IP_INFO=$(curl -s "https://ipinfo.io/$IP_ADDRESS/json")
    IP_LOCATION=$(echo "$IP_INFO" | grep -o '"city": "[^"]*"' | sed 's/"city": "\(.*\)"/\1/')
    IP_REGION=$(echo "$IP_INFO" | grep -o '"region": "[^"]*"' | sed 's/"region": "\(.*\)"/\1/')
    ASN=$(echo "$IP_INFO" | grep -o '"org": "[^"]*"' | sed 's/"org": "\(.*\)"/\1/')
  else
    IP_ADDRESS="Unknown"
    IP_LOCATION="Unknown"
    IP_REGION="Unknown"
    ASN="Unknown"
  fi
```

### 10. Extract Hosting Provider
Parse HTTP headers to find the hosting provider.
```bash
  HOSTING_PROVIDER=$(echo "$HEADERS" | grep -i "server:" | awk '{print substr($0, index($0, $2))}' | tr -d '\r')
```

### 11. Check Domain Establishment Status
Determine if the domain is recently established.
```bash
  CURRENT_DATE=$(date +%Y-%m-%d)
  if [ -n "$CREATION_DATE" ]; then
    CREATION_DATE_UNIX=$(date -j -f "%Y-%m-%d" "${CREATION_DATE%T*}" +%s 2>/dev/null)
    CURRENT_DATE_UNIX=$(date +%s)
    ESTABLISHED_DAYS=$(( (CURRENT_DATE_UNIX - CREATION_DATE_UNIX) / 86400 ))
    if [ $ESTABLISHED_DAYS -le 365 ]; then
      ESTABLISHED_STATUS="Recently established (potential scam)"
    else
      ESTABLISHED_STATUS="Established"
    fi
  else
    ESTABLISHED_STATUS="Unknown"
  fi
```

### 12. Display Results
Output all gathered information to the user.
```bash
  echo "Website: $URL"
  echo "HTTP Status: $HTTP_STATUS"

  case "${HTTP_STATUS:0:1}" in
    2)
      echo "Success: The request was successful (status code: $HTTP_STATUS)."
      ;;
    3)
      echo "Redirection: The request was redirected (status code: $HTTP_STATUS)."
      ;;
    4)
      if [ "$HTTP_STATUS" -eq 404 ]; then
        echo "Client Error: Not Found (status code: 404)."
      else
        echo "Client Error: The request contains bad syntax or cannot be fulfilled (status code: $HTTP_STATUS)."
      fi
      ;;
    5)
      if [ "$HTTP_STATUS" -eq 500 ]; then
        echo "Server Error: Internal Server Error (status code: 500)."
      elif [ "$HTTP_STATUS" -eq 503 ]; then
        echo "Server Error: Service Unavailable (status code: 503)."
      else
        echo "Server Error: The server failed to fulfill an apparently valid request (status code: $HTTP_STATUS)."
      fi
      ;;
    *)
      echo "Unexpected status code: $HTTP_STATUS"
      ;;
  esac

  echo "Registrar: ${REGISTRAR:-Unknown}"
  echo "Creation Date: ${CREATION_DATE:-Unknown}"
  echo "Location: ${LOCATION:-Unknown}"
  echo "IP Address: ${IP_ADDRESS:-Unknown}"
  echo "IP Location: ${IP_LOCATION:-$IP_REGION}"
  echo "ASN: ${ASN:-Unknown}"
  echo "Hosting Provider: ${HOSTING_PROVIDER:-Unknown}"
  echo "Established Status: $ESTABLISHED_STATUS"
```

### 13. Continue or Exit
Prompt the user to continue checking more websites or exit.
```bash
  read -p "Do you want to check another website? (yes/no): " RESPONSE
  if [[ "$RESPONSE" != "yes" ]]; then
    echo "Exiting script."
    exit 0
  fi
done
```

## 🏃‍♂️ Running the Script

1. Create and edit the script: `vi "website_check.sh"`.
2. Press `i` to enter insert mode, paste the provided script, then press `Esc`, type `:wq`, and press `Enter` to save and exit.
3. Make it executable with: `chmod +x website_check.sh`.
4. Run the script using: `./website_check.sh`.

## 📝 Full Code

Here is the complete shell script code:

```bash
#!/usr/local/bin/bash
# This script checks the HTTP status code of a web server and provides additional information.

while true; do
  # Prompt the user to enter the website URL
  read -p "Enter the website URL (e.g., http://example.com): " URL

  # Extract domain from URL
  DOMAIN=$(echo $URL | awk -F[/:] '{print $4}')

  # Check HTTP status code
  HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" $URL)

  # Fetch WHOIS information
  WHOIS_INFO=$(whois $DOMAIN)

  # Fetch DNS information using dig (ensure dig is installed)
  if command -v dig > /dev/null 2>&1; then
    DNS_INFO=$(dig +short $DOMAIN)
  else
    DNS_INFO=$(host -t A $DOMAIN | awk '{print $4}')
  fi

  # Fetch HTTP headers
  HEADERS=$(curl -I $URL 2>/dev/null)

  # Extract relevant WHOIS information
  REGISTRAR=$(echo "$WHOIS_INFO" | grep -i "Registrar:" | head -1 | awk -F: '{print $2}' | xargs)
  CREATION_DATE=$(echo "$WHOIS_INFO" | grep -i "Creation Date:" | head -1 | awk -F: '{print $2}' | xargs)
  LOCATION=$(echo "$WHOIS_INFO" | grep -i "Country:" | head -1 | awk -F: '{print $2}' | xargs)

  # Extract IP Address and fetch IP location and ASN using ipinfo.io
  IP_ADDRESS=$(echo "$DNS_INFO" | grep -E "^[0-9.]+$" | head -1)
  if [ -n "$IP_ADDRESS" ]; then
    IP_INFO=$(curl -s "https://ipinfo.io/$IP_ADDRESS/json")
    IP_LOCATION=$(echo "$IP_INFO" | grep -o '"city": "[^"]*"' | sed 's/"city": "\(.*\)"/\1/')
    IP_REGION=$(echo "$IP_INFO" | grep -o '"region": "[^"]*"' | sed 's/"region": "\(.*\)"/\1/')
    ASN=$(echo "$IP_INFO" | grep -o '"org": "[^"]*"' | sed 's/"org": "\(.*\)"/\1/')
  else
    IP_ADDRESS="Unknown"
    IP_LOCATION="Unknown"
    IP_REGION="Unknown"
    ASN="Unknown"
  fi

  # Extract hosting provider from HTTP headers (Server header)
  HOSTING_PROVIDER=$(echo "$HEADERS" | grep -i "server:" | awk '{print substr($0, index($0, $2))}' | tr -d '\r')

  # Check if the domain is recently established
  CURRENT_DATE=$(date +%Y-%m-%d)
  if [ -n "$CREATION_DATE" ]; then
    CREATION_DATE_UNIX=$(date -j -f "%Y-%m-%d" "${CREATION_DATE%T*}" +%s 2>/dev/null)
    CURRENT_DATE_UNIX=$(date +%s)
    ESTABLISHED_DAYS=$(( (CURRENT_DATE_UNIX - CREATION_DATE_UNIX) / 86400 ))
    if [ $ESTABLISHED_DAYS -le 365 ]; then
      ESTABLISHED_STATUS="Recently established (potential scam)"
    else
      ESTABLISHED_STATUS="Established"
    fi
  else
    ESTABLISHED_STATUS="Unknown"
  fi

  # Display the results
  echo "Website: $URL"
  echo "HTTP Status: $HTTP_STATUS"

  case "${HTTP_STATUS:0:1}" in
    2)
      echo "Success: The request was successful (status code: $HTTP_STATUS)."
      ;;
    3)
      echo "Redirection: The request was redirected (status code: $HTTP_STATUS)."
      ;;
    4)
      if [ "$HTTP_STATUS" -eq 404 ]; then
        echo "Client Error: Not Found (status code: 404)."
      else
        echo "Client Error: The request contains bad syntax or cannot be fulfilled (status code: $HTTP_STATUS)."
      fi
      ;;
    5)
      if [ "$HTTP_STATUS" -eq 500 ]; then
        echo "Server Error: Internal Server Error (status code: 500)."
      elif [ "$HTTP_STATUS" -eq 503 ]; then
        echo "Server Error: Service Unavailable (status code: 503)."
      else
        echo "Server Error: The server failed to fulfill an apparently valid request (status code: $HTTP_STATUS)."
      fi
      ;;
    *)
      echo "Unexpected status code: $HTTP_STATUS"
      ;;
  esac

  echo "Registrar: ${REGISTRAR:-Unknown}"
  echo "Creation Date: ${CREATION_DATE:-Unknown}"
  echo "Location: ${LOCATION:-Unknown}"
  echo "IP Address: ${IP_ADDRESS:-Unknown}"
  echo "IP Location: ${IP_LOCATION:-$IP_REGION}"
  echo "ASN: ${ASN:-Unknown}"
  echo "Hosting Provider: ${HOSTING_PROVIDER:-Unknown}"
  echo "Established Status: $ESTABLISHED_STATUS"

  # Continue or exit
  read -p "Do you want to check another website? (yes/no): " RESPONSE
  if [[ "$RESPONSE" != "yes" ]]; then
    echo "Exiting script."
    exit 0
  fi
done
```   

## 🎉 Conclusion
Congratulations! You've created a powerful shell script that provides a comprehensive analysis of any website. Use this tool to monitor and investigate websites with ease. Feel free to modify and extend it as needed!

## 📹 Here is the Video Tutorial

[Watch the Video Tutorial](https://example.com/video-tutorial)
