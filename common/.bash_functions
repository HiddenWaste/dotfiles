gitacp() {
    # Check if a commit message was actually provided
    if [ -z "$1" ]; then
        echo "Error: You must provide a commit message."
        echo "Usage: gitacp \"your message here\""
        return 1
    fi

    git add . && \
    git commit -m "$1" && \
    git push
}
