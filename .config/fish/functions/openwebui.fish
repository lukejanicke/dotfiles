# Open WebUI
function openwebui
    # Quit any existing "openwebui" screen sessions first
    for session in (screen -ls | grep openwebui | string match -r '[0-9]+\.openwebui')
        screen -S $session -X quit
        echo "Quit session $session"
    end

    # Start a new screen session
    sleep 1
    screen -dmS openwebui fish -c '
        source ~/open-webui/bin/activate.fish
        open-webui serve
    '

    # Get the new session ID
    set -l new (screen -ls | grep openwebui | string match -r '[0-9]+\.openwebui')
    echo "Started screen session $new (detached)"

    # Wait for server to start
    echo "Starting server..."
    while not curl -s -o /dev/null -w "%{http_code}" "http://localhost:8080" | string match -q "200"
        sleep 1
    end
    echo "Server started"
    echo "Open WebUI served at http://localhost:8080"

    # Open in web app (must be set up separately)
    open -a "Open WebUI"
    return
end